import { expect, test, vi } from "vitest"
import { LibStyle } from "../src/Config.res.mjs"

test("component variants come from the pathname and switching replaces that segment", () => {
  expect(LibStyle.fromPathname("/components/Button/aria-nova")).toEqual({lib: "aria", style: "nova"})
  expect(LibStyle.fromPathname("/components/Button/other-nova")).toBeUndefined()
  expect(LibStyle.fromPathname("/components/Button/aria-nova-extra")).toBeUndefined()
  expect(LibStyle.fromPathname("/components/Button")).toBeUndefined()
  expect(LibStyle.componentSlug("/components/Button/aria-nova")).toBe("Button")
  vi.stubGlobal("window", {location: {search: "?style=base-vega&example=1", hash: "#usage"}})
  try {
    expect(LibStyle.hrefFor("/components/Button/base-vega", {lib: "aria", style: "nova"}))
      .toBe("/components/Button/aria-nova?example=1#usage")
    expect(LibStyle.hrefFor("/components/Button", {lib: "base", style: "lyra"}))
      .toBe("/components/Button/base-lyra?example=1#usage")
    expect(LibStyle.hrefFor("/installation", {lib: "aria", style: "nova"}))
      .toBe("/installation?style=aria-nova&example=1#usage")
  } finally {
    vi.unstubAllGlobals()
  }
})
