import fs from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";

const repoRoot = fileURLToPath(new URL("../../", import.meta.url));
const appRoot = path.join(repoRoot, "shadcn-ui/apps/v4");

export const upstreamAliases = [
  {
    find: "@shadcn/helpers/ai-sdk",
    replacement: path.join(repoRoot, "shadcn-ui/packages/helpers/src/ai-sdk/index.ts"),
  },
  {
    find: /^@\/styles\/(base|aria|radix)-[a-z]+/,
    replacement: (_match, kind) => path.join(appRoot, `registry/bases/${kind}`),
  },
];

// Keep the reference usable without reproducing these upstream bugs in ReScript.
// Fail on upstream changes so each correction is reviewed when the submodule moves.
export const upstreamParityFixes = () => ({
  name: "upstream-parity-fixes",
  enforce: "pre",
  transform(code, id) {
    const file = id.split("?")[0];
    const replace = (before, after) => {
      if (!code.includes(before)) throw new Error(`Review outdated parity reference correction: ${file}`);
      return { code: code.replaceAll(before, after), map: null };
    };
    if (file === path.join(appRoot, "registry/bases/base/ui/tabs.tsx")) {
      // The wrapper consumes orientation but never forwards it to Base UI.
      if (/\sorientation=\{orientation\}/.test(code)) {
        throw new Error(`Remove obsolete Tabs orientation correction: ${file}`);
      }
      return replace("data-orientation={orientation}", "data-orientation={orientation} orientation={orientation}");
    }
    if (file === path.join(appRoot, "registry/bases/base/ui/slider.tsx")) {
      // A scalar value needs one thumb, not the fallback [min, max] pair.
      return replace("const _values = Array.isArray(value)",
        "const _values = typeof value === 'number' ? [value] : typeof defaultValue === 'number' && value === undefined ? [defaultValue] : Array.isArray(value)");
    }
    if (file === path.join(appRoot, "examples/base/chart-demo.tsx")) {
      // This Base example accidentally imports the legacy Radix/New York wrappers.
      return replace("@/registry/new-york-v4/ui/", "@/registry/bases/base/ui/");
    }
    if (file === path.join(appRoot, "registry/bases/base/ui/scroll-area.tsx")) {
      // Observe content size too: images can load without resizing the viewport.
      return replace("        {children}\n      </ScrollAreaPrimitive.Viewport>",
        "        <ScrollAreaPrimitive.Content>{children}</ScrollAreaPrimitive.Content>\n      </ScrollAreaPrimitive.Viewport>");
    }
  },
});

// Generate the missing RTL source with the same transformer used by upstream's registry build.
export const upstreamRtl = () => ({
  name: "upstream-rtl",
  enforce: "pre",
  resolveId(id) {
    const match = /^(?:@\/styles\/(base|aria|radix)-[a-z]+|.*\/registry\/bases\/(base|aria|radix))\/ui-rtl\/(.+)$/.exec(id);
    if (match) return path.join(appRoot, `registry/bases/${match[1] ?? match[2]}/ui/${match[3]}.tsx?parity-rtl`);
  },
  async load(id) {
    if (!id.endsWith("?parity-rtl")) return;
    const { transformDirection } = await import("shadcn/utils");
    return transformDirection(await fs.readFile(id.replace(/\?parity-rtl$/, ""), "utf8"), true);
  },
});
