import baseMeta from "@/content/base/meta.json"
import ariaMeta from "@/content/aria/meta.json"
import { notFound } from "next/navigation";
import MdxComponents from "@/src/MdxComponents.res.mjs";
import { getOgImagePath, parseSelection } from "@/src/OgStyles.js";
export const generateStaticParams = () => [...new Set([...baseMeta.pages, ...ariaMeta.pages])].map(slug => ({ "slug": slug }))
import { make as ComponentTitle } from "@/src/ComponentTitle.res.mjs";
export const dynamicParams = false;

const PRODUCTION_URL = "https://rescript-shadcn.miriad.studio";

async function getDocs(slug, selection) {
  const { lib } = selection
  const pages = lib === "aria" ? ariaMeta.pages : baseMeta.pages
  if (!pages.includes(slug)) notFound()
  return lib === "aria"
    ? import(`@/content/aria/${slug}.mdx`)
    : import(`@/content/base/${slug}.mdx`)
}

function getMetadataBase() {
  return new URL(
    process.env.VERCEL_ENV === "preview" && process.env.VERCEL_URL
      ? `https://${process.env.VERCEL_URL}`
      : PRODUCTION_URL
  );
}

export const generateMetadata = async (props) => {
  const { slug } = await props.params
  const searchParams = await props.searchParams
  const selection = parseSelection(searchParams) ?? notFound()
  const { frontmatter: doc } = await getDocs(slug, selection)
  const title = `ReScript-Shadcn – ${doc.title}`
  const url = `/components/${slug}?style=${selection.lib}-${selection.style}`
  const images = [
    {
      url: getOgImagePath(slug, selection.style),
      width: 1200,
      height: 630,
    },
  ]

  return {
    title,
    description: doc.description,
    metadataBase: getMetadataBase(),
    openGraph: {
      title,
      description: doc.description,
      type: "article",
      url,
      images,
    },
    twitter: {
      card: "summary_large_image",
      title,
      description: doc.description,
      images,
      creator: "@miriad.studio",
    },
  }
}



export default async function Page({ params, searchParams }) {
  const { slug } = await params
  const selection = parseSelection(await searchParams) ?? notFound()
  const { default: ComponentDocs, frontmatter: doc } = await getDocs(slug, selection)
  return <>
    <ComponentTitle title={doc.title} />
    {doc.description && (
      <p className="text-[1.05rem] text-muted-foreground sm:text-base sm:text-balance md:max-w-[80%]">
        {doc.description}
      </p>
    )}
    <ComponentDocs components={MdxComponents} />
  </>
}
