#!/usr/bin/env node

/*

LLM-generated "spike". A faster alternative to the existing `test:visual` script.

Ensures DOM parity between the upstream TSX examples and the ReScript port.

Rendered with react-dom/server instead of Chrome (~8s vs ~26 min for `yarn test:visual`).

Same normalization as pixel-perfect-vite.test.ts; blind to layout, paint and anything set by client effects.

*/
import { spawnSync } from "node:child_process";
import fs from "node:fs";
import path from "node:path";
import { performance } from "node:perf_hooks";
import { fileURLToPath } from "node:url";
import { parseArgs } from "node:util";

import React from "react";
import { renderToStaticMarkup } from "react-dom/server";
import { twMerge } from "tailwind-merge";
import { createServer } from "vite";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const repoRoot = path.resolve(__dirname, "../..");
const appRoot = path.join(repoRoot, "shadcn-ui/apps/v4");
const harnessRoot = path.join(__dirname, "vite-harness");
const EXAMPLES_BASE_DIR = path.join(appRoot, "examples/base");
const EXAMPLES_UI_DIR = path.join(appRoot, "registry/bases/base/ui");
const RESCRIPT_EXAMPLES_DIR = path.join(repoRoot, "registry/base/examples");
const RESCRIPT_UI_DIR = path.join(repoRoot, "registry/base/ui");
const MAX_DIFFS_PER_COMPONENT = 5;

// Known test failures are tracked here in order to validate a known set. Goal is to reduce this list to zero items over time.
const SKIPPED = [
  "alert-dialog-basic",
  "alert-dialog-demo",
  "alert-dialog-destructive",
  "alert-dialog-media",
  "alert-dialog-small",
  "alert-dialog-small-media",
  "attachment-demo",
  "attachment-group",
  "attachment-image",
  "attachment-states",
  "attachment-trigger",
  "avatar-badge",
  "avatar-badge-icon",
  "avatar-demo",
  "badge-spinner",
  "breadcrumb-dropdown",
  "bubble-demo",
  "bubble-group-demo",
  "bubble-reactions",
  "bubble-variants",
  "button-group-input-group",
  "button-group-nested",
  "button-group-orientation",
  "button-group-select",
  "button-group-separator",
  "button-group-split",
  "button-render",
  "button-spinner",
  "calendar-custom-days",
  "calendar-hijri",
  "calendar-time",
  "carousel-api",
  "carousel-demo",
  "carousel-multiple",
  "carousel-orientation",
  "carousel-plugin",
  "carousel-size",
  "carousel-spacing",
  "chart-demo",
  "chart-example",
  "chart-example-axis",
  "chart-example-grid",
  "chart-example-legend",
  "chart-example-tooltip",
  "chart-tooltip",
  "checkbox-table",
  "collapsible-basic",
  "collapsible-demo",
  "collapsible-file-tree",
  "collapsible-settings",
  "combobox-auto-highlight",
  "combobox-basic",
  "combobox-clear",
  "combobox-custom",
  "combobox-demo",
  "combobox-disabled",
  "combobox-groups",
  "combobox-input-group",
  "combobox-invalid",
  "combobox-popup",
  "command-demo",
  "context-menu-basic",
  "context-menu-checkboxes",
  "context-menu-demo",
  "context-menu-destructive",
  "context-menu-groups",
  "context-menu-icons",
  "context-menu-radio",
  "context-menu-shortcuts",
  "context-menu-sides",
  "context-menu-submenu",
  "data-table-demo",
  "date-picker-input",
  "date-picker-natural-language",
  "dialog-close-button",
  "dialog-demo",
  "dialog-no-close-button",
  "dialog-scrollable-content",
  "dialog-sticky-footer",
  "drawer-demo",
  "drawer-dialog",
  "drawer-sides",
  "empty-input-group",
  "field-demo",
  "field-group",
  "field-select",
  "input-form",
  "input-group-basic",
  "input-group-block-end",
  "input-group-block-start",
  "input-group-button",
  "input-group-button-group",
  "input-group-custom",
  "input-group-demo",
  "input-group-dropdown",
  "input-group-icon",
  "input-group-in-card",
  "input-group-inline-end",
  "input-group-inline-start",
  "input-group-kbd",
  "input-group-label",
  "input-group-spinner",
  "input-group-text",
  "input-group-textarea",
  "input-group-textarea-examples",
  "input-group-tooltip",
  "input-group-with-addons",
  "input-group-with-buttons",
  "input-group-with-kbd",
  "input-group-with-tooltip",
  "input-input-group",
  "input-otp-form",
  "kbd-input-group",
  "marker-demo",
  "marker-status",
  "marker-variants",
  "message-attachment",
  "message-avatar",
  "message-demo",
  "message-group",
  "message-header-footer",
  "message-scroller-demo", // tsx load: Cannot find module '@ai-sdk/react' imported from 'shadcn-ui/apps/v4/examples/base/message-
  "native-select-demo",
  "native-select-disabled",
  "native-select-groups",
  "native-select-invalid",
  "navigation-menu-demo",
  "pagination-demo",
  "pagination-icons-only",
  "progress-controlled",
  "scroll-area-demo",
  "select-align-item",
  "select-demo",
  "select-disabled",
  "select-groups",
  "select-invalid",
  "select-scrollable",
  "separator-demo",
  "separator-list",
  "separator-menu",
  "separator-vertical",
  "sheet-demo",
  "sheet-no-close-button",
  "sheet-side",
  "sidebar-demo",
  "sidebar-footer",
  "sidebar-group-collapsible",
  "sidebar-header",
  "sidebar-menu-action",
  "sidebar-menu-badge",
  "sidebar-menu-collapsible",
  "sidebar-rsc",
  "spinner-badge",
  "spinner-button",
  "spinner-demo",
  "spinner-empty",
  "spinner-input-group",
  "spinner-size",
  "table-actions",
  "table-demo",
  "table-footer",
  "tabs-vertical",
  "toggle-group-demo",
  "toggle-group-disabled",
  "toggle-group-font-weight-selector",
  "toggle-group-outline",
  "toggle-group-sizes",
  "toggle-group-spacing",
  "toggle-group-vertical",
  "ui/chart", // tsx render: Cannot convert undefined or null to object
  "ui/direction", // rescript resolve: no component export found
  "ui/message-scroller", // tsx render: useMessageScroller must be used within a MessageScroller.
  "ui/navigation-menu",
  "ui/separator",
  "ui/sidebar", // tsx render: useSidebar must be used within a SidebarProvider.
  "ui/spinner",
  "ui/toast", // tsx render: Cannot read properties of undefined (reading 'positionerProps')
];

