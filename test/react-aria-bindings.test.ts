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

  it("does not hide upstream components behind Primitive or Root adapters", () => {
    const violations = bindingFiles.flatMap((file) => {
      const source = readFileSync(join(sourceDirectory, file), "utf8")
      return source
        .split("\n")
        .map((line, index) => ({file, line: index + 1, source: line.trim()}))
        .filter(({source}) =>
          /module\s+(?:Primitive|RootPrimitive|ItemPrimitive|TabPrimitive|PanelPrimitive)\b/.test(
            source,
          ),
        )
    })

    expect(violations).toEqual([])
  })

  it("does not publish placeholder modules for components React Aria does not export", () => {
    expect(bindingFiles).not.toContain("Avatar.res")
    expect(bindingFiles).not.toContain("ScrollArea.res")
    expect(bindingFiles).not.toContain("AlertDialog.res")
    expect(bindingFiles).not.toContain("ContextMenu.res")
    expect(bindingFiles).not.toContain("Render.res")
    expect(bindingFiles).not.toContain("AnchorPositioning.res")
    expect(bindingFiles).not.toContain("Accordion.res")
    expect(bindingFiles).not.toContain("Collapsible.res")
    expect(bindingFiles).not.toContain("Progress.res")
    expect(bindingFiles).not.toContain("Toggle.res")
    expect(bindingFiles).not.toContain("ToggleGroup.res")
    expect(bindingFiles).not.toContain("DirectionProvider.res")
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

  it("binds Checkbox directly with React Aria prop names", () => {
    const checkbox = readFileSync(join(sourceDirectory, "Checkbox.res"), "utf8")

    expect(checkbox).toContain('external make: React.component<props> = "Checkbox"')
    expect(checkbox).toContain("isSelected?: bool")
    expect(checkbox).toContain("defaultSelected?: bool")
    expect(checkbox).toContain("onChange?: bool => unit")
    expect(checkbox).not.toContain("checked?: bool")
    expect(checkbox).not.toContain("onCheckedChange")
    expect(checkbox).not.toContain("module Root")
  })

  it("uses collection render state for Select and Combobox indicators", () => {
    for (const file of ["Select.res", "Combobox.res"]) {
      const source = readFileSync(join(registryUiDirectory, file), "utf8")

      expect(source).toContain("ReactAria.Common.itemRenderChildren")
      expect(source).not.toContain("ReactAria.SelectionIndicator")
    }
  })

  it("renders Combobox empty states through ListBox state", () => {
    const examples = readdirSync(registryExamplesDirectory)
      .filter((file) => file.startsWith("Combobox") && file.endsWith(".res"))
      .map((file) => ({
        file,
        source: readFileSync(join(registryExamplesDirectory, file), "utf8"),
      }))
      .filter(({source}) => source.includes("<Combobox.Empty>"))

    expect(examples.length).toBeGreaterThan(0)
    for (const {file, source} of examples) {
      expect(source, file).toContain("renderEmptyState=")
    }
  })
})
