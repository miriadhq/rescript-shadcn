import { readFileSync } from "fs";
import { join } from "path";
import meta from "@/content/base/meta.json";
import OgDemoFrame from "./OgDemoFrame.jsx";

export const generateStaticParams = () =>
  meta.pages.map((slug) => ({ slug }));
export const dynamicParams = false;

export const metadata = {
  robots: { index: false, follow: false },
};

const DEFAULT_STYLE = "vega";
const STYLES = new Set(["vega", "nova", "lyra", "maia", "mira", "luma", "sera", "rhea"]);

function getStyleName(searchParams) {
  const style = searchParams?.style;
  return typeof style === "string" && STYLES.has(style) ? style : DEFAULT_STYLE;
}

function getFirstDemoName(slug) {
  const mdxPath = join(process.cwd(), "content", "base", `${slug}.mdx`);
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
  const demoName = getFirstDemoName(slug);
  const styleName = getStyleName(await searchParams);
  return <OgDemoFrame demoName={demoName} styleName={styleName} />;
}
