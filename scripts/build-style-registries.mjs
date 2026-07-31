#!/usr/bin/env node

/**
 * Builds one shadcn registry per lib/style selection under
 * public/r/styles/{lib}-{style}/.
 *
 * Flow (mirrors upstream shadcn-ui/apps/v4/scripts/build-registry.mts):
 * 1. Read registry.{base,aria}.json (metadata + file paths with cn-* source)
 * 2. For each style CSS: createStyleMap + transformStyle (+ leftover cn-* pass)
 * 3. Write transformed files to .registry-build/{lib}-{style}/
 * 4. shadcn build → public/r/styles/{lib}-{style}/
 * 5. Mirror base-nova to public/r/ for the existing flat index URL
 */

import { spawn } from "node:child_process"
import {
  cpSync,
  existsSync,
  mkdirSync,
  readFileSync,
  readdirSync,
  rmSync,
  writeFileSync,
} from "node:fs"
import path from "node:path"
import { fileURLToPath } from "node:url"
import {
  getStyleMap,
  transformRescriptSource,
} from "../src/lib/format-code.mjs"

const __dirname = path.dirname(fileURLToPath(import.meta.url))
const packageRoot = path.resolve(__dirname, "..")

const LIBS = ["base", "aria"]
const stylesDir = path.join(packageRoot, "registry", "styles")
const buildRoot = path.join(packageRoot, ".registry-build")
const publicStylesRoot = path.join(packageRoot, "public", "r", "styles")
const publicFlatRoot = path.join(packageRoot, "public", "r")

const DEFAULT_FLAT_SELECTION = "base-nova"
const STYLE_BUILD_CONCURRENCY = 2

function toPascalCase(value) {
  return value
    .split("-")
    .map((part) => part.charAt(0).toUpperCase() + part.slice(1))
    .join("")
}

function listStyles() {
  if (!existsSync(stylesDir)) return []
  return readdirSync(stylesDir)
    .filter((f) => /^style-[a-z0-9-]+\.css$/.test(f))
    .map((f) => f.slice("style-".length, -".css".length))
    .sort()
}

function parseStyleFilter(argv) {
  const idx = argv.indexOf("--style")
  if (idx === -1) return null
  const value = argv[idx + 1]
  if (!value || value.startsWith("-")) {
    console.error("Usage: build-style-registries.mjs [--style <lib>-<style>|all]")
    process.exit(1)
  }
  return value === "all" ? null : value
}

async function runWithConcurrency(items, concurrency, worker) {
  const results = new Array(items.length)
  let next = 0

  async function run() {
    while (next < items.length) {
      const index = next++
      results[index] = await worker(items[index], index)
    }
  }

  await Promise.all(
    Array.from({ length: Math.min(concurrency, items.length) }, () => run())
  )
  return results
}

function shadcnBuild(registryPath, outputDir, cwd) {
  return new Promise((resolve, reject) => {
    const proc = spawn(
      "yarn",
      ["shadcn", "build", registryPath, "--output", outputDir],
      { cwd, stdio: ["ignore", "pipe", "pipe"] }
    )
    let stdout = ""
    let stderr = ""
    proc.stdout?.on("data", (d) => {
      stdout += d
    })
    proc.stderr?.on("data", (d) => {
      stderr += d
    })
    proc.on("close", (code) => {
      if (code !== 0) {
        reject(
          new Error(
            `shadcn build failed (exit ${code})\n${stderr || stdout}`
          )
        )
      } else {
        resolve()
      }
    })
    proc.on("error", reject)
  })
}

function filterRegistryForStyle(registry, styleName) {
  const styleItemName = `Style${toPascalCase(styleName)}`
  return {
    ...registry,
    items: registry.items.filter((item) => {
      if (item.type === "registry:style") {
        return item.name === styleItemName
      }
      return true
    }),
  }
}

