import meta from "@/content/base/meta.json"
export const generateStaticParams = () => meta.pages.map(slug => ({ "slug": slug }))
export const dynamicParams = false;


export const generateMetadata = async (props) => {
  const { slug } = await props.params
  const { frontmatter } = await import(`@/content/base/${slug}.mdx`)

  return {
    title: frontmatter?.title ?? slug,
    description: frontmatter?.description ?? "",
  }
}



export default async function Page({ params }) {
  const { slug } = await params
  const { default: Doc } = await import(`@/content/base/${slug}.mdx`)
  return <Doc />
}