const printHelp = () => {
  console.log(`DOM parity between upstream TSX examples and the ReScript port, rendered with react-dom/server.

Usage:
  yarn test:visual-fast [pattern] [options]

  pattern              regex matched against component ids, e.g. ^input-group- or ui/button$
                       (default: every paired component)
  --verbose            also list passes, missing ports and render warnings
  --json <file>        write machine-readable results
  -h, --help           show this help`);
};

const usageError = (message) => {
  console.error(`${message}\n`);
  printHelp();
  process.exit(2);
};

const parseCli = (argv) => {
  let parsed;
  try {
    parsed = parseArgs({
      args: argv,
      strict: true,
      allowPositionals: true,
      options: {
        verbose: { type: "boolean", default: false },
        json: { type: "string" },
        help: { type: "boolean", short: "h", default: false },
      },
    });
  } catch (error) {
    const token = /'([^']+)'/.exec(error.message)?.[1] ?? "";
    if (error.code === "ERR_PARSE_ARGS_UNKNOWN_OPTION") usageError(`Unknown option: ${token}`);
    usageError(error.message);
  }
  const { values, positionals } = parsed;
  if (values.help) {
    printHelp();
    process.exit(0);
  }
  if (positionals.length > 1) usageError(`Expected at most one pattern, got: ${positionals.join(" ")}`);
  let pattern = null;
  try {
    if (positionals.length === 1) pattern = new RegExp(positionals[0]);
  } catch (error) {
    usageError(`Invalid pattern: ${error.message}`);
  }
  return {
    pattern,
    verbose: values.verbose,
    jsonPath: values.json ?? null,
  };
};

const toPascalCase = (value) =>
  value
    .split(/[^A-Za-z0-9]+/)
    .filter(Boolean)
    .map((segment) => segment[0].toUpperCase() + segment.slice(1))
    .join("");

