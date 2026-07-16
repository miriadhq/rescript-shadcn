#!/usr/bin/env node

/**
 * Builds one shadcn registry per style under public/r/styles/{style}/.
 *
 * Flow (mirrors upstream shadcn-ui/apps/v4/scripts/build-registry.mts):
 * 1. Read registry.json (metadata + file paths with cn-* source)
 * 2. For each style CSS: createStyleMap + transformStyle (+ leftover cn-* pass)
 * 3. Write transformed files to .registry-build/{style}/
 * 4. shadcn build → public/r/styles/{style}/
 * 5. Mirror default style (nova) to public/r/ for the existing flat index URL
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
import { createStyleMap, transformStyle } from "shadcn/utils"

const __dirname = path.dirname(fileURLToPath(import.meta.url))
const packageRoot = path.resolve(__dirname, "..")

const registryJsonPath = path.join(packageRoot, "registry.json")
const stylesDir = path.join(packageRoot, "registry", "styles")
const buildRoot = path.join(packageRoot, ".registry-build")
const publicStylesRoot = path.join(packageRoot, "public", "r", "styles")
const publicFlatRoot = path.join(packageRoot, "public", "r")

/** Match upstream transform-style-map allowlist — these stay as CSS hooks. */
const CN_ALLOWLIST = new Set([
  "cn-menu-target",
  "cn-menu-translucent",
  "cn-logical-sides",
  "cn-rtl-flip",
  "cn-font-heading",
])

const DEFAULT_FLAT_STYLE = "nova"
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
    console.error("Usage: build-style-registries.mjs [--style <name|all>]")
    process.exit(1)
  }
  return value === "all" ? null : value
}

async function transformRescriptSource(source, styleMap) {
  let result = await transformStyle(source, { styleMap })

  // transformStyle only walks className / cva / cn() contexts. ReScript often
  // keeps cn-* in helper string literals and template heads — inline those too.
  result = result.replace(/\bcn-[\w-]+\b/g, (cnClass) => {
    if (CN_ALLOWLIST.has(cnClass)) return cnClass
    return styleMap[cnClass] ?? ""
  })

  return result
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

async function writeTransformedTree(styleName, styleMap, registry) {
  const styleBuildDir = path.join(buildRoot, styleName)
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

async function buildStyle(styleName, registry) {
  const cssPath = path.join(stylesDir, `style-${styleName}.css`)
  if (!existsSync(cssPath)) {
    throw new Error(`Missing style CSS: ${cssPath}`)
  }

  const styleMap = createStyleMap(readFileSync(cssPath, "utf8"))
  const { styleBuildDir } = await writeTransformedTree(
    styleName,
    styleMap,
    registry
  )

  const outputDir = path.join(publicStylesRoot, styleName)
  rmSync(outputDir, { recursive: true, force: true })
  mkdirSync(outputDir, { recursive: true })

  await shadcnBuild("registry.json", outputDir, styleBuildDir)
  console.log(`   ✅ ${styleName} → public/r/styles/${styleName}`)
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
  if (!existsSync(registryJsonPath)) {
    console.error(
      "registry.json missing. Run `yarn registry:generate` first."
    )
    process.exit(1)
  }

  const registry = JSON.parse(readFileSync(registryJsonPath, "utf8"))
  const allStyles = listStyles()
  if (allStyles.length === 0) {
    console.error("No style-*.css files found in registry/styles")
    process.exit(1)
  }

  const styleFilter = parseStyleFilter(process.argv)
  const styles = styleFilter
    ? allStyles.filter((s) => s === styleFilter)
    : allStyles

  if (styles.length === 0) {
    console.error(
      `Unknown style "${styleFilter}". Available: ${allStyles.join(", ")}`
    )
    process.exit(1)
  }

  console.log(`Building ${styles.length} style registries…`)
  mkdirSync(publicStylesRoot, { recursive: true })

  await runWithConcurrency(styles, STYLE_BUILD_CONCURRENCY, async (style) => {
    console.log(`   ⏳ ${style}…`)
    await buildStyle(style, registry)
  })

  if (styles.includes(DEFAULT_FLAT_STYLE) || !styleFilter) {
    if (existsSync(path.join(publicStylesRoot, DEFAULT_FLAT_STYLE))) {
      mirrorFlatRegistry(DEFAULT_FLAT_STYLE)
    }
  }

  console.log("Done.")
}

main().catch((error) => {
  console.error(error)
  process.exit(1)
})
