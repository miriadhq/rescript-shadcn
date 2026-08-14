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
  cacheDir: path.resolve(repoRoot, "test/artifacts/pixel-perfect/.vite"),
  plugins: [rescriptJsx()],
  esbuild: {
    jsx: "automatic",
  },
  resolve: {
    alias: {
      // Upstream examples import the generated base-nova style tree. The parity
      // harness compares the source Base implementation, so resolve that
      // virtual/generated path directly to the checked-in Base registry.
      "@/styles/base-nova": path.resolve(
        repoRoot,
        "shadcn-ui/apps/v4/registry/bases/base"
      ),
      // shadcn-ui v4 globals import `shadcn/tailwind.css`; the `shadcn` npm package
      // (CLI v3) no longer exports that path — map to the app's theme file (same role as app/globals.css).
      "shadcn/tailwind.css": path.resolve(repoRoot, "app/tailwind.css"),
      "shadcn/preset": path.resolve(repoRoot, "shadcn-ui/packages/shadcn/src/preset/index.ts"),
      "@/app/(app)/create/components/icon-placeholder": path.resolve(
        harnessRoot,
        "icon-placeholder.tsx"
      ),
      "@/app/(create)/components/icon-placeholder": path.resolve(
        harnessRoot,
        "icon-placeholder.tsx"
      ),
      "@": appRoot,
      "next/image": path.resolve(harnessRoot, "next-image.tsx"),
      "next/link": path.resolve(harnessRoot, "next-link.tsx"),
      "next/font/google": path.resolve(harnessRoot, "next-font-google.ts"),
      react: path.resolve(repoRoot, "node_modules/react"),
    },
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
