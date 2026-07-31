import { existsSync, readFileSync } from "node:fs";
import { join } from "node:path";
import { describe, expect, it } from "vitest";

import {
  DEFAULT_SELECTION,
  getOgComponentSlugs,
  getOgRenderLib,
  getRegistryUiNames,
  getSelection,
  getSelectionName,
} from "../src/OgStyles.js";

const root = join(__dirname, "..");

describe("lib/style selection", () => {
  it("parses and serializes combined selections", () => {
    expect(getSelection("aria-mira")).toEqual({ lib: "aria", style: "mira" });
    expect(getSelectionName({ style: "base-nova" })).toBe("base-nova");
  });

  it("keeps legacy style-only links on Base UI", () => {
    expect(getSelection("lyra")).toEqual({ lib: "base", style: "lyra" });
    expect(getSelectionName("unknown")).toBe(DEFAULT_SELECTION);
  });
});

describe("library registries", () => {
  for (const lib of ["base", "aria"] as const) {
    it(`publishes a dedicated ${lib} registry`, () => {
      const registryPath = join(root, `registry.${lib}.json`);
      expect(existsSync(registryPath)).toBe(true);

      const registry = JSON.parse(readFileSync(registryPath, "utf8"));
      const button = registry.items.find((item: { name: string }) => item.name === "Button");
      expect(button.files[0].path).toMatch(new RegExp(`^registry/${lib}/ui/`));
      expect(button.dependencies).toContain(
        lib === "base" ? "rescript-base-ui" : "rescript-react-aria",
      );
    });
  }

  it("uses a combined default style in components.json", () => {
    const config = JSON.parse(readFileSync(join(root, "components.json"), "utf8"));
    expect(config.style).toBe("base-nova");
  });
});

describe("registry workspace boundaries", () => {
  const rootPackage = JSON.parse(readFileSync(join(root, "package.json"), "utf8"));
  const rootRescript = JSON.parse(readFileSync(join(root, "rescript.json"), "utf8"));

  for (const [lib, namespace] of [
    ["base", "Base"],
    ["aria", "Aria"],
  ] as const) {
    it(`compiles registry/${lib} as the ${namespace} workspace`, () => {
      const packagePath = join(root, "registry", lib, "package.json");
      const rescriptPath = join(root, "registry", lib, "rescript.json");

      expect(existsSync(packagePath)).toBe(true);
      expect(existsSync(rescriptPath)).toBe(true);
      expect(rootPackage.workspaces).toContain(`registry/${lib}`);
      expect(JSON.parse(readFileSync(rescriptPath, "utf8")).namespace).toBe(namespace);
    });
  }

  it("keeps registry sources out of the website compiler", () => {
    const sourceDirs = rootRescript.sources.map((source: string | { dir: string }) =>
      typeof source === "string" ? source : source.dir,
    );

    expect(sourceDirs).not.toContain("registry/base");
    expect(rootRescript.dependencies).toEqual(
      expect.arrayContaining(["rescript-shadcn-base", "rescript-shadcn-aria"]),
    );
    expect(rootRescript["compiler-flags"]).toContain("-open Base");
  });

  it("does not keep the temporary compiler mirror package", () => {
    expect(existsSync(join(root, "packages", "shadcn-aria"))).toBe(false);
  });
});

describe("OG component library selection", () => {
  const baseRegistry = JSON.parse(
    readFileSync(join(root, "registry.base.json"), "utf8"),
  );
  const ariaRegistry = JSON.parse(
    readFileSync(join(root, "registry.aria.json"), "utf8"),
  );
  const baseComponents = getRegistryUiNames(baseRegistry);
  const ariaComponents = getRegistryUiNames(ariaRegistry);

  it("uses Base UI as the canonical implementation for shared components", () => {
    expect(getOgRenderLib("Button", baseComponents, ariaComponents)).toBe("base");
  });

  it("uses the owning library for exclusive components", () => {
    expect(getOgRenderLib("Toast", baseComponents, ariaComponents)).toBe("base");
    expect(getOgRenderLib("AriaOnly", [], ["AriaOnly"])).toBe("aria");
  });

  it("generates one deduplicated page list across both libraries", () => {
    expect(getOgComponentSlugs(["Button", "Toast"], ["Button", "AriaOnly"])).toEqual([
      "Button",
      "Toast",
      "AriaOnly",
    ]);
  });
});
