import { readFileSync } from "node:fs"
import { createRequire } from "node:module"
import { runInNewContext } from "node:vm"
import ts from "typescript"
import { expect, test } from "vitest"
import * as ogStyles from "../src/OgStyles.js"

const require = createRequire(import.meta.url)
function loadRoute(relativePath: string) {
  const source = readFileSync(new URL(relativePath, import.meta.url), "utf8")
  const { outputText } = ts.transpileModule(source, {
    fileName: "page.jsx",
    compilerOptions: { module: ts.ModuleKind.CommonJS, jsx: ts.JsxEmit.ReactJSX },
  })
  const imports: string[] = []
  const route: Record<string, any> = {}
  runInNewContext(outputText, {
    exports: route,
    process,
    URL,
    require(id: string) {
      if (id.endsWith(".mdx")) {
        imports.push(id)
        return { default: () => null, frontmatter: { title: "Test", description: "Test doc" } }
      }
      if (id === "@/src/OgStyles.js") return ogStyles
      if (id === "@/src/MdxComponents.res.mjs") return { default: {} }
      if (id.endsWith(".res.mjs")) return { make: () => null }
      if (id.startsWith("@/content/")) return { default: require(`../${id.slice(2)}`) }
      return require(id)
    },
  })

  return { route, imports }
}

const legacy = loadRoute("../app/components/[slug]/page.jsx")
const variant = loadRoute("../app/components/[slug]/[libStyle]/page.jsx")
const props = (slug: string, libStyle?: unknown) => ({params: Promise.resolve({slug, libStyle})})

test("prebuilds exactly the valid library/component/style combinations", () => {
  const params = variant.route.generateStaticParams()
  expect(params).toHaveLength(1016)
  expect(new Set(params.map(({slug, libStyle}) => `${slug}/${libStyle}`)).size).toBe(1016)
  expect(params).toContainEqual({slug: "Button", libStyle: "aria-nova"})
  expect(params).not.toContainEqual({slug: "Menubar", libStyle: "aria-vega"})
  expect(variant.route.dynamicParams).toBe(false)
})

test("page and metadata reject invalid variants and unavailable pages before importing MDX", async () => {
  for (const render of [variant.route.default, variant.route.generateMetadata]) {
    for (const [slug, libStyle] of [
      ["TypographyH1", "base-vega"], ["CalendarBasic", "aria-vega"],
      ["Typography", "other-vega"], ["Typography", "unknown"],
      ["Typography", "aria-unknown"], ["Typography", "aria-vega-extra"],
      ["Typography", "vega"], ["Typography", undefined],
      ["Menubar", "aria-vega"], ["NavigationMenu", "aria-vega"], ["Toast", "aria-vega"],
    ]) {
      variant.imports.length = 0
      await expect(render(props(slug!, libStyle)))
        .rejects.toMatchObject({digest: "NEXT_HTTP_ERROR_FALLBACK;404"})
      expect(variant.imports).toEqual([])
    }
    for (const [slug, libStyle, lib] of [
      ["Typography", "base-vega", "base"], ["Typography", "aria-nova", "aria"],
      ["Menubar", "base-vega", "base"],
    ]) {
      variant.imports.length = 0
      await render({...props(slug, libStyle), get searchParams() { throw Error("Static pages must not read searchParams") }})
      expect(variant.imports).toEqual([`@/content/${lib}/${slug}.mdx`])
    }
  }
})

test("legacy URLs redirect to the default or their existing query selection", async () => {
  for (const [style, target] of [
    [undefined, "base-vega"], ["lyra", "base-lyra"], ["aria-nova", "aria-nova"],
  ]) {
    await expect(legacy.route.default({...props("Button"), searchParams: Promise.resolve({style})}))
      .rejects.toMatchObject({digest: `NEXT_REDIRECT;replace;/components/Button/${target};307;`})
  }
  for (const [slug, style] of [["TypographyH1", "base-vega"], ["Button", "other-vega"], ["Menubar", "aria-vega"]]) {
    await expect(legacy.route.default({...props(slug), searchParams: Promise.resolve({style})}))
      .rejects.toMatchObject({digest: "NEXT_HTTP_ERROR_FALLBACK;404"})
  }
  expect(legacy.imports).toEqual([])
})

test("metadata and MDX source components use the explicit route selection", async () => {
  const metadata = await variant.route.generateMetadata(props("Button", "aria-nova"))
  expect(metadata.openGraph.url).toBe("/components/Button/aria-nova")
  expect(metadata.openGraph.images[0].url).toBe("/og/components/nova/Button.png")
  const page = await variant.route.default(props("Button", "aria-nova"))
  const components = page.props.children.at(-1).props.components
  expect(components.ComponentPreview({name: "ButtonDemo"}).props.selection).toEqual({lib: "aria", style: "nova"})
  expect(components.ComponentSource({name: "Button"}).props).toMatchObject({lib: "aria", style: "nova"})
  expect(components.a({href: "/components/ButtonGroup#usage"}).props.href).toBe("/components/ButtonGroup/aria-nova#usage")
  expect(components.a({href: "/components/base/ButtonGroup"}).props.href).toBe("/components/ButtonGroup/aria-nova")
  expect(components.a({href: "https://example.com/components/Button"}).props.href).toBe("https://example.com/components/Button")
})
