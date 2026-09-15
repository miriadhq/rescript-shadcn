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
import { isValidElementType } from "react-is";
import { renderToStaticMarkup } from "react-dom/server";
import { cn } from "cn";
import { createServer } from "vite";
import { upstreamAliases, upstreamRtl, upstreamParityFixes } from "./upstream-resolver.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const repoRoot = path.resolve(__dirname, "../..");
const appRoot = path.join(repoRoot, "shadcn-ui/apps/v4");
const harnessRoot = path.join(__dirname, "vite-harness");
const MAX_DIFFS_PER_COMPONENT = 5;

const rootPackageJson = JSON.parse(fs.readFileSync(path.join(repoRoot, "package.json"), "utf8"));
const DEDUPED_PACKAGES = Object.keys({ ...rootPackageJson.dependencies, ...rootPackageJson.devDependencies });

const VARIANTS = {
  base: {
    examplesDir: path.join(appRoot, "examples/base"),
    uiDir: path.join(appRoot, "registry/bases/base/ui"),
    rescriptExamplesDir: path.join(repoRoot, "registry/base/examples"),
    rescriptUiDir: path.join(repoRoot, "registry/base/ui"),
  },
  aria: {
    examplesDir: path.join(appRoot, "examples/aria"),
    uiDir: path.join(appRoot, "registry/bases/aria/ui"),
    rescriptExamplesDir: path.join(repoRoot, "registry/aria/examples"),
    rescriptUiDir: path.join(repoRoot, "registry/aria/ui"),
  },
};

// Unfinished example parity. Entries still run and must be removed when they pass.
const SKIPPED = {
  both: [],
  base: [],
  aria: [
    "message-scroller-demo",
    "calendar-hijri",
    "message-scroller-commands",
    "message-scroller-load-history",
    "message-scroller-previous-context",
    "message-scroller-scrollable",
    "message-scroller-streaming",
    "message-scroller-visibility",
  ],
};

// Deliberate divergences, covered by component-interactions.test.ts where behavioral.
// A load/render error remains a failure, even for one of these examples.
const EXPECTED_DIFFERENCES = {
  base: {},
  aria: {
    "bubble-link-button": "Keep type=button to avoid submitting a containing form.",
    "context-menu-shortcuts": "Keep an accessible role on the Pressable trigger.",
    "sidebar-demo": "React Aria exposes data-expanded, not data-state=open.",
  },
};

