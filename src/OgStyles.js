export const DEFAULT_STYLE = "vega";
export const STYLES = ["vega", "nova", "lyra", "maia", "mira", "luma", "sera", "rhea"];

const STYLE_SET = new Set(STYLES);

export function getStyleName(value) {
  const style = typeof value === "string" ? value : value?.style;
  return STYLE_SET.has(style) ? style : DEFAULT_STYLE;
}

export function getOgImagePath(slug, styleName) {
  return styleName === DEFAULT_STYLE
    ? `/og/components/${slug}.png`
    : `/og/components/${styleName}/${slug}.png`;
}
