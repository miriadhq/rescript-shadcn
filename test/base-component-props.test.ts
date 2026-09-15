import { describe, expect, it } from "vitest";
import React from "react";
import { renderToStaticMarkup } from "react-dom/server";
import * as AlertDialog from "../registry/base/ui/AlertDialog.res.mjs";
import * as Button from "../registry/base/ui/Button.res.mjs";
import * as ButtonGroup from "../registry/base/ui/ButtonGroup.res.mjs";
import * as Combobox from "../registry/base/ui/Combobox.res.mjs";
import * as Drawer from "../registry/base/ui/Drawer.res.mjs";
import * as InputGroup from "../registry/base/ui/InputGroup.res.mjs";
import * as Label from "../registry/base/ui/Label.res.mjs";

const h = React.createElement;

describe("Base component prop composition", () => {
  it.each([
    ["AlertDialog", AlertDialog.make, AlertDialog.Trigger.make],
    ["Combobox", Combobox.make, Combobox.Trigger.make],
  ])("%s preserves native defaults and explicit types when rendering Button", (_, Root, Trigger) => {
    const render = (props = {}) => renderToStaticMarkup(h(Root, {},
      h(Trigger, { render: h(Button.make), children: "Open", ...props })));
    expect(render()).toContain('type="button"');
    expect(render({ type: "submit" })).toContain('type="submit"');
    const link = render({ nativeButton: false, render: h("a", { href: "/help" }) });
    expect(link).toContain('href="/help"');
    expect(link).not.toMatch(/\stype=/);
  });

  it("preserves Drawer's native trigger type through an asChild Button", () => {
    const render = (props = {}) => renderToStaticMarkup(h(Drawer.make, {},
      h(Drawer.Trigger.make, { asChild: true, ...props }, h(Button.make, {}, "Open"))));
    expect(render()).toContain('type="button"');
    expect(render({ type: "submit" })).toContain('type="submit"');
  });

  it("consumes ButtonGroup orientation without leaking it onto the DOM", () => {
    const html = renderToStaticMarkup(h(ButtonGroup.make, { orientation: "vertical" }));
    expect(html).toContain('data-orientation="vertical"');
    expect(html).not.toMatch(/\sorientation=/);
    expect(html).toContain("cn-button-group-orientation-vertical");
  });

  it("preserves ButtonGroup's slot when rendered as Label", () => {
    const html = renderToStaticMarkup(h(ButtonGroup.Text.make, {
      render: h(Label.make, { htmlFor: "url" }), children: "URL",
    }));
    expect(html).toContain('data-slot="button-group-text"');
    expect(html).toContain('for="url"');
    expect(html).toContain("cn-label");
  });

  it("passes InputGroup button attributes through to the DOM", () => {
    const html = renderToStaticMarkup(h(InputGroup.Button.make, {
      size: "icon-xs", title: "Copy", "data-slot": "combobox-clear", children: "Copy",
    }));
    expect(html).toContain('title="Copy"');
    expect(html).toContain('data-slot="combobox-clear"');
    expect(html).toContain('data-size="icon-xs"');
    expect(html).toContain('type="button"');
  });
});
