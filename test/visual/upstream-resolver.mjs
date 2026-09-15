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
