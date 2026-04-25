#!/usr/bin/env node

import { existsSync, readFileSync, readdirSync, writeFileSync } from "node:fs"
import path from "node:path"
import rescriptJson from "../rescript.json" with { type: "json" }

const suffix = rescriptJson.suffix

const packageRoot = new URL("..", import.meta.url).pathname
const baseDir = path.join(packageRoot, "registry", "base")
const registryPath = path.join(packageRoot, "registry.json")
const registryNamespace = "@rescript-shadcn"

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
const base = "registry/base"
const pathToName = new Map()
for (const mod of uiModules) {
  pathToName.set(`${base}/ui/${mod}.res`, mod)
}
for (const mod of rtlModules) {
  pathToName.set(`${base}/ui-rtl/${mod}.res`, mod)
}
for (const mod of exampleModules) {
  pathToName.set(`${base}/examples/${mod}.res`, mod)
}

const astDir = path.join(packageRoot, "lib", "ocaml")

/** Modules to ignore in .ast dependency lists */
const IGNORED_AST_DEPS = new Set([
  "BaseUi",
  "React",
  "ReactDOM",
])

/** Build a set of all known registry module names for matching .ast deps */
const registryModules = new Set([...uiModules, ...rtlModules, ...exampleModules])

/** Parse compile-time dependencies from a .ast file in lib/ocaml/.
 *  Format: 4-byte header, then \n-separated module names, then \n followed
 *  by the absolute .res path, then \n followed by binary AST data.
 */
function parseAstDeps(mod) {
  const astPath = path.join(astDir, `${mod}.ast`)
  if (!existsSync(astPath)) {
    console.error(
      `Missing ${astPath}\nRun the ReScript compiler first: yarn rescript`
    )
    process.exit(1)
  }

  const buf = readFileSync(astPath)
  // Skip the 4-byte header, deps start after first \n
  const start = buf.indexOf(0x0a, 0)
  if (start === -1) return []

  // Find where the .res path starts (begins with /)
  // All dep names are between start and the path line
  const deps = []
  let pos = start + 1
  while (pos < buf.length) {
    const nextNewline = buf.indexOf(0x0a, pos)
    if (nextNewline === -1) break
    const token = buf.subarray(pos, nextNewline).toString("utf8")
    // The .res file path starts with / — that marks the end of deps
    if (token.startsWith("/")) break
    deps.push(token)
    pos = nextNewline + 1
  }

  return deps.filter(
    (dep) => !IGNORED_AST_DEPS.has(dep) && registryModules.has(dep)
  )
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
  const jsPath = path.join(packageRoot, `${dir}/${mod}${suffix}`)
  const name = mod

  const { npmPackages, localImports } = parseImports(jsPath)

  // Resolve local imports to registry dependency names
  const registryDepsSet = new Set()
  for (const imp of localImports) {
    const depName = resolveLocalImport(imp, dir)
    if (depName) registryDepsSet.add(depName)
  }

  // Also add compile-time deps from .ast (catches type-only dependencies)
  for (const dep of parseAstDeps(mod)) {
    registryDepsSet.add(dep)
  }

  const registryDeps = [...registryDepsSet]
    .map((dep) => `${registryNamespace}/${dep}`)
    .sort()

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
  ...uiModules.map((mod) => buildItem(mod, `${base}/ui`, "registry:ui")),
  ...rtlModules.map((mod) => buildItem(mod, `${base}/ui-rtl`, "registry:ui")),
  ...exampleModules.map((mod) =>
    buildItem(mod, `${base}/examples`, "registry:example")
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