async function writeTransformedTree(selectionName, styleName, styleMap, registry) {
  const styleBuildDir = path.join(buildRoot, selectionName)
  rmSync(styleBuildDir, { recursive: true, force: true })
  mkdirSync(styleBuildDir, { recursive: true })

  const files = new Map()
  for (const item of registry.items) {
    for (const file of item.files ?? []) {
      if (file.path) files.set(file.path, file)
    }
  }

  for (const filePath of files.keys()) {
    const sourcePath = path.join(packageRoot, filePath)
    if (!existsSync(sourcePath)) {
      throw new Error(`Missing source file: ${filePath}`)
    }

    const source = readFileSync(sourcePath, "utf8")
    const ext = path.extname(filePath)
    const content =
      ext === ".res" ? await transformRescriptSource(source, styleMap) : source

    const outPath = path.join(styleBuildDir, filePath)
    mkdirSync(path.dirname(outPath), { recursive: true })
    writeFileSync(outPath, content)
  }

  const registryOut = filterRegistryForStyle(registry, styleName)
  const registryOutPath = path.join(styleBuildDir, "registry.json")
  writeFileSync(registryOutPath, JSON.stringify(registryOut, null, 2) + "\n")

  return { styleBuildDir, registryOutPath }
}

async function buildSelection({ lib, style: styleName }, registry) {
  const selectionName = `${lib}-${styleName}`
  const cssPath = path.join(stylesDir, `style-${styleName}.css`)
  if (!existsSync(cssPath)) {
    throw new Error(`Missing style CSS: ${cssPath}`)
  }

  const styleMap = getStyleMap(styleName)
  const { styleBuildDir } = await writeTransformedTree(
    selectionName,
    styleName,
    styleMap,
    registry
  )

  const outputDir = path.join(publicStylesRoot, selectionName)
  rmSync(outputDir, { recursive: true, force: true })
  mkdirSync(outputDir, { recursive: true })

  await shadcnBuild("registry.json", outputDir, styleBuildDir)
  console.log(`   ✅ ${selectionName} → public/r/styles/${selectionName}`)
}

function mirrorFlatRegistry(styleName) {
  const styleDir = path.join(publicStylesRoot, styleName)
  if (!existsSync(styleDir)) {
    console.warn(
      `Skipping flat mirror: public/r/styles/${styleName} does not exist`
    )
    return
  }

  // Keep style-specific trees; copy only top-level JSON into public/r/.
  for (const entry of readdirSync(publicFlatRoot)) {
    if (entry === "styles") continue
    rmSync(path.join(publicFlatRoot, entry), { recursive: true, force: true })
  }

  for (const entry of readdirSync(styleDir)) {
    cpSync(path.join(styleDir, entry), path.join(publicFlatRoot, entry), {
      recursive: true,
    })
  }

  console.log(
    `   ✅ mirrored public/r/styles/${styleName} → public/r/ (flat index backcompat)`
  )
}

async function main() {
  const registries = new Map()
  for (const lib of LIBS) {
    const registryPath = path.join(packageRoot, `registry.${lib}.json`)
    if (!existsSync(registryPath)) {
      console.error(`${path.basename(registryPath)} missing. Run \`yarn registry:generate\` first.`)
      process.exit(1)
    }
    registries.set(lib, JSON.parse(readFileSync(registryPath, "utf8")))
  }
  const allStyles = listStyles()
  if (allStyles.length === 0) {
    console.error("No style-*.css files found in registry/styles")
    process.exit(1)
  }

  const styleFilter = parseStyleFilter(process.argv)
  const selections = LIBS.flatMap((lib) =>
    allStyles.map((style) => ({ lib, style, name: `${lib}-${style}` }))
  )
  const selected = styleFilter
    ? selections.filter(({ name }) => name === styleFilter)
    : selections

  if (selected.length === 0) {
    console.error(
      `Unknown lib/style "${styleFilter}". Available: ${selections.map(({ name }) => name).join(", ")}`
    )
    process.exit(1)
  }

  console.log(`Building ${selected.length} lib/style registries…`)
  mkdirSync(publicStylesRoot, { recursive: true })

  await runWithConcurrency(selected, STYLE_BUILD_CONCURRENCY, async (selection) => {
    console.log(`   ⏳ ${selection.name}…`)
    await buildSelection(selection, registries.get(selection.lib))
  })

  if (selected.some(({ name }) => name === DEFAULT_FLAT_SELECTION) || !styleFilter) {
    if (existsSync(path.join(publicStylesRoot, DEFAULT_FLAT_SELECTION))) {
      mirrorFlatRegistry(DEFAULT_FLAT_SELECTION)
    }
  }

  console.log("Done.")
}

main().catch((error) => {
  console.error(error)
  process.exit(1)
})
