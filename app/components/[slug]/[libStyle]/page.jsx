import baseMeta from "@/content/base/meta.json"
import ariaMeta from "@/content/aria/meta.json"
import { notFound } from "next/navigation";
import Link from "next/link";
import MdxComponents from "@/src/MdxComponents.res.mjs";
import { getOgImagePath, parseSelection, STYLES } from "@/src/OgStyles.js";
import { make as ComponentPreview } from "@/src/ComponentPreview.res.mjs";
import { make as ComponentSource } from "@/src/ComponentSource.res.mjs";
import { make as ComponentTitle } from "@/src/ComponentTitle.res.mjs";

export const generateStaticParams = () =>
  Object.entries({ base: baseMeta, aria: ariaMeta }).flatMap(([lib, meta]) =>
    meta.pages.flatMap(slug => STYLES.map(style => ({ slug, libStyle: `${lib}-${style}` })))
  )
export const dynamicParams = false;

const PRODUCTION_URL = "https://rescript-shadcn.miriad.studio";

function getSelection(libStyle) {
  const selection = parseSelection(libStyle)
  if (!selection || `${selection.lib}-${selection.style}` !== libStyle) notFound()
  return selection
}

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
  const { slug, libStyle } = await props.params
  const selection = getSelection(libStyle)
  const { frontmatter: doc } = await getDocs(slug, selection)
  const title = `ReScript-Shadcn – ${doc.title}`
  const url = `/components/${slug}/${libStyle}`
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
export default async function Page({ params }) {
  const { slug, libStyle } = await params
  const selection = getSelection(libStyle)
  const { default: ComponentDocs, frontmatter: doc } = await getDocs(slug, selection)
  const components = {
    ...MdxComponents,
    a: ({ href, className, ...props }) => <Link
      {...props}
      href={href?.replace(/^\/components\/(?:(?:base|aria)\/)?([^/?#]+)(#[^?]*)?$/, `/components/$1/${libStyle}$2`) ?? ""}
      className={["font-medium underline underline-offset-4", className].filter(Boolean).join(" ")}
    />,
    ComponentPreview: props => <ComponentPreview {...props} selection={selection} />,
    ComponentSource: props => <ComponentSource {...props} lib={selection.lib} style={selection.style} />,
  }
  return <>
    <ComponentTitle title={doc.title} />
    {doc.description && (
      <p className="text-[1.05rem] text-muted-foreground sm:text-base sm:text-balance md:max-w-[80%]">
        {doc.description}
      </p>
    )}
    <ComponentDocs components={components} />
  </>
}
