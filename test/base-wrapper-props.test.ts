import React from "react";
import { renderToStaticMarkup } from "react-dom/server";
import { expect, it, vi } from "vitest";

vi.mock("sonner", async importOriginal => ({
  ...await importOriginal<object>(),
  Toaster: vi.fn(() => null),
}));

const cases = [
  ["NavigationMenu", "make", {delay: 250, closeDelay: 100, onOpenChangeComplete: () => {}}],
  ["NavigationMenu", "Trigger", {nativeButton: false}],
  ["NavigationMenu", "Link", {href: "/docs", rel: "help"}],
  ["Tabs", "Content", {value: "one", keepMounted: true}],
  ["Slider", "make", {value: 25, minStepsBetweenValues: 2, onValueCommitted: () => {}}],
  ["RadioGroup", "make", {inputRef: React.createRef()}],
  ["Collapsible", "Content", {keepMounted: true}],
] as const;

it.each(cases)("%s.%s forwards primitive props, refs, events and attributes", async (file, member, specific) => {
  const module = await import(`../registry/base/ui/${file}.res.mjs`);
  const make = member === "make" ? module.make : (module[member] ?? module[`$$${member}`]).make;
  const forwarded = {
    ...specific, ref: React.createRef(), onPointerDown: vi.fn(),
    "aria-describedby": "description", "data-extra": "forwarded", "data-slot": "custom-slot",
  };
  const tree = make({...forwarded, className: "custom-class", children: "Content"});
  expect(tree.props).toMatchObject(forwarded);
  if (file !== "Collapsible") expect(tree.props.className).toContain("custom-class");
});

// Inspect returned elements so portals and context-dependent primitives need not be mounted.
function findForwarded(tree: React.ReactNode): React.ReactElement<any>[] {
  return React.Children.toArray(tree).flatMap(child => {
    if (!React.isValidElement<any>(child)) return [];
    return [
      ...(child.props["data-extra"] === "forwarded" ? [child] : []),
      ...findForwarded(child.props.children),
      ...findForwarded(child.props.render),
    ];
  });
}

it.each([
  {dir: "rtl"},
  {style: {direction: "ltr", color: "red"}},
  {dir: "rtl", style: {direction: "ltr", color: "red"}},
])("Sheet.Content preserves dir and style independently: %j", async props => {
  const {Content} = await import("../registry/base/ui/Sheet.res.mjs");
  const before = structuredClone(props);
  const [popup] = findForwarded(Content.make({...props, "data-extra": "forwarded"}));
  expect(popup.props.dir).toBe(props.dir);
  expect(popup.props.style).toBe(props.style);
  expect(props).toEqual(before);
});

const wrappers: Record<string, string[]> = {
  Accordion: ["make", "Multiple", "Item", "Content"],
  AlertDialog: ["make", "Portal", "Overlay", "Content", "Header", "Footer", "Media", "Title", "Description", "Action", "Cancel"],
  Attachment: ["make", "Media", "Content", "Title", "Description", "Actions", "Group"],
  Avatar: ["make", "Fallback", "Group", "GroupCount", "Badge"],
  Breadcrumb: ["make", "List", "Item", "Page", "Separator", "Ellipsis"],
  Collapsible: ["make", "Content"],
  Combobox: ["Content", "List", "Group", "Label", "Collection", "Empty", "Separator"],
  Command: ["make", "Dialog", "Input", "List", "Empty", "Group", "Separator", "Item", "Shortcut"],
  ContextMenu: ["make", "Portal", "Content", "Group", "Label", "Item", "CheckboxItem", "RadioGroup", "RadioItem", "Separator", "Shortcut", "Sub", "SubContent", "SubTrigger"],
  Dialog: ["Portal"],
  DropdownMenu: ["make", "Portal", "Group"],
  Field: ["make", "Set", "Legend", "Content", "Label", "Title", "Description", "Separator"],
  HoverCard: ["make", "Trigger", "Content"],
  InputOtp: ["make", "Group"],
  Item: ["Media", "Content", "Actions", "Group", "Separator", "Title", "Description", "Header", "Footer"],
  Menubar: ["Menu", "Group", "Portal", "Sub"],
  Message: ["make", "Group", "Avatar", "Content", "Header", "Footer"],
  NavigationMenu: ["make", "List", "Item", "Trigger", "Content", "Positioner", "Link", "Indicator"],
  Pagination: ["make", "Content", "Item", "Link", "Previous", "Next", "Ellipsis"],
  Progress: ["make", "Track", "Indicator", "Label", "Value"],
  RadioGroup: ["make", "Item"],
  Resizable: ["Handle"],
  ScrollArea: ["make", "ScrollBar"],
  Select: ["Value", "ScrollUpButton", "ScrollDownButton", "Label", "Item", "Separator"],
  Sheet: ["Content"],
  Slider: ["make"],
  Tabs: ["make", "List", "Trigger", "Content"],
  Toast: ["Root", "Toaster"],
  Tooltip: ["make", "Provider"],
};