const printHelp = () => {
  console.log(`DOM parity between upstream TSX examples and the ReScript port, rendered with react-dom/server.

Usage:
  yarn test:visual-fast                            both variants; takes no arguments
  yarn test:visual-fast:base [pattern] [options]   one variant
  yarn test:visual-fast:aria [pattern] [options]

  pattern              regex matched against component ids, e.g. ^input-group- or ui/button$
                       (default: every paired component)
  --variant <base|aria>  which library variant to test; the yarn scripts above set it for you
  --verbose            also list passes, skipped, missing ports and render warnings
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
        variant: { type: "string" },
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
  if (!values.variant) usageError("Missing required --variant <base|aria>");
  if (!(values.variant in VARIANTS)) usageError(`Unknown --variant '${values.variant}', expected one of: ${Object.keys(VARIANTS).join(", ")}`);
  if (positionals.length > 1) usageError(`Expected at most one pattern, got: ${positionals.join(" ")}`);
  let pattern = null;
  try {
    if (positionals.length === 1) pattern = new RegExp(positionals[0]);
  } catch (error) {
    usageError(`Invalid pattern: ${error.message}`);
  }
  return {
    pattern,
    variantName: values.variant,
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

const listUpstreamIds = (variant) => {
  const examples = fs
    .readdirSync(variant.examplesDir)
    .filter((f) => f.endsWith(".tsx"))
    .map((f) => f.replace(/\.tsx$/, ""));
  const ui = fs
    .readdirSync(variant.uiDir)
    .filter((f) => f.endsWith(".tsx"))
    .map((f) => `ui/${f.replace(/\.tsx$/, "")}`);
  return [...examples, ...ui].sort((a, b) => a.localeCompare(b));
};

const tsxPath = (variant, id) =>
  id.startsWith("ui/") ? path.join(variant.uiDir, `${id.slice(3)}.tsx`) : path.join(variant.examplesDir, `${id}.tsx`);
const rescriptBase = (variant, id) =>
  id.startsWith("ui/")
    ? path.join(variant.rescriptUiDir, toPascalCase(id.slice(3)))
    : path.join(variant.rescriptExamplesDir, toPascalCase(id));
const hasRescriptEquivalent = (variant, id) => fs.existsSync(`${rescriptBase(variant, id)}.res`);
const rescriptPath = (variant, id) => `${rescriptBase(variant, id)}.res.mjs`;

const isComponent = (value) =>
  (typeof value === "function" || (value !== null && typeof value === "object")) && isValidElementType(value);

// Prefer the exact component export, including memo and forwardRef components.
const resolveTsxComponent = (mod, id) => {
  if (isComponent(mod.default)) return mod.default;
  if (id.startsWith("ui/")) {
    if (id === "ui/resizable" && isComponent(mod.ResizablePanelGroup)) return mod.ResizablePanelGroup;
    const name = toPascalCase(id.slice(3));
    if (isComponent(mod[name])) return mod[name];
    const prefixed = Object.keys(mod).find((k) => k.startsWith(name) && isComponent(mod[k]));
    if (prefixed) return mod[prefixed];
  }
  const demo = Object.keys(mod).find((k) => k.endsWith("Demo") && isComponent(mod[k]));
  if (demo) return mod[demo];
  const first = Object.keys(mod).find((k) => isComponent(mod[k]));
  return first ? mod[first] : null;
};
const resolveRescriptComponent = (mod, id) =>
  isComponent(mod?.make) ? mod.make : (id === "ui/direction" ? mod.Provider?.make : null);

// Bare compound components need the same minimal context and required props on both sides.
const fixture = (mod, Component, id, rescript) => {
  const part = (name) => rescript ? mod[name]?.make : mod[toPascalCase(id.slice(3)) + name];
  const child = React.createElement("div", null, "Fixture");
  switch (id) {
    case "input-group-with-tooltip": {
      const CountryExample = () => {
        const [country, setCountry] = React.useState("+1");
        return React.createElement(Component, { country, setCountry });
      };
      return React.createElement(CountryExample);
    }
    case "ui/chart":
      return React.createElement(Component, { config: {}, id: "fixture" }, child);
    case "ui/direction":
      if (variantName === "base") {
        if (rescript) return React.createElement(Component);
        const DirectionText = () => {
          const direction = mod.useDirection();
          return React.createElement("span", {dir: direction}, direction);
        };
        return React.createElement(Component, {direction: "rtl"}, React.createElement(DirectionText));
      }
      return React.createElement(Component, { direction: "ltr" }, child);
    case "ui/sidebar":
    case "ui/message-scroller":
      return React.createElement(part("Provider"), null, React.createElement(Component, null, child));
    case "ui/toast":
      return React.createElement(part("Provider"), null,
        React.createElement(part("Viewport"), null,
          React.createElement(Component, { toast: { id: "fixture", title: "Fixture", type: "info" } }, child)));
    default:
      return React.createElement(Component);
  }
};

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
  cn(className)
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

// Keep focus, roles, expanded/disabled state and panel flags visible.
// Remaining legacy exclusions include generated IDs and differing library state encodings.
const STRIPPED_ATTRIBUTES = [
  "aria-controls", "data-state",
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
    if (attributes["data-slot"] === "combobox-trigger") {
      // Would otherwise fall through the generic `-trigger` rule below and become "button".
      attributes["data-slot"] = "input-group-button";
    } else if (["sidebar-menu-button", "sidebar-menu-action", "sidebar-trigger", "sidebar-group-label"].includes(attributes["data-slot"])) {
      delete attributes["data-slot"];
    } else {
      attributes["data-slot"] = attributes["data-slot"]
        .replace(/-trigger$/, "")
        .replace(
          /^(alert-dialog|collapsible|dialog|dropdown-menu|hover-card|menubar|popover|select|sheet|tooltip|context-menu|combobox|navigation-menu)$/,
          "button"
        );
    }
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
    if (out.length >= MAX_DIFFS_PER_COMPONENT) return;
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
    ...upstreamAliases,
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
    plugins: [upstreamRtl(), upstreamParityFixes()],
    root: harnessRoot,
    logLevel: "silent",
    appType: "custom",
    server: { middlewareMode: true, hmr: false, watch: null },
    esbuild: { jsx: "automatic" },
    css: { postcss: { plugins: [] } },
    optimizeDeps: { noDiscovery: true, include: [] },
    // Both sides must share one copy of every package this repo owns, React above all: a second
    // React renders with a null hook dispatcher ("Cannot read properties of null (reading
    // 'useContext')"). The upstream examples live under the submodule, so once `pnpm install` has
    // run in there they resolve their deps from its own store instead of ours. `dedupe` pins them
    // back to the root; an `alias` to an absolute path would instead inline React's CJS build.
    resolve: { alias, dedupe: DEDUPED_PACKAGES },
  });
};

const firstLine = (error) => String(error?.message ?? error).split("\n")[0].replaceAll(`${repoRoot}/`, "").slice(0, 200);

// `messages` is handed in rather than returned, so warnings survive a throwing `run` -- React's
// explanation of a crash is logged just before it, and that is exactly when it is worth keeping.
const withCapturedConsole = (messages, run) => {
  const original = { error: console.error, warn: console.warn };
  const capture = (...args) => messages.push(firstLine(args[0]));
  console.error = capture;
  console.warn = capture;
  try {
    return run();
  } finally {
    console.error = original.error;
    console.warn = original.warn;
  }
};

const renderSide = async (server, modulePath, resolveComponent, id) => {
  let mod;
  try {
    if (variantName === "base" && id === "ui/direction" && resolveComponent === resolveRescriptComponent) {
      modulePath = path.join(harnessRoot, "DirectionParity.res.mjs");
    }
    mod = await server.ssrLoadModule(modulePath);
  } catch (error) {
    return { error: `load: ${firstLine(error)}` };
  }
  const Component = resolveComponent(mod, id);
  if (!Component) return { error: "resolve: no component export found" };
  const warnings = [];
  try {
    const html = withCapturedConsole(warnings, () => renderToStaticMarkup(fixture(mod, Component, id, resolveComponent === resolveRescriptComponent)));
    return { html, warnings };
  } catch (error) {
    return { error: `render: ${firstLine(error)}`, warnings };
  }
};

const { pattern, variantName, verbose, jsonPath } = parseCli(process.argv.slice(2));
const variant = VARIANTS[variantName];
const skipped = new Set([...SKIPPED.both, ...(SKIPPED[variantName] ?? [])]);
const expectedDifferences = EXPECTED_DIFFERENCES[variantName];
const exceptions = new Set([...skipped, ...Object.keys(expectedDifferences)]);
const startedAt = performance.now();

const build = spawnSync(path.join(repoRoot, "node_modules/.bin/rescript"), [], {
  cwd: path.join(repoRoot, `registry/${variantName}`),
  encoding: "utf8",
});
if (build.error) {
  console.error(`could not run rescript: ${build.error.message}`);
  process.exit(2);
}
if (build.status !== 0) {
  console.error(`rescript build failed (exit ${build.status})\n${build.stdout}${build.stderr}`);
  process.exit(2);
}

const upstreamIds = listUpstreamIds(variant);
const selectedIds = pattern ? upstreamIds.filter((id) => pattern.test(id)) : upstreamIds;
if (selectedIds.length === 0) {
  usageError(pattern ? `No component id matches ${pattern}` : `No components found in ${path.relative(repoRoot, variant.examplesDir)}`);
}

// A skipped id has to name a real paired component of this variant, or the list is rotting.
const upstreamSet = new Set(upstreamIds);
const straySkipped = [...exceptions].filter((id) => !upstreamSet.has(id));
if (straySkipped.length > 0) {
  usageError(`Not a component of the ${variantName} variant, remove from exceptions: ${straySkipped.join(", ")}`);
}
const unportedSkipped = [...exceptions].filter((id) => !hasRescriptEquivalent(variant, id));
if (unportedSkipped.length > 0) {
  usageError(`Not a paired component, remove from exceptions: ${unportedSkipped.join(", ")}`);
}

const missingIds = selectedIds.filter((id) => !hasRescriptEquivalent(variant, id) && !id.endsWith("-rtl"));
const comparedIds = selectedIds.filter((id) => hasRescriptEquivalent(variant, id));

const results = { passed: [], failed: [], skipped: [], fixed: [], warnings: {}, skipReasons: {}, expectedDifferences: [] };
const server = await createViteServer();
try {
  for (const id of comparedIds) {
    const tsx = await renderSide(server, tsxPath(variant, id), resolveTsxComponent, id);
    const rescript = await renderSide(server, rescriptPath(variant, id), resolveRescriptComponent, id);
    const warnings = [...(tsx.warnings ?? []), ...(rescript.warnings ?? [])];
    if (warnings.length > 0) results.warnings[id] = warnings;

    let reason = null;
    if (tsx.error || rescript.error) {
      reason = `[${tsx.error ? "tsx" : "rescript"}] ${tsx.error ?? rescript.error}`;
    } else {
      try {
        const expected = sortKeys(normalizeNode(parseStaticMarkup(tsx.html)));
        const actual = sortKeys(normalizeNode(parseStaticMarkup(rescript.html)));
        if (JSON.stringify(expected) !== JSON.stringify(actual)) reason = firstDiffs(expected, actual).join("\n");
      } catch (error) {
        reason = `[parse] ${firstLine(error)}`;
      }
    }

    // A known failure that starts passing is reported as loudly as a regression: the list must shrink.
    if (id in expectedDifferences) {
      if (tsx.error || rescript.error) results.failed.push({ id, reason });
      else if (reason) results.expectedDifferences.push({ id, explanation: expectedDifferences[id], reason });
      else results.fixed.push(id);
    } else if (skipped.has(id)) {
      if (reason) { results.skipped.push(id); results.skipReasons[id] = reason; }
      else results.fixed.push(id);
    } else if (reason) {
      results.failed.push({ id, reason });
    } else {
      results.passed.push(id);
    }
  }
} finally {
  await server.close();
}

if (results.failed.length > 0) {
  console.log(`== failed (tsx vs rescript, up to ${MAX_DIFFS_PER_COMPONENT} diffs per component)`);
  for (const { id, reason } of results.failed) console.log(`${id}\n  ${reason.replaceAll("\n", "\n  ")}`);
  console.log();
}
if (results.fixed.length > 0) {
  console.log(`== no longer failing -- remove from exceptions (${results.fixed.length})`);
  console.log(`${results.fixed.join(", ")}\n`);
}
if (verbose) {
  if (results.passed.length > 0) console.log(`== passed\n${results.passed.join(", ")}\n`);
  if (results.skipped.length > 0) {
    console.log("== skipped (unresolved differences)");
    for (const id of results.skipped) console.log(`${id}\n  ${results.skipReasons[id].replaceAll("\n", "\n  ")}`);
  }
  if (missingIds.length > 0) {
    console.log("== no ReScript port yet");
    for (const id of missingIds) console.log(`${id} -> expected ${path.relative(repoRoot, `${rescriptBase(variant, id)}.res`)}`);
    console.log();
  }
  if (results.expectedDifferences.length > 0) {
    console.log("== expected differences");
    for (const { id, explanation } of results.expectedDifferences) console.log(`${id}: ${explanation}`);
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
console.log(
  `visual-fast (${variantName}): passed ${results.passed.length} | failed ${results.failed.length}` +
  ` | skipped ${results.skipped.length} | expected differences ${results.expectedDifferences.length} | ${seconds}s`
);
process.exit(results.failed.length > 0 || results.fixed.length > 0 ? 1 : 0);
