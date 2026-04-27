import { Geist, Geist_Mono } from "next/font/google";
import "./globals.css";
import MainLayout from "./MainLayout.res.mjs";
import { Analytics } from "@vercel/analytics/next";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

const title = "Rescript-Shadcn";
const description = "The design system for your ReScript web applications.";

export const metadata = {
  title,
  description,
  metadataBase: new URL("https://rescript-shadcn.miriad.studio"),
  openGraph: {
    title,
    description,
    url: "https://rescript-shadcn.miriad.studio",
  },
  twitter: {
    card: "summary_large_image",
    title,
    description,
  },
};

export default function RootLayout({
  children,
}) {
  return (
    <html lang="en" suppressHydrationWarning>
      <body
        className={`${geistSans.variable} ${geistMono.variable} antialiased`}
      >
        <Analytics />
        <MainLayout>
          {children}
        </MainLayout>
      </body>
    </html >
  );
}