import { ImageResponse } from "next/og";

// Inlined for Edge runtime (no Node fs/path APIs)
const logoSvg = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 96 96" width="96" height="96"><defs></defs><g transform="matrix(1,0,0,1,0,0)"><rect fill="#ffffff" fill-opacity="0" x="0" y="0" width="96" height="96"/><g><g transform="matrix(1.066456409,0,0,1.094959393,-6.899407512,-12.078824852)"><path d="M6.469469783682094,29.296816897068346 C6.469469783682094,19.218182361289806 14.875162103147048,11.031299358969534 25.223166451575825,11.031299358969534 L77.73351712167828,11.031299358969534 C88.08152147010705,11.031299358969534 96.487213789572,19.218182361289806 96.487213789572,29.296816897068346 L96.487213789572,80.44026600374502 C96.487213789572,90.51890053952357 88.08152147010705,98.70578354184384 77.73351712167828,98.70578354184384 L25.223166451575825,98.70578354184384 C14.875162103147048,98.70578354184384 6.469469783682094,90.51890053952357 6.469469783682094,80.44026600374502 L6.469469783682094,29.296816897068346 Z" fill="#000000"/></g><g transform="matrix(1.066456409,0,0,1.094959393,-6.899407512,-12.078824852)"><path d="M52.45379523229571,29.200001634786734 C55.00295921535262,26.883390524071544 58.95543226781845,27.07229341076284 61.272043378533645,29.621457393819753 Q71.13827443349942,40.47810948251313 71.13827443349942,40.47810948251313 C71.13827443349942,40.47810948251313 71.13827443349942,40.47810948251313 71.13827443349942,40.47810948251313 Q71.13827443349942,40.47810948251313 33.37098472070438,74.79999836521324 C30.821820737647467,77.11660947592843 26.869347685181634,76.92770658923713 24.552736574466444,74.37854260618022 L18.884901713103126,68.14174247012232 C16.568290602387936,65.59257848706541 16.75719348907924,61.64010543459957 19.30635747213615,59.323494323884375 L52.45379523229571,29.200001634786734 Z" fill="#ffffff"/></g><g transform="matrix(1.066456409,0,0,1.094959393,-6.899407512,-12.078824852)"><path d="M83.03598839227924,52.57042361948592 C87.42190746546675,57.448377897319865 87.02222686992943,64.97342972888394 82.14427259209549,69.35934880207145 C77.26631831426155,73.74526787525897 69.74126648269748,73.34558727972166 65.35534740950997,68.46763300188772 C60.969428336322466,63.589678724053776 61.369108931859785,56.0646268924897 66.24706320969372,51.67870781930218 C71.12501748752766,47.29278874611467 78.65006931909173,47.692469341651986 83.03598839227924,52.57042361948592 Z" fill="#ffffff"/></g></g></g></svg>`;
const logoSrc = `data:image/svg+xml,${encodeURIComponent(logoSvg)}`;

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

// Route segment config
export const runtime = "edge";

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
