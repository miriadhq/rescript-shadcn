import { existsSync, readFileSync, readdirSync } from "node:fs";
import { basename, join } from "node:path";
import { describe, expect, test } from "vitest";

import {
  formatCode,
  getStyleMap,
  transformRescriptSource,
} from "../src/lib/format-code.mjs";

const upstreamDir = join(
  process.cwd(),
  "shadcn-ui/apps/v4/registry/bases/base/ui",
);
const rescriptDir = join(process.cwd(), "registry/base/ui");
const stylesDir = join(process.cwd(), "registry/styles");
const styles = readdirSync(stylesDir)
  .filter(file => file.endsWith(".css"))
  .map(file => file.slice("style-".length, -".css".length));
const classHookPattern = /\bcn-[a-z0-9-]+\b/g;

const sharedUtilityHooks = new Set(["cn-menu-target", "cn-rtl-flip"]);
const translucentContentComponents = [
  {componentName: "context-menu", rescriptModule: "ContextMenu"},
  {componentName: "dropdown-menu", rescriptModule: "DropdownMenu"},
  {componentName: "menubar", rescriptModule: "Menubar"},
  {componentName: "select", rescriptModule: "Select"},
];

const toPascalCase = (name: string) =>
  name
    .split("-")
    .map((part) => `${part[0].toUpperCase()}${part.slice(1)}`)
    .join("");

const classHooks = (source: string) =>
  new Set(source.match(classHookPattern) ?? []);

const sorted = (values: Iterable<string>) => [...values].sort();
const difference = (left: Set<string>, right: Set<string>) =>
  new Set([...left].filter((value) => !right.has(value)));
const moduleSource = (source: string, moduleName: string) =>
  source.match(new RegExp(`module ${moduleName} = \\{([\\s\\S]*?)\\n\\}`))?.[1] ?? "";

const styleHooks = classHooks(
  readdirSync(stylesDir)
    .filter((file) => file.endsWith(".css"))
    .map((file) => readFileSync(join(stylesDir, file), "utf8"))
    .join("\n"),
);

const components = readdirSync(upstreamDir)
  .filter((file) => file.endsWith(".tsx"))
  .map((file) => {
    const componentName = basename(file, ".tsx");
    return {
      componentName,
      upstreamPath: join(upstreamDir, file),
      rescriptPath: join(rescriptDir, `${toPascalCase(componentName)}.res`),
    };
  });

describe("base ui className parity", () => {
  test("has a ReScript file for every upstream TSX component", () => {
    const missingFiles = components
      .filter(({ rescriptPath }) => !existsSync(rescriptPath))
      .map(({ componentName }) => componentName);

    expect(missingFiles).toEqual([]);
  });

  test.each(components)(
    "$componentName uses the same upstream cn-* class hooks",
    ({ upstreamPath, rescriptPath }) => {
      expect(existsSync(rescriptPath)).toBe(true);

      const upstreamHooks = classHooks(readFileSync(upstreamPath, "utf8"));
      const rescriptHooks = classHooks(readFileSync(rescriptPath, "utf8"));

      const missingFromRescript = sorted(difference(upstreamHooks, rescriptHooks));
      const unknownInRescript = sorted(
        difference(
          difference(difference(rescriptHooks, upstreamHooks), styleHooks),
          sharedUtilityHooks,
        ),
      );

      expect(missingFromRescript).toEqual([]);
      expect(unknownInRescript).toEqual([]);
    },
  );

  test.each(translucentContentComponents)(
    "$componentName keeps menu background hooks on its primary content",
    ({componentName, rescriptModule}) => {
      const upstreamPath = join(upstreamDir, `${componentName}.tsx`);
      const rescriptPath = join(rescriptDir, `${rescriptModule}.res`);
      const rescriptContent = moduleSource(readFileSync(rescriptPath, "utf8"), "Content");
      const requiredHooks = ["cn-menu-target", "cn-menu-translucent"];

      expect(existsSync(upstreamPath)).toBe(true);
      expect(existsSync(rescriptPath)).toBe(true);
      expect(sorted(classHooks(readFileSync(upstreamPath, "utf8")))).toEqual(
        expect.arrayContaining(requiredHooks),
      );
      expect(sorted(classHooks(rescriptContent))).toEqual(expect.arrayContaining(requiredHooks));
    },
  );

  test.each(components)(
    "$componentName publishes without cn-* markers",
    async ({rescriptPath}) => {
      const source = readFileSync(rescriptPath, "utf8");
      const transformed = await transformRescriptSource(source, getStyleMap("nova"));

      expect(classHooks(transformed)).toEqual(new Set());
    },
  );

  test("published menus use upstream's default menu color", async () => {
    const source = readFileSync(join(rescriptDir, "DropdownMenu.res"), "utf8");
    const transformed = await transformRescriptSource(source, getStyleMap("nova"));

    expect(transformed).not.toMatch(/\bcn-menu-(?:target|translucent)\b/);
    expect(transformed).not.toContain("before:backdrop-blur-2xl");
  });
});

