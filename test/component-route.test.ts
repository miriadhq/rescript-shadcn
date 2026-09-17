import { readFileSync } from "node:fs"
import { createRequire } from "node:module"
import { runInNewContext } from "node:vm"
import ts from "typescript"
import { expect, test } from "vitest"
import * as ogStyles from "../src/OgStyles.js"

const require = createRequire(import.meta.url)
const source = readFileSync(new URL("../app/components/[slug]/page.jsx", import.meta.url), "utf8")
const { outputText } = ts.transpileModule(source, {
  fileName: "page.jsx",
  compilerOptions: { module: ts.ModuleKind.CommonJS, jsx: ts.JsxEmit.ReactJSX },
})

test("page and metadata validate selections and slugs before importing MDX", async () => {
  const imports: string[] = []
  const route: Record<string, Function> = {}
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
      if (id === "@/src/ComponentTitle.res.mjs") return { make: () => null }
      if (id.startsWith("@/content/")) return { default: require(`../${id.slice(2)}`) }
      return require(id)
    },
  })

  for (const render of [route.default, route.generateMetadata]) {
    for (const style of ["base-vega", "aria-vega"]) {
      for (const slug of ["TypographyH1", "CalendarBasic", "AttachmentSizes", "does-not-exist"]) {
        imports.length = 0
        await expect(render({ params: Promise.resolve({ slug }), searchParams: Promise.resolve({ style }) }))
          .rejects.toMatchObject({ digest: "NEXT_HTTP_ERROR_FALLBACK;404" })
        expect(imports).toEqual([])
      }
    }
    for (const [slug, style] of [
      ["Typography", "other-vega"],
      ["Typography", "unknown"],
      ["Typography", ""],
      ["Typography", "aria-unknown"],
      ["Typography", "aria-vega-extra"],
      ["Typography", ["base-vega", "aria-vega"]],
      ["Menubar", "aria-vega"],
      ["NavigationMenu", "aria-vega"],
      ["Toast", "aria-vega"],
    ]) {
      imports.length = 0
      await expect(render({ params: Promise.resolve({ slug }), searchParams: Promise.resolve({ style }) }))
        .rejects.toMatchObject({ digest: "NEXT_HTTP_ERROR_FALLBACK;404" })
      expect(imports).toEqual([])
    }
    for (const [slug, style, lib] of [
      ["Typography", undefined, "base"],
      ["Typography", "lyra", "base"],
      ["Typography", "base-vega", "base"],
      ["Typography", "aria-vega", "aria"],
      ["Menubar", "base-vega", "base"],
    ]) {
      imports.length = 0
      await render({ params: Promise.resolve({ slug }), searchParams: Promise.resolve({ style }) })
      expect(imports).toEqual([`@/content/${lib}/${slug}.mdx`])
    }
  }
})
