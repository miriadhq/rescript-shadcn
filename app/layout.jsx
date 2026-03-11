import { Geist, Geist_Mono } from "next/font/google";
import "./globals.css";
import MainLayout from "./MainLayout.res.mjs";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

export const metadata = {
  title: "Rescript Shadcn",
  description: "Rescript Shadcn is a library of components for building web applications.",
  metadataBase: new URL("https://rescript-shadcn.miriad.studio"),
  openGraph: {
    title: "Rescript Shadcn",
    description: "Rescript Shadcn is a library of components for building web applications.",
    url: "https://rescript-shadcn.miriad.studio",
  },
  twitter: {
    card: "summary_large_image",
    title: "Rescript Shadcn",
    description: "Rescript Shadcn is a library of components for building web applications.",
  },
};

export default function RootLayout({
  children,
}) {
  return (
    <html lang="en">
      <body
        className={`${geistSans.variable} ${geistMono.variable} antialiased flex h-screen`}
      >
        <MainLayout>
          {children}
        </MainLayout>
      </body>
    </html >
  );
}