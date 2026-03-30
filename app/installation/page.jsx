import MdxComponents from "@/src/MdxComponents.res.mjs"
import { make as ComponentTitle } from "@/src/ComponentTitle.res.mjs"

export const generateMetadata = async () => {
  const { frontmatter: doc } = await import("@/content/docs/Installation.mdx")
  const title = `ReScript-Shadcn – ${doc.title}`

  return {
    title,
    description: doc.description,
    metadataBase: new URL("https://rescript-shadcn.miriad.studio"),
    openGraph: {
      title,
      description: doc.description,
      type: "article",
      url: "/installation",
    },
    twitter: {
      card: "summary_large_image",
      title,
      description: doc.description,
      creator: "@miriad.studio",
    },
  }
}

export default async function InstallationPage() {
  const { default: InstallationDocs, frontmatter: doc } = await import(
    "@/content/docs/Installation.mdx"
  )

  return (
    <>
      <ComponentTitle title={doc.title} />
      {doc.description && (
        <p className="text-[1.05rem] text-muted-foreground sm:text-base sm:text-balance md:max-w-[80%]">
          {doc.description}
        </p>
      )}
      <InstallationDocs components={MdxComponents} />
    </>
  )
}