for (const [file, members] of Object.entries(wrappers)) {
  it.each(members)(`${file}.%s forwards remaining props to exactly one target`, async member => {
    const module = await import(`../registry/base/ui/${file}.res.mjs`);
    const make = member === "make" ? module.make : (module[member] ?? module[`$$${member}`]).make;
    const forwarded = {
      ref: React.createRef(), onPointerDown: vi.fn(), title: "Forwarded",
      "aria-describedby": "description", "data-extra": "forwarded", "data-slot": "custom-slot",
    };
    const tree = make({...forwarded, value: "one", children: "Content", toast: {id: "fixture"}});
    const targets = findForwarded(tree);
    expect(targets).toHaveLength(1);
    // Command.Dialog uses title for its composed dialog heading.
    const {title, ...rest} = forwarded;
    expect(targets[0].props).toMatchObject(file === "Command" && member === "Dialog" ? rest : forwarded);
  });
}

it("keeps wrapper options out of the forwarded props", async () => {
  const cases = [
    ["Attachment", "make", {state: "done", size: "sm", orientation: "vertical"}],
    ["Field", "make", {orientation: "responsive"}],
    ["Field", "Legend", {variant: "label"}],
    ["Item", "Media", {variant: "icon"}],
    ["Avatar", "make", {size: "sm"}],
    ["Message", "make", {align: "end"}],
    ["Tabs", "List", {variant: "line"}],
    ["ContextMenu", "Item", {inset: true, variant: "destructive"}],
    ["NavigationMenu", "make", {align: "end"}],
    ["HoverCard", "Content", {side: "top", sideOffset: 8, align: "end", alignOffset: 2}],
    ["Combobox", "Content", {side: "top", sideOffset: 8, align: "end", alignOffset: 2, anchor: React.createRef()}],
    ["Sheet", "Content", {side: "left", showCloseButton: false}],
    ["Resizable", "Handle", {withHandle: true}],
    ["Pagination", "Link", {isActive: true, size: "default"}],
  ] as const;
  for (const [file, member, options] of cases) {
    const module = await import(`../registry/base/ui/${file}.res.mjs`);
    const make = member === "make" ? module.make : module[member].make;
    const [target] = findForwarded(make({...options, "data-extra": "forwarded", children: "Content"}));
    expect(target, `${file}.${member}`).toBeDefined();
    for (const name of Object.keys(options)) expect(target.props, `${file}.${member}`).not.toHaveProperty(name);
  }
});

it("preserves explicitly overridden data attributes", async () => {
  for (const [file, member, options] of [
    ["Avatar", "make", {size: "sm", "data-size": "custom"}],
    ["Tabs", "List", {variant: "line", "data-variant": "custom"}],
    ["ContextMenu", "Item", {inset: true, "data-inset": false}],
    ["Field", "make", {orientation: "responsive", "data-orientation": "custom"}],
  ] as const) {
    const module = await import(`../registry/base/ui/${file}.res.mjs`);
    const make = member === "make" ? module.make : module[member].make;
    const tree = make(options);
    for (const [name, value] of Object.entries(options).filter(([name]) => name.startsWith("data-"))) {
      expect(tree.props[name]).toBe(value);
    }
  }
});

it("accepts the expanded props from compiled ReScript callers", async () => {
  const fixtures = await import("./visual/vite-harness/PropSpreadingFixtures.res.mjs");
  for (const [name, expected] of [
    ["navigation", "Docs"], ["tabs", 'data-testid="kept-panel"'],
    ["slider", 'type="range"'], ["radio", 'name="choice"'],
    ["command", 'title="Run command"'], ["field", 'data-orientation="responsive"'],
    ["attachment", 'data-size="sm"'],
  ]) {
    expect(renderToStaticMarkup(fixtures[name])).toContain(expected);
  }
});

it("forwards props on components that use hooks without leaking their options", async () => {
  const [Chart, Carousel, Field, InputOtp] = await Promise.all([
    import("../registry/base/ui/Chart.res.mjs"), import("../registry/base/ui/Carousel.res.mjs"),
    import("../registry/base/ui/Field.res.mjs"), import("../registry/base/ui/InputOtp.res.mjs"),
  ]);
  const h = React.createElement;
  const {OTPInputContext} = await import("input-otp");
  const attrs = {"data-extra": "forwarded", title: "Forwarded"};
  const payload = [{name: "desktop", dataKey: "desktop", value: 10, payload: {}}];
  const config = {desktop: {label: "Desktop", color: "#000"}};
  const chartContext = child => h(Chart.chartContext.Provider, {value: {config}}, child);
  const examples = [
    h(Chart.make, {...attrs, config}, h("div")),
    chartContext(h(Chart.TooltipContent.make, {...attrs, active: true, payload, indicator: "dot"})),
    chartContext(h(Chart.LegendContent.make, {...attrs, payload, hideIcon: true})),
    h(Carousel.make, {...attrs, orientation: "vertical", opts: {}}, h("div")),
    h(Carousel.make, null, h(Carousel.Content.make, attrs, h("div"))),
    h(Carousel.make, null, h(Carousel.Item.make, attrs, "Slide")),
    h(Field.$$Error.make, {...attrs, errors: [{message: "Invalid"}]}),
    h(OTPInputContext.Provider, {value: {slots: [{char: "1", isActive: false, hasFakeCaret: false}], isFocused: false, isHovering: false}},
      h(InputOtp.Slot.make, {...attrs, index: 0})),
  ];
  for (const example of examples) {
    const html = renderToStaticMarkup(example);
    expect(html.match(/data-extra="forwarded"/g)).toHaveLength(1);
    expect(html).toContain('title="Forwarded"');
    expect(html).not.toMatch(/\s(?:config|initialDimension|payload|indicator|hideIcon|opts|plugins|setApi|errors|index|orientation)=/);
  }
});

