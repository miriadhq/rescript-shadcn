import { readFileSync, readdirSync } from "node:fs"
import { join } from "node:path"
import { renderToStaticMarkup } from "react-dom/server"
import { describe, expect, it } from "vitest"
import { avatar, progress, updateToast, combobox } from "../packages/base-ui/src/UpgradeFixtures.res.mjs"

describe("Base UI bindings", () => {
  it("binds existing public exports", async () => {
    const directory = join(process.cwd(), "packages/base-ui/src")
    const missing: string[] = []
    let checked = 0
    for (const file of readdirSync(directory).filter(file => file.endsWith(".res"))) {
      const source = readFileSync(join(directory, file), "utf8")
      for (const match of source.matchAll(/@module\("(@base-ui\/react[^\"]*)"\)\s*(?:@scope\("([^\"]+)"\)\s*)?external\s+\w+[^=]*=\s*"([^\"]+)"/g)) {
        checked++
        const exports = await import(match[1])
        const scope = match[2] ? exports[match[2]] : exports
        if (scope?.[match[3]] === undefined) missing.push(`${file}: ${match[2] ?? ""}.${match[3]}`)
      }
    }
    expect(checked).toBeGreaterThan(100)
    expect(missing).toEqual([])
  })

  it("resolves collection values to their source labels", () => {
    expect(renderToStaticMarkup(combobox)).toContain('value="Paris"')
  })

  it("keeps Avatar images mounted when requested", () => {
    expect(renderToStaticMarkup(avatar)).toContain('<img')
    expect(renderToStaticMarkup(avatar)).toContain('src="/avatar.png"')
  })

  it("passes formatted progress to getAriaValueText", () => {
    expect(renderToStaticMarkup(progress)).toContain('aria-valuetext="Completed 42%"')
  })

  it("passes functional toast updates without wrapping their values", async () => {
    const { Toast } = await import("@base-ui/react/toast")
    const manager = Toast.createToastManager()
    const events: any[] = []
    const unsubscribe = manager[" subscribe"](event => events.push(event))
    updateToast(manager, "toast-id")
    expect(events[0].action).toBe("update")
    expect(events[0].options).toMatchObject({ id: "toast-id" })
    const updater = events[0].options.updates
    expect(updater({ id: "toast-id", title: "Original" })).toMatchObject({ title: "Original updated" })
    unsubscribe()
  })
})
