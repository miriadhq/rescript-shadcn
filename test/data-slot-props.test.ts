import { readFileSync, readdirSync } from "node:fs";
import { join } from "node:path";
import { expect, it } from "vitest";
import ts from "typescript";
import React from "react";
import { renderToStaticMarkup } from "react-dom/server";

const files = ["base", "aria"].flatMap(lib => {
  const directory = join(process.cwd(), "registry", lib, "ui");
  return readdirSync(directory).filter(file => file.endsWith(".res"))
    .map(file => join(directory, `${file}.mjs`));
});

// ReScript compiles JSX props spreads to a copied record followed by assignments.
// A literal assignment here overwrites caller-supplied defaults. Fixed attributes
// on internal elements compile as object properties and are intentionally allowed.
it.each(files)("%s preserves spread slots and accessibility attributes", file => {
  const ast = ts.createSourceFile(file, readFileSync(file, "utf8"), ts.ScriptTarget.Latest, true);
  const overrides: string[] = [];
  const visit = (node: ts.Node) => {
    if (ts.isBinaryExpression(node) && node.operatorToken.kind === ts.SyntaxKind.EqualsToken) {
      const target = node.left;
      const name = ts.isPropertyAccessExpression(target) ? target.name.text
        : ts.isElementAccessExpression(target) && ts.isStringLiteral(target.argumentExpression)
          ? target.argumentExpression.text : "";
      const value = node.right;
      const constant = ts.isStringLiteral(value) || ts.isNoSubstitutionTemplateLiteral(value)
        || ts.isNumericLiteral(value) || value.kind === ts.SyntaxKind.TrueKeyword
        || value.kind === ts.SyntaxKind.FalseKeyword
        || (ts.isPrefixUnaryExpression(value) && ts.isNumericLiteral(value.operand));
      if (/^(data-slot|aria-.+|role|title|tabIndex)$/.test(name) && constant) {
        overrides.push(`${name} = ${value.getText(ast)}`);
      }
    }
    ts.forEachChild(node, visit);
  };
  visit(ast);
  expect(overrides).toEqual([]);
});

function forwardedElements(tree: React.ReactNode): React.ReactElement<any>[] {
  return React.Children.toArray(tree).flatMap(child => {
    if (!React.isValidElement<any>(child)) return [];
    return [
      ...(child.props["data-extra"] === "forwarded" ? [child] : []),
      ...forwardedElements(child.props.children),
    ];
  });
}

const sharedCases = [
  ["Checkbox", "make", "checkbox"],
  ["Combobox", "Value", "combobox-value"],
  ["Combobox", "Chip", "combobox-chip"],
  ["InputGroup", "make", "input-group"],
  ["Resizable", "make", "resizable-panel-group"],
  ["Resizable", "Panel", "resizable-panel"],
  ["Switch", "make", "switch"],
  ["Sheet", "Title", "sheet-title"],
] as const;

const cases = [
  ...["base", "aria"].flatMap(lib => sharedCases.map(row => [lib, ...row])),
  ["base", "Dialog", "Content", "dialog-content"],
  ["base", "Toast", "Action", "toast-action"],
  ["base", "Menubar", "SubTrigger", "menubar-sub-trigger"],
  ["base", "Toggle", "make", "toggle"],
  ["aria", "Accordion", "Trigger", "accordion-trigger"],
  ["aria", "AlertDialog", "Overlay", "alert-dialog-overlay"],
  ["aria", "Badge", "make", "badge"],
  ["aria", "Breadcrumb", "Item", "breadcrumb-item"],
  ["aria", "Calendar", "make", "calendar"],
  ["aria", "Calendar", "Range", "calendar"],
  ["aria", "Command", "Input", "command-input"],
  ["aria", "Dialog", "Overlay", "dialog-overlay"],
  ["aria", "Drawer", "Trigger", "drawer-trigger"],
  ["aria", "Input", "make", "input"],
  ["aria", "InputGroup", "Input", "input-group-control"],
  ["aria", "Item", "make", "item"],
  ["aria", "Kbd", "make", "kbd"],
  ["aria", "MessageScroller", "Item", "message-scroller-item"],
  ["aria", "Popover", "make", "popover-content"],
  ["aria", "Progress", "Track", "progress-track"],
  ["aria", "RadioGroup", "Item", "radio-group-item"],
  ["aria", "Select", "Trigger", "select-trigger"],
  ["aria", "Sheet", "Content", "sheet-overlay"],
  ["aria", "Sidebar", "Input", "sidebar-input"],
  ["aria", "Table", "make", "table"],
  ["aria", "Tabs", "Trigger", "tabs-trigger"],
  ["aria", "Tooltip", "Trigger", "tooltip-trigger"],
];