it("Sonner forwards primitive options and resolves its default theme", async () => {
  const Sonner = await import("../registry/base/ui/Sonner.res.mjs");
  const {Toaster} = await import("sonner");
  const options = {theme: "dark", duration: 1234, position: "top-right", "data-extra": "forwarded"};
  renderToStaticMarkup(React.createElement(Sonner.make, options));
  expect(vi.mocked(Toaster).mock.lastCall?.[0]).toMatchObject(options);
  renderToStaticMarkup(React.createElement(Sonner.make));
  expect(vi.mocked(Toaster).mock.lastCall?.[0]).toMatchObject({theme: "system", className: "toaster group"});
});

it("lets callers override primitive defaults", async () => {
  for (const [file, member, overrides] of [
    ["Slider", "make", {thumbAlignment: "center"}],
    ["Item", "Separator", {orientation: "vertical"}],
    ["InputOtp", "make", {spellCheck: true}],
    ["Breadcrumb", "make", {"aria-label": "Location"}],
    ["Pagination", "Previous", {"aria-label": "Earlier", size: "icon"}],
    ["Pagination", "Next", {"aria-label": "Later", size: "icon"}],
    ["Pagination", "Link", {"aria-current": "step", "data-active": false}],
  ] as const) {
    const module = await import(`../registry/base/ui/${file}.res.mjs`);
    const make = member === "make" ? module.make : module[member].make;
    const [target] = findForwarded(make({...overrides, "data-extra": "forwarded"}));
    expect(target.props).toMatchObject(overrides);
  }
  const Carousel = await import("../registry/base/ui/Carousel.res.mjs");
  const onKeyDownCapture = vi.fn();
  let tree: React.ReactNode;
  const Probe = () => {
    tree = Carousel.make({onKeyDownCapture, "data-extra": "forwarded", role: "group", "aria-roledescription": "Gallery"});
    return tree;
  };
  renderToStaticMarkup(React.createElement(Probe));
  expect(findForwarded(tree)[0].props).toMatchObject({onKeyDownCapture, role: "group", "aria-roledescription": "Gallery"});
});

it("chart renderers strip Recharts-injected options while retaining DOM props", async () => {
  const Chart = await import("../registry/base/ui/Chart.res.mjs");
  const domProps = {id: "chart-content", title: "Content", onPointerDown: vi.fn(), "aria-label": "Details", "data-extra": "forwarded"};
  expect(Chart.LegendContent.toBaseUiProps({
    ...domProps, hideIcon: true, payload: [], verticalAlign: "bottom", nameKey: "name",
    content: React.createElement("div"), iconSize: 14, iconType: "rect", layout: "horizontal",
    align: "center", inactiveColor: "#ccc", formatter: vi.fn(), labelStyle: {}, wrapperStyle: {},
    width: 300, height: 200, payloadUniqBy: vi.fn(), onBBoxUpdate: vi.fn(), portal: null,
    itemSorter: "value", position: "bottom", offset: 0, margin: {}, chartWidth: 320, chartHeight: 240,
  })).toEqual(domProps);
  expect(Chart.TooltipContent.toBaseUiProps({
    ...domProps, active: true, payload: [], indicator: "dot", hideLabel: false, hideIndicator: false,
    label: "Desktop", labelFormatter: vi.fn(), labelClassName: "label", formatter: vi.fn(),
    color: "red", nameKey: "name", labelKey: "label", content: React.createElement("div"),
    contentStyle: {}, itemStyle: {}, labelStyle: {}, wrapperStyle: {}, wrapperClassName: "wrapper",
    separator: ":", itemSorter: "name", accessibilityLayer: true, activeIndex: 0,
    coordinate: {x: 1, y: 2}, viewBox: {}, allowEscapeViewBox: {}, animationDuration: 400,
    animationEasing: "ease", axisId: 0, cursor: true, defaultIndex: 0, filterNull: true,
    includeHidden: false, isAnimationActive: "auto", offset: 10, payloadUniqBy: vi.fn(),
    portal: null, position: {}, reverseDirection: {}, shared: true, trigger: "hover", useTranslate3d: false,
  })).toEqual(domProps);
});
