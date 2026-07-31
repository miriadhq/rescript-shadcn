import { readFileSync } from "fs";
import { join } from "path";
import baseMeta from "@/content/base/meta.json";
import ariaMeta from "@/content/aria/meta.json";
import baseRegistry from "@/registry.base.json";
import ariaRegistry from "@/registry.aria.json";
import OgDemoFrame from "./OgDemoFrame.jsx";
import {
  getOgComponentSlugs,
  getOgRenderLib,
  getRegistryUiNames,
  getStyleName,
} from "@/src/OgStyles.js";

const baseComponents = getRegistryUiNames(baseRegistry);
const ariaComponents = getRegistryUiNames(ariaRegistry);

export const generateStaticParams = () =>
  getOgComponentSlugs(baseMeta.pages, ariaMeta.pages).map((slug) => ({ slug }));
export const dynamicParams = false;

export const metadata = {
  robots: { index: false, follow: false },
};

function getFirstDemoName(slug, lib) {
  const mdxPath = join(process.cwd(), "content", lib, `${slug}.mdx`);
  try {
    const content = readFileSync(mdxPath, "utf-8");
    const match = content.match(/<ComponentPreview[\s\S]*?name="([^"]+)"/);
    return match ? match[1] : `${slug}Demo`;
  } catch {
    return `${slug}Demo`;
  }
}

export default async function OgRenderPage({ params, searchParams }) {
  const { slug } = await params;
  const libName = getOgRenderLib(slug, baseComponents, ariaComponents);
  const demoName = getFirstDemoName(slug, libName);
  const styleName = getStyleName(await searchParams);
  return <OgDemoFrame demoName={demoName} styleName={styleName} libName={libName} />;
}
