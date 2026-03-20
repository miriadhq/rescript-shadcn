import { ImageResponse } from "next/og";
import { readFile } from "node:fs/promises";
import { join } from "node:path";

async function loadGoogleFont(font, text) {
  const url = `https://fonts.googleapis.com/css2?family=${font}&text=${encodeURIComponent(text)}`;
  // Request without browser headers to get TTF (Satori doesn't support WOFF2)
  const css = await (
    await fetch(url, {
      headers: { "User-Agent": "curl/7.64.0" },
    })
  ).text();
  const resource =
    css.match(/src: url\(([^)]+)\) format\(['"](?:opentype|truetype)['"]\)/) ||
    css.match(/src: url\(([^)]+)\) format\(['"]woff['"]\)/);
  if (resource) {
    const response = await fetch(resource[1]);
    if (response.status === 200) {
      return await response.arrayBuffer();
    }
  }
  throw new Error(`Failed to load font: ${font}`);
}

// Image metadata
export const alt = "Rescript Shadcn";
export const size = {
  width: 1200,
  height: 630,
};

export const contentType = "image/png";

// Image generation
export default async function Image(_) {
  const title = "Rescript-Shadcn";
  const description = "Components";

  const geistSansData = await loadGoogleFont("Geist", `${title} ${description}`);

  const logoData = await readFile(join(process.cwd(), 'app', 'icon.svg'), 'base64')
  const logoSrc = `data:image/svg+xml;base64,${logoData}`

  return new ImageResponse(
    (
      <section tw="flex items-center bg-white h-full w-full px-24" style={{ fontFamily: "Geist" }} >
        <img src={logoSrc} alt="Rescript-Shadcn" tw="w-64 h-64 mr-16" />
        <div tw="flex flex-col w-184" >
          <h1 tw="text-7xl font-extrabold">
            {title}
          </h1>
          <p tw="text-6xl pt-6 font-bold text-slate-500">
            Components
          </p>
        </div>
      </section>
    ),
    {
      ...size,
      fonts: [
        {
          name: "Geist",
          data: geistSansData,
          style: "normal",
          weight: 700,
        },
      ],
    }
  );
}
