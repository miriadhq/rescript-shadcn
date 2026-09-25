/**
 * Shared ReScript style transform for registry builds and docs previews.
 * Mirrors upstream apps/v4/lib/format-code.ts (style map + transformStyle).
 */

import { execFile } from "node:child_process"
import { readFileSync } from "node:fs"
import { createRequire } from "node:module"
import path from "node:path"
import { createStyleMap, transformStyle } from "shadcn/utils"

const stylesDir = path.join(process.cwd(), "registry", "styles")

const styleMapCache = new Map()

const require = createRequire(import.meta.url)
const formatterPath = path.join(
  path.dirname(require.resolve(`@rescript/${process.platform}-${process.arch}`)),
  "bin",
  "rescript.exe",
)

function formatRescript(source) {
  return new Promise((resolve, reject) => {
    const child = execFile(formatterPath, ["format", "--stdin", ".res"],
      { encoding: "utf8", maxBuffer: 10 * 1024 * 1024 },
      (error, stdout) => error ? reject(error) : resolve(stdout),
    )
    child.stdin.on("error", reject)
    child.stdin.end(source)
  })
}

// These upstream hooks add no utilities in any of our styles. Keep this list
// explicit: deriving it from component sources would also bless misspellings.
const emptyHooks = [
  "cn-accordion-trigger-icon",
  "cn-alert-dialog-action",
  "cn-alert-dialog-cancel",
  "cn-attachment-action",
  "cn-attachment-media-variant-icon",
  "cn-avatar-group",
  "cn-breadcrumb",
  "cn-calendar-day-button",
  "cn-card-action",
  "cn-chart",
  "cn-combobox-chip-indicator-icon",
  "cn-combobox-chip-input",
  "cn-combobox-clear",
  "cn-combobox-clear-icon",
  "cn-combobox-group",
  "cn-combobox-input",
  "cn-combobox-item-indicator-icon",
  "cn-command-item-indicator",
  "cn-context-menu-trigger",
  "cn-drawer-content-base",
  "cn-field-orientation-horizontal",
  "cn-field-orientation-responsive",
  "cn-field-orientation-vertical",
  "cn-input-otp-caret",
  "cn-input-otp-input",
  "cn-marker-variant-default",
  "cn-markdown",
  "cn-message-scroller",
  "cn-message-scroller-button",
  "cn-message-scroller-item",
  "cn-message-scroller-viewport",
  "cn-native-select-wrapper",
  "cn-navigation-menu-item",
  "cn-pagination",
  "cn-pagination-link",
  "cn-pagination-next-text",
  "cn-pagination-previous-text",
  "cn-progress-root",
  "cn-questionnaire-choice-input",
  "cn-questionnaire-choice-label",
  "cn-questionnaire-choice-shortcut",
  "cn-questionnaire-next",
  "cn-questionnaire-previous",
  "cn-questionnaire-skip",
  "cn-questionnaire-submit",
  "cn-resizable-handle",
  "cn-resizable-panel-group",
  "cn-scroll-area",
  "cn-scroll-area-viewport",
  "cn-select-item-indicator-icon",
  "cn-sidebar-trigger",
  "cn-tabs-list-variant-default",
  "cn-tabs-list-variant-line",
]

// Other hooks are deliberately unstyled only in these specific styles.
const emptyHooksByStyle = {
  "cn-accordion": ["lyra", "nova", "sera", "vega"],
  "cn-alert-dialog-footer": ["luma", "lyra", "maia", "mira", "rhea", "sera", "vega"],
  "cn-button-group-orientation-horizontal": ["lyra"],
  "cn-button-group-orientation-vertical": ["lyra"],
  "cn-calendar-caption": ["luma", "lyra", "maia", "mira", "nova", "rhea", "vega"],
  "cn-carousel-next": ["lyra", "sera"],
  "cn-carousel-previous": ["lyra", "sera"],
  "cn-dialog-footer": ["lyra"],
  "cn-input-group-addon-align-inline-end": ["sera"],
  "cn-input-group-addon-align-inline-start": ["sera"],
  "cn-input-group-button-size-sm": ["luma", "maia", "nova", "rhea", "sera", "vega"],
  "cn-tabs-trigger-aria": ["luma", "lyra", "maia", "mira", "rhea", "sera"],
}

// registry:file bypasses the CLI's install-time font/menu/RTL transforms.
const sharedHooks = {
  "cn-font-heading": "font-heading",
  "cn-menu-target": "", // Default menu color.
  "cn-menu-translucent": "", // Default menu color is opaque.
  "cn-rtl-flip": "", // The published registry uses upstream's default LTR mode.
}

export function getStyleMap(styleName) {
  const style = styleName.includes("-")
    ? styleName.split("-").slice(1).join("-")
    : styleName

  if (styleMapCache.has(style)) {
    return styleMapCache.get(style)
  }

  const cssPath = path.join(stylesDir, `style-${style}.css`)
  const styleMap = {
    ...Object.fromEntries(emptyHooks.map(hook => [hook, ""])),
    ...Object.fromEntries(Object.entries(emptyHooksByStyle)
      .filter(([, styles]) => styles.includes(style))
      .map(([hook]) => [hook, ""])),
    ...createStyleMap(readFileSync(cssPath, "utf8")),
  }
  styleMapCache.set(style, styleMap)
  return styleMap
}

export async function transformRescriptSource(source, styleMap) {
  // Validate before transformStyle, which also silently drops unknown hooks.
  for (const hook of new Set(source.match(/\bcn-[\w-]+\b/g) ?? [])) {
    if (!Object.hasOwn(sharedHooks, hook) && !Object.hasOwn(styleMap, hook)) {
      throw new Error(`Unresolved style hook: ${hook}`)
    }
  }
  source = source.replace(/\bcn-[\w-]+\b/g, hook =>
    Object.hasOwn(sharedHooks, hook) ? sharedHooks[hook] : hook
  )

  let result = await transformStyle(source, { styleMap })

  // transformStyle only walks className / cva / cn() contexts. ReScript often
  // keeps cn-* in helper string literals and template heads — inline those too.
  result = result.replace(/\bcn-[\w-]+\b/g, cnClass => {
    if (!Object.hasOwn(styleMap, cnClass)) {
      throw new Error(`Unresolved style hook: ${cnClass}`)
    }
    return styleMap[cnClass]
  })

  return formatRescript(result)
}

/**
 * Inline cn-* → Tailwind utilities, then format the resulting ReScript source.
 */
export async function formatCode(code, styleName) {
  return transformRescriptSource(code, getStyleMap(styleName))
}
