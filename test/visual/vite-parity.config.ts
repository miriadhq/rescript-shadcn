import path from "node:path"
import { fileURLToPath } from "node:url"

import { upstreamAliases, upstreamRtl } from "./upstream-resolver.mjs"

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
  cacheDir: path.resolve(repoRoot, "test/artifacts/pixel-perfect/.vite"),
  plugins: [upstreamRtl(), rescriptJsx()],
  esbuild: {
    jsx: "automatic",
  },
  resolve: {
    alias: [
      ...upstreamAliases,
      // shadcn-ui v4 globals import `shadcn/tailwind.css`; the `shadcn` npm package
      // (CLI v3) no longer exports that path — map to the app's theme file (same role as app/globals.css).
      { find: "shadcn/tailwind.css", replacement: path.resolve(repoRoot, "app/tailwind.css") },
      { find: "shadcn/preset", replacement: path.resolve(repoRoot, "shadcn-ui/packages/shadcn/src/preset/index.ts") },
      { find: "@/app/(app)/create/components/icon-placeholder", replacement: path.resolve(
        harnessRoot,
        "icon-placeholder.tsx"
      ) },
      { find: "@/app/(create)/components/icon-placeholder", replacement: path.resolve(
        harnessRoot,
        "icon-placeholder.tsx"
      ) },
      { find: "@", replacement: appRoot },
      { find: "next/image", replacement: path.resolve(harnessRoot, "next-image.tsx") },
      { find: "next/link", replacement: path.resolve(harnessRoot, "next-link.tsx") },
      { find: "next/font/google", replacement: path.resolve(harnessRoot, "next-font-google.ts") },
      { find: "react", replacement: path.resolve(repoRoot, "node_modules/react") },
    ],
  },
  css: {
    postcss: {
      plugins: [tailwindcss()],
    },
  },
  optimizeDeps: {
    noDiscovery: true,
    include: [
      "react",
      "react/jsx-runtime",
      "react/jsx-dev-runtime",
      "react-dom",
      "react-dom/client",
      "use-sync-external-store/shim",
      "use-sync-external-store/shim/index.js",
      "use-sync-external-store/shim/with-selector",
    ],
  },
  server: {
    host: "127.0.0.1",
    fs: {
      allow: [repoRoot],
    },
  },
})
