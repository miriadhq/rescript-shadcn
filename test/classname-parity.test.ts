import { existsSync, readFileSync, readdirSync } from "node:fs";
import { basename, join } from "node:path";
import { describe, expect, test } from "vitest";

const upstreamDir = join(
  process.cwd(),
  "shadcn-ui/apps/v4/registry/bases/base/ui",
);
const rescriptDir = join(process.cwd(), "registry/base/ui");
const stylesDir = join(process.cwd(), "registry/styles");
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
});
