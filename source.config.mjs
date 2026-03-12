import { defineConfig, defineDocs } from "fumadocs-mdx/config"
import rehypePrettyCode from "rehype-pretty-code"

import { getHighlighter, transformers } from "./src/HighlightCode.res.mjs"

export default defineConfig({
  mdxOptions: {
    rehypePlugins: (plugins) => {
      plugins.shift()
      plugins.push([
        rehypePrettyCode,
        {
          theme: {
            dark: "github-dark",
            light: "github-light-default",
          },
          transformers,
          getHighlighter
        },
      ])

      return plugins
    },
  },
})

export const docs = defineDocs({
  dir: "content/base"
})
