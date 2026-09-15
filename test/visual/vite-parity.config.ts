import path from "node:path"
import { readFileSync } from "node:fs"
import { fileURLToPath } from "node:url"

import { upstreamAliases, upstreamRtl, upstreamParityFixes } from "./upstream-resolver.mjs"

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
  publicDir: path.join(appRoot, "public"),
  // Preserve prebundles across runs without sharing writes with another parity server.
  cacheDir: path.resolve(repoRoot, "node_modules/.vite/pixel-perfect", process.env.PARITY_TEST_PORT ?? "4173"),
  plugins: [upstreamRtl(), upstreamParityFixes(), rescriptJsx()],
  esbuild: {
    jsx: "automatic",
  },
  resolve: {
    dedupe: Object.keys(JSON.parse(readFileSync(path.join(repoRoot, "package.json"), "utf8")).dependencies),
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
      "lucide-react",
      "@tabler/icons-react",
      "recharts",
      "ai",
      "@ai-sdk/react",
      "@tanstack/ai-react",
      "streamdown",
      "@streamdown/code",
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
