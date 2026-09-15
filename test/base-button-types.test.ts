import { mkdtempSync, rmSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { join, resolve } from "node:path";
import { spawnSync } from "node:child_process";
import { runInNewContext } from "node:vm";
import { describe, expect, it } from "vitest";
import React from "react";
import { renderToStaticMarkup } from "react-dom/server";
import * as Button from "../registry/base/ui/Button.res.mjs";
import * as InputGroup from "../registry/base/ui/InputGroup.res.mjs";
import * as Sidebar from "../registry/base/ui/Sidebar.res.mjs";

// Run after `yarn compile`, using the same compiled interfaces as consumers.
function compile(source: string) {
  const directory = mkdtempSync(join(tmpdir(), "base-button-types-"));
  try {
    const file = join(directory, "ButtonTypeCheck.res");
    writeFileSync(file, source);
    return spawnSync(resolve("node_modules/.bin/bsc"), [
      "-I", resolve("packages/base-ui/lib/ocaml"),
      "-I", resolve("registry/base/lib/ocaml"),
      "-I", resolve("node_modules/@rescript/react/lib/ocaml"),
      file,
    ], { encoding: "utf8" });
  } finally {
    rmSync(directory, { recursive: true, force: true });
  }
}

describe("Base button types", () => {
  it("shares one enum and compiles it to native type attributes", () => {
    const result = compile(`
      let types: array<BaseUi.Types.ButtonType.t> = [Button, Submit, Reset]
      let button: Base.Button.props = {type_: Base.InputGroup.Button.Type.Submit}
      let inputGroup: Base.InputGroup.Button.props = {type_: Base.Button.Type.Reset}
      let menuAction: Base.Sidebar.MenuAction.props = {type_: BaseUi.Types.ButtonType.Submit}
      let input: BaseUi.Input.props = {type_: "email"}
      let dom: BaseUi.Types.DomProps.t = {type_: "text"}
    `);
    expect(result.status, result.stderr).toBe(0);
    const compiled = {};
    runInNewContext(result.stdout, { exports: compiled });
    expect(compiled).toEqual({
      types: ["button", "submit", "reset"],
      button: { type: "submit" }, inputGroup: { type: "reset" },
      menuAction: { type: "submit" },
      input: { type: "email" }, dom: { type: "text" },
    });
    for (const Component of [Button.make, InputGroup.Button.make]) {
      for (const type of ["button", "submit", "reset"]) {
        expect(renderToStaticMarkup(React.createElement(Component, { type })))
          .toContain(`type="${type}"`);
      }
    }
  });

  it.each(["BaseUi.Button.props", "Base.Button.props", "Base.InputGroup.Button.props", "Base.Sidebar.MenuAction.props"])(
    "%s rejects input-only types",
    (props) => {
      const result = compile(`let props: ${props} = {type_: "email"}`);
      expect(result.status).not.toBe(0);
      expect(result.stderr).toContain("ButtonType.t");
    },
  );

  it("Sidebar.MenuAction defaults native buttons without overriding explicit types or custom renders", () => {
    const render = (props = {}) => renderToStaticMarkup(React.createElement(Sidebar.MenuAction.make, props));
    expect(render()).toContain('type="button"');
    expect(render({type: undefined})).toContain('type="button"');
    for (const type of ["button", "submit", "reset"]) {
      expect(render({type})).toContain(`type="${type}"`);
    }
    expect(render({render: React.createElement("a", {href: "/docs"})})).not.toContain("type=");
    expect(render({render: React.createElement("button", {type: "submit"})})).toContain('type="submit"');
  });

  it("keeps ordinary DOM fields on full props and excludes only the requested field", () => {
    const result = compile(`
      let dom: BaseUi.Types.BaseDomProps.t = {
        type_: "text", dir: "rtl", orientation: Horizontal, onSelect: _ => (),
      }
      let component: BaseUi.Types.BaseUIComponentProps.t = {type_: "email"}
      let withoutType: BaseUi.Types.BaseUIComponentWithoutTypeProps.t = {
        dir: "rtl", orientation: Vertical, onSelect: _ => (),
      }
      let withoutOrientation: BaseUi.Types.BaseDomWithoutOrientationProps.t = {
        type_: "text", dir: "rtl", onSelect: _ => (),
      }
      let withoutOnSelect: BaseUi.Types.BaseDomWithoutOnSelectProps.t = {
        type_: "text", dir: "rtl", orientation: Horizontal,
      }
      let commandItem: Base.Command.CommandPrimitive.Item.props = {
        type_: "text", dir: "rtl", orientation: Horizontal, onSelect: _ => (),
      }
      let menuButton: Base.Sidebar.MenuButton.props = {type_: "button"}
    `);
    expect(result.status, result.stderr).toBe(0);
    const compiled: any = {};
    runInNewContext(result.stdout, {exports: compiled});
    expect(compiled.dom).toMatchObject({type: "text", dir: "rtl", orientation: "horizontal"});
    expect(compiled.component).toEqual({type: "email"});
    expect(compiled.withoutType).toMatchObject({dir: "rtl", orientation: "vertical"});
    expect(compiled.withoutOrientation).toMatchObject({type: "text", dir: "rtl"});
    expect(compiled.withoutOnSelect).toEqual({type: "text", dir: "rtl", orientation: "horizontal"});
    expect(compiled.commandItem).toMatchObject({type: "text", dir: "rtl", orientation: "horizontal"});
    expect(compiled.menuButton).toEqual({type: "button"});
  });

  it.each([
    ["BaseDomWithoutTypeProps", "type_", '"submit"'],
    ["BaseUIComponentWithoutTypeProps", "type_", '"submit"'],
    ["BaseDomWithoutOrientationProps", "orientation", "Horizontal"],
    ["BaseDomWithoutOnSelectProps", "onSelect", "_ => ()"],
  ])("%s excludes %s", (props, field, value) => {
    const result = compile(`let props: BaseUi.Types.${props}.t = {${field}: ${value}}`);
    expect(result.status).not.toBe(0);
    expect(result.stderr).toContain("does not belong to type");
  });
});