it.each(cases)("%s %s.%s defaults to %s and preserves caller slots", async (lib, file, member, defaultSlot) => {
  const module = await import(`../registry/${lib}/ui/${file}.res.mjs`);
  const make = member === "make" ? module.make : (module[member] ?? module[`$$${member}`]).make;
  for (const slot of [undefined, "custom-slot", ""]) {
    const props = {"data-slot": slot, "data-extra": "forwarded"};
    const targets = forwardedElements(make(props));
    expect(targets).toHaveLength(1);
    expect(targets[0].props["data-slot"]).toBe(slot ?? defaultSlot);
    expect(props["data-slot"]).toBe(slot);
  }
});

const accessibilityCases = [
  ...["base", "aria"].flatMap(lib => [
    [lib, "Breadcrumb", "make", {"aria-label": "breadcrumb"}],
    [lib, "Breadcrumb", "Page", {role: "link", "aria-disabled": true, "aria-current": "page"}],
    [lib, "Breadcrumb", "Ellipsis", {role: "presentation", "aria-hidden": true}],
    [lib, "Item", "Group", {role: "list"}],
    [lib, "Pagination", "make", {role: "navigation", "aria-label": "pagination"}],
    [lib, "Pagination", "Ellipsis", {"aria-hidden": true}],
    [lib, "Sidebar", "Rail", {"aria-label": "Toggle Sidebar", title: "Toggle Sidebar", tabIndex: -1}],
  ]),
  ["base", "Breadcrumb", "Separator", {role: "presentation", "aria-hidden": true}],
  ["base", "Field", "make", {role: "group"}],
  ["base", "Field", "Error", {role: "alert"}],
  ["base", "InputGroup", "make", {role: "group"}],
  ["aria", "InputGroup", "Addon", {role: "group"}],
  ["base", "InputOtp", "Separator", {role: "separator"}],
  ["base", "Toast", "Close", {"aria-label": "Close toast"}],
] as [string, string, string, Record<string, string | number | boolean>][];

it.each(accessibilityCases)("%s %s.%s preserves accessibility defaults and caller overrides", async (lib, file, member, defaults) => {
  const module = await import(`../registry/${lib}/ui/${file}.res.mjs`);
  const make = member === "make" ? module.make : (module[member] ?? module[`$$${member}`]).make;
  const custom = Object.fromEntries(Object.entries(defaults).map(([key, value]) =>
    [key, typeof value === "boolean" ? false : typeof value === "number" ? 0 : key === "aria-current" ? "step" : "custom"]));
  const empty = Object.fromEntries(Object.entries(custom).map(([key, value]) =>
    [key, typeof value === "string" && key !== "aria-current" ? "" : value]));
  for (const overrides of [{}, custom, empty]) {
    const props = {...overrides, "data-extra": "forwarded", children: "Content"};
    const before = {...props};
    let targets: React.ReactElement<any>[] = [];
    function Inspect() {
      targets = forwardedElements(make(props));
      return null;
    }
    const inspector = React.createElement(Inspect);
    renderToStaticMarkup(file === "Sidebar"
      ? React.createElement(module.Provider.make, null, inspector) : inspector);
    expect(targets).toHaveLength(1);
    expect(targets[0].props).toMatchObject({...defaults, ...overrides});
    expect(props).toEqual(before);
  }
});

it.each([false, true])("Aria Pagination.Link preserves aria-current when isActive=%s", async isActive => {
  const {Link} = await import("../registry/aria/ui/Pagination.res.mjs");
  for (const current of [undefined, "step", false]) {
    const tree = Link.make({isActive, "aria-current": current});
    expect(tree.props["aria-current"]).toBe(current ?? (isActive ? "page" : undefined));
  }
});