const listUpstreamIds = () => {
  const examples = fs
    .readdirSync(EXAMPLES_BASE_DIR)
    .filter((f) => f.endsWith(".tsx"))
    .map((f) => f.replace(/\.tsx$/, ""));
  const ui = fs
    .readdirSync(EXAMPLES_UI_DIR)
    .filter((f) => f.endsWith(".tsx"))
    .map((f) => `ui/${f.replace(/\.tsx$/, "")}`);
  return [...examples, ...ui].sort((a, b) => a.localeCompare(b));
};

const tsxPath = (id) =>
  id.startsWith("ui/") ? path.join(EXAMPLES_UI_DIR, `${id.slice(3)}.tsx`) : path.join(EXAMPLES_BASE_DIR, `${id}.tsx`);
const rescriptBase = (id) =>
  id.startsWith("ui/")
    ? path.join(RESCRIPT_UI_DIR, toPascalCase(id.slice(3)))
    : path.join(RESCRIPT_EXAMPLES_DIR, toPascalCase(id));
const hasRescriptEquivalent = (id) => fs.existsSync(`${rescriptBase(id)}.res`);
const rescriptPath = (id) => `${rescriptBase(id)}.res.mjs`;

// Same export resolution as vite-harness/main.tsx.
const resolveTsxComponent = (mod, id) => {
  if (typeof mod.default === "function") return mod.default;
  if (id.startsWith("ui/")) {
    if (id === "ui/resizable" && typeof mod.ResizablePanelGroup === "function") return mod.ResizablePanelGroup;
    const name = toPascalCase(id.slice(3));
    if (typeof mod[name] === "function") return mod[name];
    const prefixed = Object.keys(mod).find((k) => k.startsWith(name) && typeof mod[k] === "function");
    if (prefixed) return mod[prefixed];
  }
  const demo = Object.keys(mod).find((k) => k.endsWith("Demo") && typeof mod[k] === "function");
  if (demo) return mod[demo];
  const first = Object.keys(mod).find((k) => typeof mod[k] === "function");
  return first ? mod[first] : null;
};
const resolveRescriptComponent = (mod) => (mod && typeof mod.make === "function" ? mod.make : null);

// Strict tokenizer for react-dom/server output. An HTML parser would silently repair input and
// insert elements (implicit <tbody>, ...) that React's client DOM, seen by the browser harness, lacks.
const VOID_ELEMENTS = new Set([
  "area", "base", "br", "col", "embed", "hr", "img", "input", "link", "meta", "source", "track", "wbr",
]);
const RAW_TEXT_ELEMENTS = new Set(["script", "style"]);
const NAMED_ENTITIES = { amp: "&", lt: "<", gt: ">", quot: '"', apos: "'", nbsp: " " };

const decodeEntities = (value) =>
  value.replace(/&(#x[0-9a-f]+|#\d+|[a-z]+);/gi, (match, entity) => {
    if (entity[0] === "#") {
      const code = /^#x/i.test(entity) ? parseInt(entity.slice(2), 16) : parseInt(entity.slice(1), 10);
      return String.fromCodePoint(code);
    }
    return NAMED_ENTITIES[entity] ?? match;
  });

const collapseWhitespace = (text) => text.replace(/\s+/g, " ").trim();

