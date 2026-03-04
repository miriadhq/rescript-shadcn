import path from "node:path"
import { fileURLToPath } from "node:url"

import tailwindcss from "@tailwindcss/postcss"
import { defineConfig } from "vite"

const __dirname = path.dirname(fileURLToPath(import.meta.url))
const repoRoot = path.resolve(__dirname, "../../")
const appRoot = path.resolve(repoRoot, "shadcn-ui/apps/v4")
const harnessRoot = path.resolve(__dirname, "vite-harness")

export default defineConfig({
  root: harnessRoot,
  plugins: [],
  esbuild: {
    jsx: "automatic",
  },
  resolve: {
    alias: {
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
