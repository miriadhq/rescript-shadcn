import { NextResponse } from "next/server";

/**
 * Redirects to the pre-generated OG image.
 * Run `yarn og:generate` (with dev server running) to generate images.
 */
export default async function Image({ params }) {
  const { slug } = await params;
  const baseUrl =
    process.env.VERCEL_URL
      ? `https://${process.env.VERCEL_URL}`
      : process.env.NEXT_PUBLIC_APP_URL ?? "http://localhost:3000";
  return NextResponse.redirect(`${baseUrl}/og/components/${slug}.png`);
}