const parseStaticMarkup = (html) => {
  const root = { type: "element", tag: "div", attributes: {}, children: [] };
  const stack = [root];
  const tokens = /<!--.*?-->|<\/([A-Za-z][\w:-]*)\s*>|<([A-Za-z][\w:-]*)((?:\s+[^\s=/>]+(?:="[^"]*")?)*)\s*(\/?)>|([^<]+)/gs;
  const unparsable = (offset) => new Error(`unparsable markup at offset ${offset}: ${html.slice(offset, offset + 60)}`);
  let consumed = 0;
  let match;
  while ((match = tokens.exec(html))) {
    if (match.index !== consumed) throw unparsable(consumed);
    consumed = match.index + match[0].length;
    const [token, closeTag, openTag, attributeText, selfClosing, text] = match;
    const parent = stack[stack.length - 1];
    if (token.startsWith("<!--")) continue;
    if (closeTag) {
      if (parent.tag !== closeTag) throw new Error(`unexpected </${closeTag}> inside <${parent.tag}>`);
      stack.pop();
      continue;
    }
    if (openTag) {
      const attributes = {};
      const attributeTokens = /([^\s=/>]+)(?:="([^"]*)")?/g;
      let attribute;
      while ((attribute = attributeTokens.exec(attributeText))) {
        attributes[attribute[1]] = decodeEntities(attribute[2] ?? "");
      }
      const element = { type: "element", tag: openTag, attributes, children: [] };
      parent.children.push(element);
      if (RAW_TEXT_ELEMENTS.has(openTag) && !selfClosing) {
        const closeAt = html.indexOf(`</${openTag}>`, consumed);
        if (closeAt < 0) throw new Error(`unclosed <${openTag}>`);
        const raw = collapseWhitespace(html.slice(consumed, closeAt));
        if (raw) element.children.push({ type: "text", text: raw });
        consumed = closeAt + `</${openTag}>`.length;
        tokens.lastIndex = consumed;
        continue;
      }
      if (!selfClosing && !VOID_ELEMENTS.has(openTag)) stack.push(element);
      continue;
    }
    const collapsed = collapseWhitespace(decodeEntities(text));
    if (collapsed) parent.children.push({ type: "text", text: collapsed });
  }
  if (consumed !== html.length) throw unparsable(consumed);
  if (stack.length !== 1) throw new Error(`unclosed elements: ${stack.slice(1).map((e) => `<${e.tag}>`).join(" ")}`);
  return root;
};

// Port of the normalization in pixel-perfect-vite.test.ts; keep in sync.
const canonicalizeClassName = (className) =>
  twMerge(className)
    .split(/\s+/)
    .filter(Boolean)
    .map((token) => {
      if (token === "text-left") return "text-start";
      if (token === "text-right") return "text-end";
      if (token.startsWith("!")) return `${token.slice(1)}!`;
      return token;
    })
    .sort()
    .join(" ");

// Set internally by Base UI or react-day-picker; ReScript's explicit `undefined` props override them.
const STRIPPED_ATTRIBUTES = [
  "tabindex", "aria-expanded", "aria-haspopup", "aria-disabled", "aria-controls",
  "data-state", "data-unchecked", "data-panel-open", "role",
  "lang", "data-selected-single", "week",
  "aria-autocomplete", "autocapitalize", "autocomplete", "autocorrect", "spellcheck",
  "data-size", "data-variant",
];

const normalizeNode = (node) => {
  if (node.type !== "element") return node;
  const attributes = { ...node.attributes };
  if (typeof attributes.class === "string") attributes.class = canonicalizeClassName(attributes.class);
  if (typeof attributes.id === "string" && attributes.id.startsWith("base-ui-")) delete attributes.id;
  for (const key of Object.keys(attributes)) if (key.startsWith("data-base-ui-")) delete attributes[key];
  if (typeof attributes.style === "string") {
    // SSR emits `a:b;c:d`, the browser `a: b; c: d;`.
    const style = attributes.style.replace(/\s+/g, "");
    if (
      attributes.type === "range" ||
      style.includes("--skeleton-width") ||
      style.includes("overflow:") ||
      style.includes("--scroll-area") ||
      style.includes("touch-action") ||
      style.includes("position:absolute;width:1px") ||
      style.includes("clip-path:inset(50%)")
    ) {
      delete attributes.style;
    }
  }
  for (const key of STRIPPED_ATTRIBUTES) delete attributes[key];
  if (attributes.alt === "") delete attributes.alt;
  if (typeof attributes["data-slot"] === "string") {
    if (attributes["data-slot"] === "combobox-trigger" || attributes["data-slot"] === "input-group-button") {
      attributes["data-slot"] = "input-group-button";
    }
    if (["sidebar-menu-button", "sidebar-menu-action", "sidebar-trigger", "sidebar-group-label"].includes(attributes["data-slot"])) {
      delete attributes["data-slot"];
    }
  }
  if (typeof attributes["data-slot"] === "string") {
    attributes["data-slot"] = attributes["data-slot"]
      .replace(/-trigger$/, "")
      .replace(
        /^(alert-dialog|collapsible|dialog|dropdown-menu|hover-card|menubar|popover|select|sheet|tooltip|context-menu|combobox|navigation-menu)$/,
        "button"
      );
  }
  if (typeof attributes.id === "string" && attributes.id.endsWith("-hidden-input")) delete attributes.id;
  return { ...node, attributes, children: node.children.map(normalizeNode) };
};

const sortKeys = (value) => {
  if (Array.isArray(value)) return value.map(sortKeys);
  if (!value || typeof value !== "object") return value;
  const sorted = {};
  for (const key of Object.keys(value).sort()) sorted[key] = sortKeys(value[key]);
  return sorted;
};

const collectDiffs = (expected, actual, at, out) => {
  if (out.length >= MAX_DIFFS_PER_COMPONENT) return;
  if (!expected || !actual) {
    const node = expected ?? actual;
    const what = node.type === "text" ? "text" : `<${node.tag}>`;
    out.push(`${at}: ${expected ? "missing in rescript" : "extra in rescript"} (${what})`);
    return;
  }
  if (expected.type !== actual.type) {
    out.push(`${at}: ${expected.type} vs ${actual.type}`);
    return;
  }
  if (expected.type === "text") {
    if (expected.text !== actual.text) out.push(`${at} text: ${JSON.stringify(expected.text)} vs ${JSON.stringify(actual.text)}`);
    return;
  }
  if (expected.tag !== actual.tag) {
    out.push(`${at}: <${expected.tag}> vs <${actual.tag}>`);
    return;
  }
  for (const key of new Set([...Object.keys(expected.attributes), ...Object.keys(actual.attributes)])) {
    if (expected.attributes[key] !== actual.attributes[key]) {
      out.push(`${at}<${expected.tag}> ${key}: ${JSON.stringify(expected.attributes[key])} vs ${JSON.stringify(actual.attributes[key])}`);
    }
  }
  if (expected.children.length !== actual.children.length) {
    out.push(`${at}<${expected.tag}> children: ${expected.children.length} vs ${actual.children.length}`);
  }
  for (let i = 0; i < Math.max(expected.children.length, actual.children.length); i += 1) {
    collectDiffs(expected.children[i], actual.children[i], `${at}/${i}`, out);
  }
};

const firstDiffs = (expected, actual) => {
  const out = [];
  collectDiffs(expected, actual, "", out);
  return out;
};

const createViteServer = () => {
  // vite-parity.config.ts aliases, minus `react` -> absolute path, which makes Vite inline React's
  // CJS build in SSR ("module is not defined"). Style trees (base-nova, base-rhea, ...) share one source.
  const alias = [
    { find: /^@\/styles\/base-[a-z]+/, replacement: path.join(appRoot, "registry/bases/base") },
    { find: "shadcn/tailwind.css", replacement: path.join(repoRoot, "app/tailwind.css") },
    { find: "shadcn/preset", replacement: path.join(repoRoot, "shadcn-ui/packages/shadcn/src/preset/index.ts") },
    { find: "@/app/(app)/create/components/icon-placeholder", replacement: path.join(harnessRoot, "icon-placeholder.tsx") },
    { find: "@/app/(create)/components/icon-placeholder", replacement: path.join(harnessRoot, "icon-placeholder.tsx") },
    { find: "@", replacement: appRoot },
    { find: "next/image", replacement: path.join(harnessRoot, "next-image.tsx") },
    { find: "next/link", replacement: path.join(harnessRoot, "next-link.tsx") },
    { find: "next/font/google", replacement: path.join(harnessRoot, "next-font-google.ts") },
  ];
  return createServer({
    configFile: false,
    root: harnessRoot,
    logLevel: "silent",
    appType: "custom",
    server: { middlewareMode: true, hmr: false, watch: null },
    esbuild: { jsx: "automatic" },
    css: { postcss: { plugins: [] } },
    optimizeDeps: { noDiscovery: true, include: [] },
    resolve: { alias },
  });
};

const firstLine = (error) => String(error?.message ?? error).split("\n")[0].replaceAll(`${repoRoot}/`, "").slice(0, 200);

const withCapturedConsole = (run) => {
  const messages = [];
  const original = { error: console.error, warn: console.warn };
  const capture = (...args) => messages.push(firstLine(args[0]));
  console.error = capture;
  console.warn = capture;
  try {
    return { value: run(), messages };
  } finally {
    console.error = original.error;
    console.warn = original.warn;
  }
};

const renderSide = async (server, modulePath, resolveComponent, id) => {
  let mod;
  try {
    mod = await server.ssrLoadModule(modulePath);
  } catch (error) {
    return { error: `load: ${firstLine(error)}` };
  }
  const Component = resolveComponent(mod, id);
  if (!Component) return { error: "resolve: no component export found" };
  try {
    const { value: html, messages } = withCapturedConsole(() => renderToStaticMarkup(React.createElement(Component)));
    return { html, warnings: messages };
  } catch (error) {
    return { error: `render: ${firstLine(error)}` };
  }
};

const { pattern, verbose, jsonPath } = parseCli(process.argv.slice(2));
const startedAt = performance.now();
const upstreamIds = listUpstreamIds();
const selectedIds = pattern ? upstreamIds.filter((id) => pattern.test(id)) : upstreamIds;
if (selectedIds.length === 0) usageError(`No component id matches ${pattern}`);
const unknownSkipped = SKIPPED.filter((id) => !upstreamIds.includes(id) || !hasRescriptEquivalent(id));
if (unknownSkipped.length > 0) usageError(`Not a paired component, remove from SKIPPED: ${unknownSkipped.join(", ")}`);
const missingIds = selectedIds.filter((id) => !hasRescriptEquivalent(id) && !id.endsWith("-rtl"));
const pairedIds = selectedIds.filter((id) => hasRescriptEquivalent(id));
const excludedIds = pairedIds.filter((id) => SKIPPED.includes(id));
const comparedIds = pairedIds.filter((id) => !excludedIds.includes(id));

const build = spawnSync(path.join(repoRoot, "node_modules/.bin/rescript"), [], { cwd: repoRoot, encoding: "utf8" });
if (build.status !== 0) {
  console.error(`rescript build failed (exit ${build.status})\n${build.stdout}${build.stderr}`);
  process.exit(2);
}

const results = { passed: [], failed: [], skipped: excludedIds, warnings: {} };
const server = await createViteServer();
try {
  for (const id of comparedIds) {
    const tsx = await renderSide(server, tsxPath(id), resolveTsxComponent, id);
    const rescript = await renderSide(server, rescriptPath(id), resolveRescriptComponent, id);
    const warnings = [...(tsx.warnings ?? []), ...(rescript.warnings ?? [])];
    if (warnings.length > 0) results.warnings[id] = warnings;
    if (tsx.error || rescript.error) {
      results.failed.push({ id, reason: `[${tsx.error ? "tsx" : "rescript"}] ${tsx.error ?? rescript.error}` });
      continue;
    }
    try {
      const expected = sortKeys(normalizeNode(parseStaticMarkup(tsx.html)));
      const actual = sortKeys(normalizeNode(parseStaticMarkup(rescript.html)));
      if (JSON.stringify(expected) === JSON.stringify(actual)) {
        results.passed.push(id);
      } else {
        results.failed.push({ id, reason: firstDiffs(expected, actual).join("\n") });
      }
    } catch (error) {
      results.failed.push({ id, reason: `[parse] ${firstLine(error)}` });
    }
  }
} finally {
  await server.close();
}

if (results.failed.length > 0) {
  console.log(`== failed (tsx vs rescript, first ${MAX_DIFFS_PER_COMPONENT} diffs per component)`);
  for (const { id, reason } of results.failed) console.log(`${id}\n  ${reason.replaceAll("\n", "\n  ")}`);
  console.log();
}
if (verbose) {
  console.log(`== passed\n${results.passed.join(", ")}\n`);
  if (excludedIds.length > 0) console.log(`== skipped (SKIPPED)\n${excludedIds.join(", ")}\n`);
  if (missingIds.length > 0) {
    console.log("== no ReScript port yet");
    for (const id of missingIds) console.log(`${id} -> expected ${path.relative(repoRoot, `${rescriptBase(id)}.res`)}`);
    console.log();
  }
  const warned = Object.entries(results.warnings);
  if (warned.length > 0) {
    console.log("== render warnings (console.error/warn during render)");
    for (const [id, warnings] of warned) console.log(`${id}\n  ${[...new Set(warnings)].join("\n  ")}`);
    console.log();
  }
}
if (jsonPath) {
  fs.writeFileSync(jsonPath, JSON.stringify(results, null, 2));
  console.log(`results written to ${jsonPath}\n`);
}
const seconds = ((performance.now() - startedAt) / 1000).toFixed(1);
console.log(`visual-fast: passed ${results.passed.length} | failed ${results.failed.length} | skipped ${excludedIds.length} | ${seconds}s`);
process.exit(results.failed.length > 0 ? 1 : 0);
