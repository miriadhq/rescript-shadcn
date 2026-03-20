import meta from "@/content/base/meta.json"
import MdxComponents from "@/src/MdxComponents.res.mjs";
export const generateStaticParams = () => meta.pages.map(slug => ({ "slug": slug }))
import { make as ComponentTitle } from "@/src/ComponentTitle.res.mjs";
export const dynamicParams = false;

export const generateMetadata = async (props) => {
  const { slug } = await props.params
  const { frontmatter: doc } = await import(`@/content/base/${slug}.mdx`)
  const title = `ReScript-Shadcn – ${doc.title}`
  const images = [
    {
      url: `/og/components/${slug}.png`,
      width: 1200,
      height: 630,
    },
  ]

  return {
    title,
    description: doc.description,
    metadataBase: new URL("https://rescript-shadcn.miriad.studio"),
    openGraph: {
      title,
      description: doc.description,
      type: "article",
      url: `/components/${slug}`,
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
  const { slug } = await params
  const { default: ComponentDocs, frontmatter: doc } = await import(`@/content/base/${slug}.mdx`)
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
