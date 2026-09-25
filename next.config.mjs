import { createMDX } from "fumadocs-mdx/next"

/** @type {import('next').NextConfig} */
const nextConfig = {
  pageExtensions: ["js", "jsx", "md", "mdx", "ts", "tsx"],
  outputFileTracingExcludes: {
    "*": ["./shadcn-ui/**"],
  },
  // Source previews invoke the platform-specific ReScript formatter at runtime.
  outputFileTracingIncludes: {
    "/*": [
      `./node_modules/@rescript/${process.platform}-${process.arch}/{package.json,bin.js,bin/rescript.exe,bin/bsc.exe}`,
    ],
  },
  images: {
    remotePatterns: [
      {
        protocol: "https",
        hostname: "avatars.githubusercontent.com",
      },
      {
        protocol: "https",
        hostname: "images.unsplash.com",
      },
      {
        protocol: "https",
        hostname: "avatar.vercel.sh",
      },
    ],
  },
};

const withMDX = createMDX({
  configPath: "./source.config.mjs",
});

export default withMDX(nextConfig);
