import {readFileSync} from "node:fs"

import {describe, expect, it} from "vitest"
import rehypePrettyCode from "rehype-pretty-code"

import {LibStyle} from "../src/Config.res.mjs"
import {getHighlighter, transformers} from "../src/HighlightCode.res.mjs"

const installationMdx = readFileSync(
  new URL("../content/docs/Installation.mdx", import.meta.url),
  "utf8",
)

describe("selection-aware installation docs", () => {
  it("resolves selection placeholders in MDX-owned code", () => {
    expect(
      LibStyle.interpolate('"style": "{{libStyle}}"', {
        lib: "aria",
        style: "mira",
      }),
    ).toBe('"style": "aria-mira"')
  })

  it("marks code fences that request lib/style interpolation", () => {
    const properties = {}

    transformers[0].code.call(
      {
        source: '"style": "{{libStyle}}"',
        options: {
          meta: {
            __raw: 'title="components.json" interpolateLibStyle',
          },
        },
      },
      {tagName: "code", properties},
    )

    expect(properties).toMatchObject({__interpolate_lib_style__: "true"})
  })

  it("preserves the interpolation marker through highlighting", async () => {
    const highlighter = await getHighlighter()
    const html = highlighter.codeToHtml('"style": "{{libStyle}}"', {
      lang: "json",
      themes: {dark: "github-dark", light: "github-light-default"},
      transformers,
      meta: {__raw: "interpolateLibStyle"},
    })

    expect(html).toContain('__interpolate_lib_style__="true"')
  })

  it("passes the code-fence flag through rehype-pretty-code", async () => {
    const tree = {
      type: "root",
      children: [
        {
          type: "element",
          tagName: "pre",
          properties: {},
          children: [
            {
              type: "element",
              tagName: "code",
              properties: {className: ["language-json"]},
              data: {
                meta: 'title="components.json" interpolateLibStyle',
              },
              children: [
                {type: "text", value: '"style": "{{libStyle}}"'},
              ],
            },
          ],
        },
      ],
    }

    await rehypePrettyCode({
      theme: {dark: "github-dark", light: "github-light-default"},
      transformers,
      getHighlighter,
    })(tree)

    expect(tree).toHaveProperty(
      "children.0.children.1.children.0.properties.__interpolate_lib_style__",
      "true",
    )
  })

  it("keeps library-specific installation content in MDX", () => {
    expect(installationMdx).toContain('<LibVariant value="base">')
    expect(installationMdx).toContain('<LibVariant value="aria">')
    expect(installationMdx).toContain(
      "npm install @base-ui/react rescript-base-ui",
    )
    expect(installationMdx).toContain(
      "npm install react-aria-components rescript-react-aria",
    )
    expect(installationMdx).toContain('"rescript-base-ui"')
    expect(installationMdx).toContain('"rescript-react-aria"')
  })

  it("keeps the components.json template in MDX", () => {
    expect(installationMdx).toContain(
      '```json title="components.json" interpolateLibStyle',
    )
    expect(installationMdx).toContain('"style": "{{libStyle}}"')
    expect(installationMdx).not.toContain("SelectionCodeBlock")
    expect(installationMdx).toContain(
      '"@rescript-shadcn": "https://rescript-shadcn.miriad.studio/r/styles/{style}/{name}.json"',
    )
  })
})
