%%raw("import './globals.css';")
%%raw(`
import { Geist, Geist_Mono } from "next/font/google";
const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});
`)

@val
external geistSans: Next.Font.t = "geistSans"
@val
external geistMono: Next.Font.t = "geistMono"
let metadata = {
  Next.Metadata.title: "Rescript-Shadcn",
  description: "Beautiful rescript-react components based on base-ui, distributed using shadcn",
}

@react.component
let make = (~children) => {
  <html lang="en">
    <body className={`${geistSans.variable} ${geistMono.variable} antialiased`}> {children} </body>
  </html>
}

let default = make
