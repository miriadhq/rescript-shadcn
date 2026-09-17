export const DEFAULT_STYLE = "vega";
export const STYLES = ["vega", "nova", "lyra", "maia", "mira", "luma", "sera", "rhea"];
export const DEFAULT_LIB = "base";
export const LIBS = ["base", "aria"];
export const DEFAULT_SELECTION = `${DEFAULT_LIB}-${DEFAULT_STYLE}`;

const STYLE_SET = new Set(STYLES);
const LIB_SET = new Set(LIBS);

export function parseSelection(value) {
  const raw = typeof value === "string" ? value : value?.style;
  if (raw === undefined) return { lib: DEFAULT_LIB, style: DEFAULT_STYLE };
  if (typeof raw !== "string") return null;
  const [candidateLib, candidateStyle, extra] = raw.split("-");

  if (extra === undefined && LIB_SET.has(candidateLib) && STYLE_SET.has(candidateStyle)) {
    return { lib: candidateLib, style: candidateStyle };
  }

  if (STYLE_SET.has(raw)) {
    return { lib: DEFAULT_LIB, style: raw };
  }

  return null;
}

export function getSelection(value) {
  return parseSelection(value) ?? { lib: DEFAULT_LIB, style: DEFAULT_STYLE };
}

export function getSelectionName(value) {
  const { lib, style } = getSelection(value);
  return `${lib}-${style}`;
}

export function getStyleName(value) {
  return getSelection(value).style;
}

export function getRegistryUiNames(registry) {
  return (registry?.items ?? [])
    .filter((item) => item.type === "registry:ui")
    .map((item) => item.name);
}

export function getOgComponentSlugs(basePages, ariaPages) {
  return [...new Set([...(basePages ?? []), ...(ariaPages ?? [])])];
}

export function getOgRenderLib(slug, baseComponents, ariaComponents) {
  if ((baseComponents ?? []).includes(slug)) {
    return "base";
  }

  if ((ariaComponents ?? []).includes(slug)) {
    return "aria";
  }

  return DEFAULT_LIB;
}

export function getOgImagePath(slug, styleName) {
  return styleName === DEFAULT_STYLE
    ? `/og/components/${slug}.png`
    : `/og/components/${styleName}/${slug}.png`;
}
