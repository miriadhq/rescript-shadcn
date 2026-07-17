/**
 * Shared ReScript style transform for registry builds and docs previews.
 * Mirrors upstream apps/v4/lib/format-code.ts (style map + transformStyle).
 */

import { readFileSync, existsSync } from "node:fs"
import path from "node:path"
import { fileURLToPath } from "node:url"
import { createStyleMap, transformStyle } from "shadcn/utils"

const __dirname = path.dirname(fileURLToPath(import.meta.url))
const packageRoot = path.resolve(__dirname, "../..")
const stylesDir = path.join(packageRoot, "registry", "styles")

/** Match upstream transform-style-map allowlist — these stay as CSS hooks. */
export const CN_ALLOWLIST = new Set([
  "cn-menu-target",
  "cn-menu-translucent",
  "cn-logical-sides",
  "cn-rtl-flip",
  "cn-font-heading",
])

const styleMapCache = new Map()

export function getStyleMap(styleName) {
  const style = styleName.includes("-")
    ? styleName.split("-").slice(1).join("-")
    : styleName

  if (styleMapCache.has(style)) {
    return styleMapCache.get(style)
  }

  const cssPath = path.join(stylesDir, `style-${style}.css`)
  if (!existsSync(cssPath)) {
    styleMapCache.set(style, {})
    return {}
  }

  const styleMap = createStyleMap(readFileSync(cssPath, "utf8"))
  styleMapCache.set(style, styleMap)
  return styleMap
}

export async function transformRescriptSource(source, styleMap) {
  // registry:file skips shadcn's transformMenu; apply its default menuColor.
  source = source.replace(/\bcn-menu-(?:target|translucent)\b[ \t]*/g, "")

  let result = await transformStyle(source, { styleMap })

  // transformStyle only walks className / cva / cn() contexts. ReScript often
  // keeps cn-* in helper string literals and template heads — inline those too.
  result = result.replace(/\bcn-[\w-]+\b/g, cnClass => {
    if (CN_ALLOWLIST.has(cnClass)) return cnClass
    return styleMap[cnClass] ?? ""
  })

  return result
}

/**
 * Format ReScript source for a given style (inline cn-* → Tailwind utilities).
 */
export async function formatCode(code, styleName) {
  try {
    const styleMap = getStyleMap(styleName)
    return await transformRescriptSource(code, styleMap)
  } catch (error) {
    console.error("formatCode failed:", error)
    return code
  }
}
