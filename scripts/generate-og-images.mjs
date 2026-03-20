#!/usr/bin/env node
/**
 * Generates OG images by screenshotting /og/render/[slug] (demo-only, no chrome).
 * Requires the dev server to be running (yarn dev).
 *
 * Usage:
 *   yarn og:generate                    # use http://localhost:3000
 *   yarn og:generate --url http://localhost:3001
 *   yarn og:generate --limit 5          # generate first 5 only (for testing)
 */

import puppeteer from "puppeteer";
import sharp from "sharp";
import { readFileSync, mkdirSync, writeFileSync } from "fs";
import { join, dirname } from "path";
import { fileURLToPath } from "url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const ROOT = join(__dirname, "..");
const META_PATH = join(ROOT, "content", "base", "meta.json");
const OUT_DIR = join(ROOT, "public", "og", "components");

const OG_WIDTH = 1200;
const OG_HEIGHT = 630;

const args = process.argv.slice(2);
const urlIdx = args.indexOf("--url");
const baseUrl =
  urlIdx >= 0 && args[urlIdx + 1]
    ? args[urlIdx + 1]
    : args.find((a) => a.startsWith("--url="))?.split("=")[1] ?? "http://localhost:3000";

const limitIdx = args.indexOf("--limit");
const limit = limitIdx >= 0 && args[limitIdx + 1] ? parseInt(args[limitIdx + 1], 10) : null;

async function main() {
  const meta = JSON.parse(readFileSync(META_PATH, "utf-8"));
  mkdirSync(OUT_DIR, { recursive: true });

  const pages = limit ? meta.pages.slice(0, limit) : meta.pages;
  console.log(`Generating OG images for ${pages.length} components${limit ? ` (limit ${limit})` : ""}...`);
  console.log(`Base URL: ${baseUrl}`);

  const browser = await puppeteer.launch({
    headless: true,
    args: ["--no-sandbox", "--disable-setuid-sandbox"],
  });

  try {
    const page = await browser.newPage();
    await page.setViewport({ width: OG_WIDTH / 2, height: OG_HEIGHT / 2, deviceScaleFactor: 2 });
    await page.setCacheEnabled(false);

    for (const slug of pages) {
      const pageUrl = `${baseUrl}/og/render/${slug}`;
      try {
        const response = await page.goto(pageUrl, {
          waitUntil: "domcontentloaded",
          timeout: 30000,
        });

        if (!response || !response.ok()) {
          console.warn(`  ⚠ ${slug}: HTTP ${response?.status() ?? "error"}`);
          continue;
        }

        await page.waitForSelector("[data-og-demo]", { timeout: 15000 });
        await new Promise((r) => setTimeout(r, 1000));

        const element = await page.$("[data-og-demo]");
        if (!element) {
          console.warn(`  ⚠ ${slug}: demo element not found`);
          continue;
        }

        let buffer = await element.screenshot({ type: "png" });
        await element.dispose();

        buffer = await sharp(buffer)
          .resize(OG_WIDTH, OG_HEIGHT, {
            fit: "contain",
            position: "center",
            background: { r: 255, g: 255, b: 255, alpha: 1 },
          })
          .png()
          .toBuffer();

        const outPath = join(OUT_DIR, `${slug}.png`);
        writeFileSync(outPath, buffer);
        console.log(`  ✓ ${slug}.png`);
      } catch (err) {
        console.warn(`  ✗ ${slug}: ${err.message}`);
      }
    }
  } finally {
    await browser.close();
  }

  console.log(`Done. Images saved to public/og/components/`);
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
