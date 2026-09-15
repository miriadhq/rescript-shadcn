import { describe, expect, it, vi } from "vitest";
import React from "react";
import { renderToStaticMarkup } from "react-dom/server";
import * as AlertDialog from "../registry/base/ui/AlertDialog.res.mjs";
import * as Button from "../registry/base/ui/Button.res.mjs";
import * as ButtonGroup from "../registry/base/ui/ButtonGroup.res.mjs";
import * as Combobox from "../registry/base/ui/Combobox.res.mjs";
import * as Drawer from "../registry/base/ui/Drawer.res.mjs";
import * as InputGroup from "../registry/base/ui/InputGroup.res.mjs";
import * as Label from "../registry/base/ui/Label.res.mjs";
import * as Alert from "../registry/base/ui/Alert.res.mjs";
import * as AspectRatio from "../registry/base/ui/AspectRatio.res.mjs";
import * as Card from "../registry/base/ui/Card.res.mjs";
import * as Empty from "../registry/base/ui/Empty.res.mjs";
import * as Kbd from "../registry/base/ui/Kbd.res.mjs";
import * as Skeleton from "../registry/base/ui/Skeleton.res.mjs";
import * as Spinner from "../registry/base/ui/Spinner.res.mjs";
import * as AriaSpinner from "../registry/aria/ui/Spinner.res.mjs";
import * as Table from "../registry/base/ui/Table.res.mjs";

import * as Attachment from "../registry/base/ui/Attachment.res.mjs";
import * as Chart from "../registry/base/ui/Chart.res.mjs";

const h = React.createElement;

describe("Base component prop composition", () => {
  it("forwards attachment action overrides and handlers", () => {
    const onClick = vi.fn();
    const action = Attachment.Action.make({ variant: "secondary", size: "icon-sm", type: "submit", title: "Download", onClick });
    expect(action.props).toMatchObject({ variant: "secondary", size: "icon-sm", type: "submit", title: "Download", onClick });
    expect(Attachment.Action.make({}).props).toMatchObject({ variant: "ghost", size: "icon-xs" });
  });

  it("defaults attachment buttons without putting a button type on a rendered link", () => {
    const button = renderToStaticMarkup(h(Attachment.Trigger.make, { children: "Preview", "aria-label": "Preview file" }));
    expect(button).toContain('type="button"');
    expect(button).toContain('aria-label="Preview file"');
    const link = renderToStaticMarkup(h(Attachment.Trigger.make, { render: h("a", { href: "/file" }), children: "Open", title: "File" }));
    expect(link).toContain('<a');
    expect(link).toContain('href="/file"');
    expect(link).toContain('title="File"');
    expect(link).toContain('data-slot="attachment-trigger"');
    expect(link).not.toContain('type=');
  });

  it("uses chart IDs for its scoped data attribute", () => {
    const html = renderToStaticMarkup(h(Chart.make, { id: "visitors", config: {} }, h("div")));
    expect(html).toContain('data-chart="chart-visitors"');
    expect(html).not.toContain(' id="visitors"');
  });

  it.each([
    ["Alert", Alert.make, { variant: "destructive" }],
    ["AspectRatio", AspectRatio.make, { ratio: 1.5 }],
    ["Card", Card.make, { size: "sm" }],
    ["Card.Header", Card.Header.make, {}],
    ["Empty", Empty.make, {}],
    ["Empty.Media", Empty.Media.make, { variant: "icon" }],
    ["Kbd", Kbd.make, {}],
    ["Skeleton", Skeleton.make, {}],
    ["InputGroup.Text", InputGroup.Text.make, {}],
    ["InputGroup.Textarea", InputGroup.Textarea.make, {}],
    ["Table.Cell", Table.Cell.make, { colSpan: 2 }],
  ])("%s forwards refs, events, and caller attributes without leaking its variants", (_, Component, extra) => {
    const ref = React.createRef();
    const onFocus = vi.fn();
    const element = Component({
      ...extra, ref, onFocus, "aria-label": "Custom label", "data-slot": "custom-slot",
      title: "Help", className: "custom-class", children: "Content",
    });
    expect(element.props.ref).toBe(ref);
    expect(element.props.onFocus).toBe(onFocus);
    expect(element.props["aria-label"]).toBe("Custom label");
    expect(element.props["data-slot"]).toBe("custom-slot");
    expect(element.props.title).toBe("Help");
    expect(element.props.className).toContain("custom-class");
    expect(element.props.children).toBe("Content");
    expect(element.props).not.toHaveProperty("variant");
    expect(element.props).not.toHaveProperty("size");
    expect(element.props).not.toHaveProperty("ratio");
  });

  it("puts table identity and event handlers on the table only", () => {
    const onClick = vi.fn();
    const ref = React.createRef();
    const element = Table.make({ id: "invoices", onClick, ref, "aria-label": "Invoices" });
    expect(element.props).not.toHaveProperty("id");
    expect(element.props).not.toHaveProperty("onClick");
    expect(element.props.children.type).toBe("table");
    expect(element.props.children.props).toMatchObject({ id: "invoices", onClick, ref });
    const html = renderToStaticMarkup(element);
    expect(html.match(/id="invoices"/g)).toHaveLength(1);
    expect(html).toContain('aria-label="Invoices"');
  });

  it.each([["Base", Spinner.make], ["Aria", AriaSpinner.make]])("%s Spinner forwards SVG and accessibility props", (_, Component) => {
    const onFocus = vi.fn();
    const ref = React.createRef();
    const element = Component({
      ref, onFocus, "aria-label": "Saving", "aria-hidden": true, role: "presentation",
      "data-icon": "inline-end", strokeWidth: "3", "data-slot": "custom-spinner",
    });
    expect(element.props.ref).toBe(ref);
    expect(element.props.onFocus).toBe(onFocus);
    const html = renderToStaticMarkup(element);
    for (const attr of ['aria-label="Saving"', 'aria-hidden="true"', 'role="presentation"',
      'data-icon="inline-end"', 'data-slot="custom-spinner"', 'stroke-width="3"']) {
      expect(html).toContain(attr);
    }
  });

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

  it("preserves Drawer's native trigger type through a rendered Button", () => {
    const render = (props = {}) => renderToStaticMarkup(h(Drawer.make, {},
      h(Drawer.Trigger.make, { render: h(Button.make), ...props }, "Open")));
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
