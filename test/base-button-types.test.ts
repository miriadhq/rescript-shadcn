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
      let input: BaseUi.Input.props = {type_: "email"}
      let dom: BaseUi.Types.DomProps.t = {type_: "text"}
    `);
    expect(result.status, result.stderr).toBe(0);
    const compiled = {};
    runInNewContext(result.stdout, { exports: compiled });
    expect(compiled).toEqual({
      types: ["button", "submit", "reset"],
      button: { type: "submit" }, inputGroup: { type: "reset" },
      input: { type: "email" }, dom: { type: "text" },
    });
    for (const Component of [Button.make, InputGroup.Button.make]) {
      for (const type of ["button", "submit", "reset"]) {
        expect(renderToStaticMarkup(React.createElement(Component, { type })))
          .toContain(`type="${type}"`);
      }
    }
  });

  it.each(["BaseUi.Button.props", "Base.Button.props", "Base.InputGroup.Button.props"])(
    "%s rejects input-only types",
    (props) => {
      const result = compile(`let props: ${props} = {type_: "email"}`);
      expect(result.status).not.toBe(0);
      expect(result.stderr).toContain("ButtonType.t");
    },
  );

  it("does not expose type on generic element props", () => {
    const result = compile('let props: BaseUi.Types.BaseDomProps.t = {type_: "submit"}');
    expect(result.status).not.toBe(0);
    expect(result.stderr).toContain("does not belong to type");
  });
});
