import meta from "@/content/base/meta.json"
import MdxComponents from "@/src/MdxComponents.res.mjs";
export const generateStaticParams = () => meta.pages.map(slug => ({ "slug": slug }))
import { make as ComponentTitle } from "@/src/ComponentTitle.res.mjs";
export const dynamicParams = false;

function absoluteUrl(path) {
  return `${process.env.NEXT_PUBLIC_APP_URL}${path}`
}

export const generateMetadata = async (props) => {
  const { slug } = await props.params
  const { frontmatter: doc } = await import(`@/content/base/${slug}.mdx`)

  return {
    title: doc.title,
    description: doc.description,
    openGraph: {
      title: doc.title,
      description: doc.description,
      type: "article",
      url: absoluteUrl(`/components/${slug}`),
      images: [
        {
          url: absoluteUrl(`/og/components/${slug}.png`),
          width: 1200,
          height: 630,
        },
      ],
    },
    twitter: {
      card: "summary_large_image",
      title: doc.title,
      description: doc.description,
      images: [
        {
          url: absoluteUrl(`/og/components/${slug}.png`),
        },
      ],
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
