import path from "node:path"
import { fileURLToPath } from "node:url"

import tailwindcss from "@tailwindcss/postcss"
import { type Plugin, defineConfig, transformWithEsbuild } from "vite"

const __dirname = path.dirname(fileURLToPath(import.meta.url))
const repoRoot = path.resolve(__dirname, "../../")
const appRoot = path.resolve(repoRoot, "shadcn-ui/apps/v4")
const harnessRoot = path.resolve(__dirname, "vite-harness")

function rescriptJsx(): Plugin {
  return {
    name: "rescript-jsx",
    async transform(code, id) {
      if (!id.endsWith(".res.mjs")) return
      return transformWithEsbuild(code, id, { loader: "jsx", jsx: "automatic" })
    },
  }
}

export default defineConfig({
  root: harnessRoot,
  plugins: [rescriptJsx()],
  esbuild: {
    jsx: "automatic",
  },
  resolve: {
    alias: {
      // shadcn-ui v4 globals import `shadcn/tailwind.css`; the `shadcn` npm package
      // (CLI v3) no longer exports that path — map to the app's theme file (same role as app/globals.css).
      "shadcn/tailwind.css": path.resolve(repoRoot, "app/tailwind.css"),
      "@": appRoot,
      "next/image": path.resolve(harnessRoot, "next-image.tsx"),
      "next/link": path.resolve(harnessRoot, "next-link.tsx"),
      "next/font/google": path.resolve(harnessRoot, "next-font-google.ts"),
      react: path.resolve(repoRoot, "node_modules/react"),
      "react-dom/client": path.resolve(repoRoot, "node_modules/react-dom/client.js"),
      "react-dom/server": path.resolve(repoRoot, "node_modules/react-dom/server.browser.js"),
      "react-dom": path.resolve(repoRoot, "node_modules/react-dom"),
    },
  },
  css: {
    postcss: {
      plugins: [tailwindcss()],
    },
  },
  server: {
    host: "127.0.0.1",
    fs: {
      allow: [repoRoot],
    },
  },
})
