#!/usr/bin/env node

import { existsSync, readFileSync, readdirSync, writeFileSync } from "node:fs"
import path from "node:path"
import rescriptJson from "../rescript.json" with { type: "json" }

const suffix = rescriptJson.suffix

const packageRoot = new URL("..", import.meta.url).pathname
const baseDir = path.join(packageRoot, "registry", "base")
const registryPath = path.join(packageRoot, "registry.json")

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

/** Known npm packages that are implicitly available */
const IMPLICIT_PACKAGES = new Set([
  "react",
  "react/jsx-runtime",
  "react-dom",
  "react-dom/client",
  "@rescript/runtime",
  "@rescript/react",
  "tailwind-merge",
])

/** Extract npm package name: "@base-ui/react/accordion" → "@base-ui/react" */
function extractNpmPackage(specifier) {
  if (specifier.startsWith("@")) {
    const parts = specifier.split("/")
    return `${parts[0]}/${parts[1]}`
  }
  return specifier.split("/")[0]
}

/** Parse ES module imports from a .mjs file */
function parseImports(jsPath) {
  const npmPackages = new Set()
  const localImports = new Set()

  if (!existsSync(jsPath)) return { npmPackages, localImports }

  const content = readFileSync(jsPath, "utf8")
  const importRegex =
    /import\s+(?:\*\s+as\s+[\w$]+|[\w$]+|\{[^}]*\})\s+from\s+"([^"]+)"/g
  let match
  while ((match = importRegex.exec(content)) !== null) {
    const specifier = match[1]
    if (specifier.startsWith("./") || specifier.startsWith("../")) {
      localImports.add(specifier)
    } else {
      if (
        !IMPLICIT_PACKAGES.has(specifier) &&
        !specifier.startsWith("@rescript/")
      ) {
        npmPackages.add(extractNpmPackage(specifier))
      }
    }
  }

  return { npmPackages, localImports }
}

// ---------------------------------------------------------------------------
// Scan directories
// ---------------------------------------------------------------------------

/** List .res files in a directory (basenames without extension) */
function listResFiles(dir) {
  if (!existsSync(dir)) return []
  return readdirSync(dir)
    .filter((f) => f.endsWith(".res"))
    .map((f) => f.slice(0, -4)) // strip .res
    .sort()
}

const uiModules = listResFiles(path.join(baseDir, "ui"))
const rtlModules = listResFiles(path.join(baseDir, "ui-rtl"))
const exampleModules = listResFiles(path.join(baseDir, "examples"))

// Build a map: relative .res path (from rescript/) → registry item name
// e.g. "ui/Accordion.res" → "accordion"
const pathToName = new Map()
for (const mod of uiModules) {
  pathToName.set(`ui/${mod}.res`, mod)
}
for (const mod of rtlModules) {
  pathToName.set(`ui-rtl/${mod}.res`, mod)
}
for (const mod of exampleModules) {
  pathToName.set(`examples/${mod}.res`, mod)
}

/** Resolve a local import to a registry item name.
 *  importPath: the raw import string, e.g. "../ui/Button.res.mjs" or "./Foo.res.mjs"
 *  fromDir: the directory of the importing file, e.g. "ui", "ui-rtl", "examples"
 */
function resolveLocalImport(importPath, fromDir) {
  const toResPath = importPath.replace(suffix, ".res")
  // Resolve relative to fromDir
  const resolved = path.normalize(path.join(fromDir, toResPath))
  return pathToName.get(resolved) ?? null
}

// ---------------------------------------------------------------------------
// Build items
// ---------------------------------------------------------------------------

/** Build a registry item from a .res file */
function buildItem(mod, dir, type) {
  const resPath = `${dir}/${mod}.res`
  const jsPath = path.join(baseDir, `${dir}/${mod}${suffix}`)
  const name = mod

  const { npmPackages, localImports } = parseImports(jsPath)

  // Resolve local imports to registry dependency names
  const registryDeps = []
  for (const imp of [...localImports].sort()) {
    const depName = resolveLocalImport(imp, dir)
    if (depName) registryDeps.push(depName)
  }

  const item = { name, type }

  const sortedNpmDeps = [...npmPackages].sort()
  if (sortedNpmDeps.length > 0) item.dependencies = sortedNpmDeps
  if (registryDeps.length > 0)
    item.registryDependencies = registryDeps.sort()

  item.files = [{ path: resPath, type }]

  return item
}

// Build all items
const items = [
  ...uiModules.map((mod) => buildItem(mod, "ui", "registry:ui")),
  ...rtlModules.map((mod) => buildItem(mod, "ui-rtl", "registry:ui")),
  ...exampleModules.map((mod) =>
    buildItem(mod, "examples", "registry:example")
  ),
]

const registry = {
  name: "rescript-shadcn",
  homepage: "https://github.com/miriadhq/rescript-shadcn",
  items,
}

const output = JSON.stringify(registry, null, 2) + "\n"

// ---------------------------------------------------------------------------
// --check mode or write
// ---------------------------------------------------------------------------

const isCheck = process.argv.includes("--check")

if (isCheck) {
  const current = existsSync(registryPath)
    ? readFileSync(registryPath, "utf8")
    : ""
  if (current !== output) {
    console.error(
      "registry.json is out of date. Run `node scripts/generate-registry.mjs` to regenerate."
    )
    process.exit(1)
  }
  console.log("registry.json is up to date.")
} else {
  writeFileSync(registryPath, output)
  console.log(`Wrote ${registryPath}`)
}