const ariaUpstreamDir = join(
  process.cwd(),
  "shadcn-ui/apps/v4/registry/bases/aria/ui",
);
const ariaRescriptDir = join(process.cwd(), "registry/aria/ui");
const ariaComponents = readdirSync(ariaUpstreamDir)
  .filter((file) => file.endsWith(".tsx"))
  .map((file) => {
    const componentName = basename(file, ".tsx");
    return {
      componentName,
      upstreamPath: join(ariaUpstreamDir, file),
      rescriptPath: join(ariaRescriptDir, `${toPascalCase(componentName)}.res`),
    };
  });

describe("React Aria UI parity", () => {
  test("has a ReScript file for every upstream React Aria component", () => {
    expect(
      ariaComponents
        .filter(({ rescriptPath }) => !existsSync(rescriptPath))
        .map(({ componentName }) => componentName),
    ).toEqual([]);
  });

  test.each(ariaComponents)(
    "$componentName keeps the upstream cn-* class hooks",
    ({ upstreamPath, rescriptPath }) => {
      const upstreamHooks = classHooks(readFileSync(upstreamPath, "utf8"));
      const rescriptHooks = classHooks(readFileSync(rescriptPath, "utf8"));
      expect(sorted(difference(upstreamHooks, rescriptHooks))).toEqual([]);
      expect(
        sorted(
          difference(
            difference(difference(rescriptHooks, upstreamHooks), styleHooks),
            sharedUtilityHooks,
          ),
        ),
      ).toEqual([]);
    },
  );

  test.each(ariaComponents)(
    "$componentName publishes without cn-* markers",
    async ({ rescriptPath }) => {
      const transformed = await transformRescriptSource(
        readFileSync(rescriptPath, "utf8"),
        getStyleMap("mira"),
      );
      expect(classHooks(transformed)).toEqual(new Set());
    },
  );
});

describe("published style transforms", () => {
  test.each([
    '<div className="cn-unknown" />',
    'let title = cn("cn-unknown", className)',
    'let helper = "cn-unknown"',
    'let helper = `cn-unknown ${extra}`',
  ])("rejects unknown hooks before they can disappear: %s", async source => {
    await expect(transformRescriptSource(source, getStyleMap("nova")))
      .rejects.toThrow("Unresolved style hook: cn-unknown");
  });

  test("rejects missing mappings and propagates errors through docs formatting", async () => {
    const map = {...getStyleMap("nova")};
    delete map["cn-sheet-title"];
    await expect(transformRescriptSource('let title = cn("cn-sheet-title cn-font-heading", className)', map))
      .rejects.toThrow("Unresolved style hook: cn-sheet-title");
    await expect(formatCode('let title = "cn-unknown"', "nova"))
      .rejects.toThrow("Unresolved style hook: cn-unknown");
    expect(() => getStyleMap("missing")).toThrow();
  });

  test("permits explicit no-ops only in the styles that declare them", async () => {
    expect(getStyleMap("lyra")["cn-dialog-footer"]).toBe("");
    expect(getStyleMap("nova")["cn-dialog-footer"]).not.toBe("");
    expect(await transformRescriptSource('let helper = "cn-dialog-footer flex"', getStyleMap("lyra")))
      .toBe('let helper = " flex"');
  });

  for (const lib of ["base", "aria"]) {
    test.each(styles)(`${lib} Sheet.Title preserves heading typography in %s`, async style => {
      const source = readFileSync(join(process.cwd(), `registry/${lib}/ui/Sheet.res`), "utf8");
      const title = moduleSource(await transformRescriptSource(source, getStyleMap(style)), "Title");
      expect(title).toContain("font-heading");
      expect(title).not.toContain("cn-");
      for (const utility of getStyleMap(style)["cn-sheet-title"].split(/\s+/)) {
        expect(title).toContain(utility);
      }
    });

    const registry = JSON.parse(readFileSync(join(process.cwd(), `registry.${lib}.json`), "utf8"));
    const paths = new Set<string>(registry.items.flatMap(item =>
      item.files.map(file => file.path).filter(file => file.endsWith(".res"))
    ));
    const sources = [...paths].map(path => [path, readFileSync(join(process.cwd(), path), "utf8")]);
    test.each(styles)(`${lib} registry resolves every published hook in %s`, async style => {
      for (const [path, source] of sources) {
        const transformed = await transformRescriptSource(source, getStyleMap(style));
        expect(classHooks(transformed), path).toEqual(new Set());
        // Count replacements, not just disappearance: every heading must survive.
        expect(transformed.match(/\bfont-heading\b/g)?.length ?? 0, path)
          .toBe(source.match(/\b(?:cn-)?font-heading\b/g)?.length ?? 0);
      }
    }, 30_000);
  }
});
