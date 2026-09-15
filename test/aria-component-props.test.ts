import { describe, expect, it } from "vitest";
import React from "react";
import { renderToStaticMarkup } from "react-dom/server";
import { CalendarDate } from "@internationalized/date";
import * as Button from "../registry/aria/ui/Button.res.mjs";
import * as ButtonGroup from "../registry/aria/ui/ButtonGroup.res.mjs";
import * as Calendar from "../registry/aria/ui/Calendar.res.mjs";
import * as Collapsible from "../registry/aria/ui/Collapsible.res.mjs";
import * as InputGroup from "../registry/aria/ui/InputGroup.res.mjs";
import * as Sidebar from "../registry/aria/ui/Sidebar.res.mjs";

const h = React.createElement;

describe("Aria component prop composition", () => {
  it("keeps horizontal styling without inventing an orientation attribute", () => {
    const html = renderToStaticMarkup(h(ButtonGroup.make));
    expect(html).toContain("cn-button-group-orientation-horizontal");
    expect(html).not.toContain("data-orientation=");
    const vertical = renderToStaticMarkup(h(ButtonGroup.make, { orientation: "vertical" }));
    expect(vertical).toContain("cn-button-group-orientation-vertical");
    expect(vertical).toContain('data-orientation="vertical"');
  });

  it.each(["xs", "sm", "icon-xs", "icon-sm"])("keeps the %s input-group size separate from Button's size", (size) => {
    const html = renderToStaticMarkup(h(InputGroup.Button.make, { size, children: "Action" }));
    expect(html).toContain("cn-button-size-default");
    expect(html).toContain(`cn-input-group-button-size-${size}`);
    expect(html).toContain(`data-size="${size}"`);
    expect(html).toContain('data-variant="ghost"');
  });

  it.each([Button.make, Button.LinkButton.make])("preserves caller-supplied Button attributes", (Component) => {
    const html = renderToStaticMarkup(h(Component, {
      "data-slot": "custom-button", "data-size": "custom-size", "data-variant": "custom-variant",
      children: "Action",
    }));
    expect(html).toContain('data-slot="custom-button"');
    expect(html).toContain('data-size="custom-size"');
    expect(html).toContain('data-variant="custom-variant"');
    expect(html).toContain("cn-button-size-default");
  });

  it("preserves the ButtonGroup separator slot through Separator", () => {
    const html = renderToStaticMarkup(h(ButtonGroup.Separator.make));
    expect(html).toContain('data-slot="button-group-separator"');
  });

  it("preserves the Sidebar label slot when rendered as a Collapsible trigger", () => {
    const html = renderToStaticMarkup(h(Collapsible.make, { defaultExpanded: true },
      h(Sidebar.GroupLabel.make, { elementType: Collapsible.Trigger.make, children: "Help" })));
    expect(html).toContain('data-slot="sidebar-group-label"');
    expect(html).toContain('aria-expanded="true"');
  });

  it("omits range metadata on a selected single date and marks a range's middle day", () => {
    const start = new CalendarDate(2026, 9, 15);
    const single = renderToStaticMarkup(h(Calendar.make, { value: start }));
    const selectedDay = single.match(/<div[^>]*data-selected-single="true"[^>]*>/)?.[0];
    expect(selectedDay).toBeDefined();
    expect(selectedDay).not.toContain("data-range-middle=");
    const range = renderToStaticMarkup(h(Calendar.Range.make, {
      value: { start, end: new CalendarDate(2026, 9, 17) },
    }));
    expect(range).toContain('data-range-start="true"');
    expect(range).toContain('data-range-middle="true"');
    expect(range).toContain('data-range-end="true"');
  });
});
