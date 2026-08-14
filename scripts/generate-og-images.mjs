#!/usr/bin/env node
/**
 * Generates OG images by screenshotting /og/render/[slug] (demo-only, no chrome).
 * Requires the dev server to be running (yarn dev).
 *
 * Usage:
 *   yarn og:generate                    # use http://localhost:3000
 *   yarn og:generate --url http://localhost:3001
 *   yarn og:generate --styles=vega,lyra # generate selected styles only
 *   yarn og:generate --limit 5          # generate first 5 only (for testing)
 */

import puppeteer from "puppeteer";
import sharp from "sharp";
import puppeteerCore from "puppeteer-core";
import chromium from "@sparticuz/chromium";
import { readFileSync, mkdirSync, writeFileSync } from "fs";
import { join, dirname } from "path";
import { fileURLToPath } from "url";
import {
  DEFAULT_STYLE,
  STYLES,
  getOgComponentSlugs,
  getOgImagePath,
  getOgRenderLib,
  getRegistryUiNames,
  getSelectionName,
  getStyleName,
} from "../src/OgStyles.js";

const __dirname = dirname(fileURLToPath(import.meta.url));
const ROOT = join(__dirname, "..");
const BASE_META_PATH = join(ROOT, "content", "base", "meta.json");
const ARIA_META_PATH = join(ROOT, "content", "aria", "meta.json");
const BASE_REGISTRY_PATH = join(ROOT, "registry.base.json");
const ARIA_REGISTRY_PATH = join(ROOT, "registry.aria.json");
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
const stylesIdx = args.indexOf("--styles");
const stylesArg =
  stylesIdx >= 0 && args[stylesIdx + 1]
    ? args[stylesIdx + 1]
    : args.find((a) => a.startsWith("--styles="))?.split("=")[1] ?? process.env.OG_STYLES;
const styles = stylesArg ? stylesArg.split(",").map(getStyleName) : STYLES;

async function main() {
  const baseMeta = JSON.parse(readFileSync(BASE_META_PATH, "utf-8"));
  const ariaMeta = JSON.parse(readFileSync(ARIA_META_PATH, "utf-8"));
  const baseComponents = getRegistryUiNames(
    JSON.parse(readFileSync(BASE_REGISTRY_PATH, "utf-8")),
  );
  const ariaComponents = getRegistryUiNames(
    JSON.parse(readFileSync(ARIA_REGISTRY_PATH, "utf-8")),
  );
  mkdirSync(OUT_DIR, { recursive: true });

  const componentSlugs = getOgComponentSlugs(baseMeta.pages, ariaMeta.pages);
  const pages = limit ? componentSlugs.slice(0, limit) : componentSlugs;
  console.log(`Generating OG images for ${pages.length} components${limit ? ` (limit ${limit})` : ""} and ${styles.length} style${styles.length === 1 ? "" : "s"}...`);
  console.log(`Base URL: ${baseUrl}`);

  const isLinux = process.platform === "linux";

  const browser = isLinux
    ? await puppeteerCore.launch({
      args: chromium.args,
      defaultViewport: null,
      executablePath: await chromium.executablePath(),
      headless: chromium.headless,
    })
    : await puppeteer.launch({
      args: ["--no-sandbox", "--disable-setuid-sandbox", "--disable-gpu"],
      headless: "shell",
    });

  try {
    const page = await browser.newPage();
    await page.setViewport({ width: OG_WIDTH / 2, height: OG_HEIGHT / 2, deviceScaleFactor: 2 });
    await page.setCacheEnabled(false);

    for (const style of styles) {
      for (const slug of pages) {
        const lib = getOgRenderLib(slug, baseComponents, ariaComponents);
        const selection = getSelectionName(`${lib}-${style}`);
        const pageUrl = `${baseUrl}/og/render/${slug}?style=${selection}`;
        try {
          const response = await page.goto(pageUrl, {
            waitUntil: "domcontentloaded",
            timeout: 30000,
          });

          if (!response || !response.ok()) {
            console.warn(`  ⚠ ${style}/${slug}: HTTP ${response?.status() ?? "error"}`);
            continue;
          }

          await page.waitForSelector("[data-og-demo]", { timeout: 15000 });
          await page.addStyleTag({ content: "nextjs-portal{display:none!important}" });
          await page.evaluate(() => document.fonts?.ready);
          await new Promise((r) => setTimeout(r, 300));

          const element = await page.$("[data-og-demo]");
          if (!element) {
            console.warn(`  ⚠ ${style}/${slug}: demo element not found`);
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

          const outPath = join(ROOT, "public", getOgImagePath(slug, style));
          mkdirSync(dirname(outPath), { recursive: true });
          writeFileSync(outPath, buffer);
          console.log(
            `  ✓ ${style === DEFAULT_STYLE ? slug : `${style}/${slug}`}.png (${lib})`,
          );
        } catch (err) {
          console.warn(`  ✗ ${style}/${slug}: ${err.message}`);
        }
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
