import { describe, expect, it, vi } from "vitest";
import React from "react";
import { renderToStaticMarkup } from "react-dom/server";
import { Menu } from "@base-ui/react/menu";
import { Popover } from "@base-ui/react/popover";
import { Select } from "@base-ui/react/select";
import { Tooltip } from "@base-ui/react/tooltip";
import * as Badge from "../registry/base/ui/Badge.res.mjs";
import * as Breadcrumb from "../registry/base/ui/Breadcrumb.res.mjs";
import * as ButtonGroup from "../registry/base/ui/ButtonGroup.res.mjs";
import * as Item from "../registry/base/ui/Item.res.mjs";
import * as Collapsible from "../registry/base/ui/Collapsible.res.mjs";
import * as Accordion from "../registry/base/ui/Accordion.res.mjs";
import * as ContextMenu from "../registry/base/ui/ContextMenu.res.mjs";
import * as DropdownMenu from "../registry/base/ui/DropdownMenu.res.mjs";
import * as Menubar from "../registry/base/ui/Menubar.res.mjs";
import * as Sidebar from "../registry/base/ui/Sidebar.res.mjs";
import * as PopoverUi from "../registry/base/ui/Popover.res.mjs";
import * as SelectUi from "../registry/base/ui/Select.res.mjs";
import * as TooltipUi from "../registry/base/ui/Tooltip.res.mjs";

const h = React.createElement;

// Find a primitive in a wrapper's returned element tree without mounting portals.
function findElement(tree: React.ReactNode, type: unknown): React.ReactElement<any> | undefined {
  for (const child of React.Children.toArray(tree)) {
    if (!React.isValidElement<any>(child)) continue;
    if (child.type === type) return child;
    const found = findElement(child.props.children, type);
    if (found) return found;
  }
}

