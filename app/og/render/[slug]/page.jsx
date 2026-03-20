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

export default async function OgRenderPage({ params }) {
  const { slug } = await params;
  const demoName = getFirstDemoName(slug);
  return <OgDemoFrame demoName={demoName} />;
}
