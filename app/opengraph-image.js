import { ImageResponse } from "next/og";
import { Geist, Geist_Mono } from "next/font/google";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

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
  return new ImageResponse(
    (
      <section tw="flex flex-col items-center pt-16 text-center px-24 bg-white">
        <h1
          style={{
            width: "100%",
            fontSize: "4.5rem",
            lineHeight: 1,
            fontWeight: 700,
          }}
        >
          Rescript Shadcn
        </h1>
        <p tw="flex flex-col text-4xl pt-8 font-bold text-slate-500">
          Rescript Shadcn is a library of components for building web applications.
        </p>
      </section>
    ),
    // ImageResponse options
    {
      ...size,
      fonts: [
        geistSans,
        geistMono,
      ],
    }
  );
}