describe("registry prop forwarding", () => {
  it.each([
    ["Badge", Badge.make],
    ["Breadcrumb.Link", Breadcrumb.Link.make],
    ["ButtonGroup.Text", ButtonGroup.Text.make],
    ["Item", Item.make],
  ])("%s preserves custom render props, refs, handlers and attributes", (_, Component) => {
    let received: any;
    const onFocus = vi.fn();
    const ref = React.createRef<HTMLAnchorElement>();
    const Capture = (props: any) => { received = props; return h("a", props); };
    const html = renderToStaticMarkup(h(Component, {
      render: h(Capture), ref, onFocus, href: "/target", rel: "help",
      "aria-describedby": "description", "data-slot": "custom-slot",
      className: "custom-class", children: "Content",
    }));
    expect(received.ref).toBe(ref);
    received.onFocus({ nativeEvent: {}, defaultPrevented: false });
    expect(onFocus).toHaveBeenCalledOnce();
    expect(received.render).toBeUndefined();
    expect(received.variant).toBeUndefined();
    expect(received.size).toBeUndefined();
    for (const fragment of ['href="/target"', 'rel="help"', 'aria-describedby="description"', 'data-slot="custom-slot"', "custom-class", ">Content</a>"]) {
      expect(html).toContain(fragment);
    }
  });

  it("preserves Collapsible state when a Badge is the trigger render", () => {
    const html = renderToStaticMarkup(h(Collapsible.make, { defaultOpen: true },
      h(Collapsible.Trigger.make, { render: h(Badge.make), "aria-describedby": "help", children: "Toggle" })));
    expect(html).toContain('aria-expanded="true"');
    expect(html).toContain('aria-describedby="help"');
    expect(html).toContain('data-slot="collapsible-trigger"');
    expect(html).toContain("cn-badge");
  });

  it.each([
    ["Collapsible", Collapsible.Trigger.make],
    ["Accordion", Accordion.Trigger.make],
    ["ContextMenu", ContextMenu.Trigger.make],
    ["DropdownMenu.Item", DropdownMenu.Item.make],
    ["DropdownMenu.CheckboxItem", DropdownMenu.CheckboxItem.make],
    ["DropdownMenu.RadioItem", DropdownMenu.RadioItem.make],
    ["Menubar.Item", (props: any) => DropdownMenu.Item.make(Menubar.Item.make(props).props)],
    ["Menubar.CheckboxItem", Menubar.CheckboxItem.make],
    ["Menubar.RadioItem", Menubar.RadioItem.make],
  ])("%s passes additional props to its primitive", (_, make) => {
    const onPointerDown = vi.fn();
    const ref = React.createRef();
    const render = h("a", { href: "/custom" });
    const props = { ref, render, onPointerDown, title: "Forwarded", "aria-describedby": "help", "data-slot": "custom", value: "choice" };
    const tree = make(props);
    const target = tree.props.render ? tree : React.Children.toArray(tree.props.children)[0] as React.ReactElement<any>;
    expect(target.props).toMatchObject(props);
    expect(target.props.inset).toBeUndefined();
    expect(target.props.variant).toBeUndefined();
  });

  it("menu item shorthand props do not erase explicit data attributes", () => {
    const item = DropdownMenu.Item.make({ "data-inset": true, variant: "destructive" });
    expect(item.props["data-inset"]).toBe(true);
    expect(item.props["data-variant"]).toBe("destructive");
    expect(item.props.className).toContain("cn-dropdown-menu-item");
    expect(item.props.variant).toBeUndefined();
  });

  it.each([
    ["DropdownMenu.Item", DropdownMenu.Item.make],
    ["DropdownMenu.Label", DropdownMenu.Label.make],
    ["DropdownMenu.SubTrigger", DropdownMenu.SubTrigger.make],
    ["Menubar.Item", (p: any) => DropdownMenu.Item.make(Menubar.Item.make(p).props)],
    ["Menubar.CheckboxItem", Menubar.CheckboxItem.make],
    ["Menubar.RadioItem", Menubar.RadioItem.make],
    ["Menubar.Label", (p: any) => DropdownMenu.Label.make(Menubar.Label.make(p).props)],
    ["Menubar.SubTrigger", (p: any) => DropdownMenu.SubTrigger.make(Menubar.SubTrigger.make(p).props)],
  ])("%s prefers dataInset and falls back to inset when absent", (_, make) => {
    for (const dataInset of [true, false]) {
      expect(make({ value: "a", "data-inset": dataInset }).props["data-inset"]).toBe(dataInset);
      expect(make({ value: "a", inset: !dataInset, "data-inset": dataInset }).props["data-inset"]).toBe(dataInset);
    }
    expect(make({ value: "a", inset: true }).props["data-inset"]).toBe(true);
    expect(make({ value: "a", inset: false }).props["data-inset"]).toBe(false);
    expect(make({ value: "a", inset: true, "data-inset": undefined }).props["data-inset"]).toBe(true);
    expect(make({ value: "a", inset: false, "data-inset": undefined }).props["data-inset"]).toBe(false);
    expect(make({ value: "a" }).props["data-inset"]).toBeUndefined();
  });

  it.each([
    ["Group", Sidebar.Group.make], ["GroupContent", Sidebar.GroupContent.make],
    ["Menu", Sidebar.Menu.make], ["MenuItem", Sidebar.MenuItem.make],
    ["MenuBadge", Sidebar.MenuBadge.make], ["MenuSub", Sidebar.MenuSub.make],
    ["MenuSubItem", Sidebar.MenuSubItem.make], ["MenuSkeleton", Sidebar.MenuSkeleton.make],
  ])("Sidebar.%s forwards DOM attributes", (_, Component) => {
    const html = renderToStaticMarkup(h(Component, { title: "Forwarded", "aria-describedby": "help", "data-slot": "custom", "data-sidebar": "custom-sidebar", children: "Content" }));
    expect(html).toContain('title="Forwarded"');
    expect(html).toContain('aria-describedby="help"');
    expect(html).toContain('data-slot="custom"');
    expect(html).toContain('data-sidebar="custom-sidebar"');
    expect(html).toContain("Content");
    expect(html).not.toContain("showIcon=");
  });

  it.each([
    ["DropdownMenu", DropdownMenu.Content.make, Menu.Popup, Menu.Positioner],
    ["DropdownMenu.SubContent", (p: any) => DropdownMenu.Content.make(DropdownMenu.SubContent.make(p).props), Menu.Popup, Menu.Positioner],
    ["Menubar.SubContent", (p: any) => DropdownMenu.Content.make(DropdownMenu.SubContent.make(Menubar.SubContent.make(p).props).props), Menu.Popup, Menu.Positioner],
    ["Popover", PopoverUi.Content.make, Popover.Popup, Popover.Positioner],
    ["Select", SelectUi.Content.make, Select.Popup, Select.Positioner],
    ["Tooltip", TooltipUi.Content.make, Tooltip.Popup, Tooltip.Positioner],
  ])("%s keeps positioning props out of the popup", (_, make, Popup, Positioner) => {
    const onFocus = vi.fn();
    const ref = React.createRef();
    const tree = make({ children: "Content", ref, onFocus, title: "Forwarded", align: "end", side: "left", alignOffset: 7, sideOffset: 12, "data-align-trigger": false });
    const popup = findElement(tree, Popup)!;
    expect(popup.props).toMatchObject({ ref, onFocus, title: "Forwarded" });
    for (const key of ["align", "side", "alignOffset", "sideOffset", "dataAlignTrigger"]) {
      expect(popup.props[key]).toBeUndefined();
    }
    const positioner = findElement(tree, Positioner)!;
    expect(positioner.props).toMatchObject({ align: "end", side: "left", alignOffset: 7, sideOffset: 12 });
    if (Popup === Select.Popup) expect(positioner.props.alignItemWithTrigger).toBe(false);
  });

  it("Popover.Content forwards primitive focus settings", () => {
    const popup = findElement(PopoverUi.Content.make({ initialFocus: false, finalFocus: false }), Popover.Popup)!;
    expect(popup.props).toMatchObject({ initialFocus: false, finalFocus: false });
  });
});
