#!/usr/bin/env node
/**
 * Build script that generates OG images before the Next.js build.
 * Runs on Vercel: starts next server, screenshots demo-only pages, then builds.
 *
 * Usage: node scripts/build-with-og.mjs
 */

import { spawn } from "child_process";

const PORT = 3000;
const BASE_URL = `http://localhost:${PORT}`;

async function waitForServer(timeoutMs = 120000) {
  const start = Date.now();
  while (Date.now() - start < timeoutMs) {
    try {
      const res = await fetch(BASE_URL);
      if (res.ok) return;
    } catch {
      await new Promise((r) => setTimeout(r, 1000));
    }
  }
  throw new Error("Server did not become ready in time");
}

async function run(cmd, args) {
  return new Promise((resolve, reject) => {
    const proc = spawn(cmd, args, { stdio: "inherit", shell: true });
    proc.on("close", (code) =>
      code === 0 ? resolve() : reject(new Error(`Exit ${code}`))
    );
    proc.on("error", reject);
  });
}

async function main() {
  console.log("Building Next.js app for OG image generation...");
  await run("yarn", ["next", "build"]);

  console.log("Starting production server for OG screenshots...");
  const server = spawn("yarn", ["start"], {
    stdio: "pipe",
    env: { ...process.env, PORT: String(PORT) },
  });

  try {
    await waitForServer();
    console.log("Next server ready. Generating OG images...");

    await run("node", [
      "scripts/generate-og-images.mjs",
      "--url",
      BASE_URL,
      ...(process.env.OG_LIMIT ? ["--limit", process.env.OG_LIMIT] : []),
    ]);

    console.log("OG images generated.");
  } finally {
    server.kill("SIGTERM");
    await new Promise((r) => setTimeout(r, 3000));
    try {
      server.kill("SIGKILL");
    } catch { }
  }

  console.log("Build complete.");
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
