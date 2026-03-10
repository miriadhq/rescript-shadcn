import meta from "@/content/base/meta.json"
export const generateStaticParams = () => meta.pages.map(slug => ({ "slug": slug }))
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
          url: `/og?title=${encodeURIComponent(
            doc.title
          )}&description=${encodeURIComponent(doc.description)}`,
        },
      ],
    },
    twitter: {
      card: "summary_large_image",
      title: doc.title,
      description: doc.description,
      images: [
        {
          url: `/og?title=${encodeURIComponent(
            doc.title
          )}&description=${encodeURIComponent(doc.description)}`,
        },
      ],
      creator: "@miriad.studio",
    },
  }
}



export default async function Page({ params }) {
  const { slug } = await params
  const { default: ComponentDocs, frontmatter: doc } = await import(`@/content/base/${slug}.mdx`)
  return <div data-slot="component-docs" className="flex flex-col scroll-mt-24 items-center pb-8 text-[1.05rem] sm:text-[15px] xl:w-full p-5">
    <div className="max-w-160">
      <h1 className="scroll-m-24 text-3xl font-semibold tracking-tight sm:text-3xl">
        {doc.title}
      </h1>
      {doc.description && (
        <p className="text-[1.05rem] text-muted-foreground sm:text-base sm:text-balance md:max-w-[80%]">
          {doc.description}
        </p>
      )}
      <ComponentDocs />
    </div>
  </div>
}
