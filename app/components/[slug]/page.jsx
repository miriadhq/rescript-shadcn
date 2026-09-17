import { notFound, redirect } from "next/navigation"
import baseMeta from "@/content/base/meta.json"
import ariaMeta from "@/content/aria/meta.json"
import { parseSelection } from "@/src/OgStyles.js"

export default async function Page({ params, searchParams }) {
  const { slug } = await params
  const selection = parseSelection(await searchParams) ?? notFound()
  const pages = selection.lib === "aria" ? ariaMeta.pages : baseMeta.pages
  if (!pages.includes(slug)) notFound()
  redirect(`/components/${slug}/${selection.lib}-${selection.style}`)
}
