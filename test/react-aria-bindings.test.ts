import {readFileSync, readdirSync} from "node:fs"
import {join} from "node:path"
import {describe, expect, it} from "vitest"

const sourceDirectory = join(process.cwd(), "packages/react-aria/src")
const registryUiDirectory = join(process.cwd(), "registry/aria/ui")
const registryExamplesDirectory = join(process.cwd(), "registry/aria/examples")
const bindingFiles = readdirSync(sourceDirectory)
  .filter((file) => file.endsWith(".res"))
  .sort()

describe("React Aria bindings", () => {
  it("contains declarations only", () => {
    const implementations = bindingFiles.flatMap((file) => {
      const source = readFileSync(join(sourceDirectory, file), "utf8")
      return source
        .split("\n")
        .map((line, index) => ({file, line: index + 1, source: line.trim()}))
        .filter(({source}) => /^let\s/.test(source))
    })

    expect(implementations).toEqual([])
  })

  it("does not publish empty placeholder modules", () => {
    const infrastructureFiles = new Set(["Common.res", "Types.res"])
    const placeholders = bindingFiles.filter((file) => {
      if (infrastructureFiles.has(file)) return false
      return !readFileSync(join(sourceDirectory, file), "utf8").includes("external ")
    })

    expect(placeholders).toEqual([])
  })

  it("only binds exports that exist in react-aria-components", async () => {
    const reactAria = await import("react-aria-components")
    const declarations = bindingFiles.flatMap((file) => {
      const source = readFileSync(join(sourceDirectory, file), "utf8")
      return [...source.matchAll(/@module\("react-aria-components"\)[\s\S]*?external\s+\w+[^=]*=\s*"([^"]+)"/g)]
        .map((match) => ({file, exportName: match[1]}))
    })

    const missing = declarations.filter(({exportName}) => !(exportName in reactAria))
    expect(missing).toEqual([])
  })

  it("keeps render-function children out of the shared element props", () => {
    const common = readFileSync(join(sourceDirectory, "Common.res"), "utf8")
    const baseProps = common.match(/type baseProps = \{([\s\S]*?)\n\}/)?.[1]

    expect(baseProps).toBeDefined()
    expect(baseProps).not.toContain("children?: React.element")
    expect(common).toContain("type elementProps = {")
    expect(common).toContain("children?: React.element")
  })

  it("uses ReScript's built-in nullable type", () => {
    const sources = [sourceDirectory, registryUiDirectory, registryExamplesDirectory]
      .flatMap((directory) =>
        readdirSync(directory)
          .filter((file) => file.endsWith(".res"))
          .map((file) => ({file: join(directory, file), source: readFileSync(join(directory, file), "utf8")})),
      )
      .filter(({source}) => source.includes("Nullable.t<"))
      .map(({file}) => file)

    expect(sources).toEqual([])
  })
})
