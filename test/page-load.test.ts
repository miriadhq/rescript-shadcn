import { type ChildProcess, spawn } from "node:child_process"
import { readFileSync } from "node:fs"
import path from "node:path"
import { fileURLToPath } from "node:url"

import puppeteer, { type Browser } from "puppeteer"
import { afterAll, beforeAll, describe, expect, it } from "vitest"

const repoRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..")
const port = Number(process.env.PAGE_TEST_PORT ?? 3100)
const baseUrl = process.env.PAGE_TEST_BASE_URL ?? `http://127.0.0.1:${port}`
const pageTimeout = Number(process.env.PAGE_TEST_TIMEOUT_MS ?? 60_000)
const setupTimeout = Number(process.env.PAGE_TEST_SETUP_TIMEOUT_MS ?? 120_000)
const requestedStyles = new Set(
  (process.env.PAGE_TEST_STYLES ?? "")
    .split(",")
    .map((style) => style.trim())
    .filter(Boolean)
)
const requestedSlugs = new Set(
  (process.env.PAGE_TEST_SLUGS ?? "")
    .split(",")
    .map((slug) => slug.trim())
    .filter(Boolean)
)

type Style = "base-vega" | "aria-vega"

type Route = {
  name: string
  path: string
}

const styles: Array<{ name: Style; metadata: string }> = [
  { name: "base-vega", metadata: "content/base/meta.json" },
  { name: "aria-vega", metadata: "content/aria/meta.json" },
]

function readComponentPages(metadataPath: string) {
  const metadata = JSON.parse(readFileSync(path.join(repoRoot, metadataPath), "utf8")) as {
    pages: string[]
  }
  return metadata.pages
}

const componentRoutes = styles
  .filter(({ name }) => requestedStyles.size === 0 || requestedStyles.has(name))
  .flatMap(({ name, metadata }) =>
    readComponentPages(metadata)
      .filter((slug) => requestedSlugs.size === 0 || requestedSlugs.has(slug))
      .map((slug) => ({
        name: `${name}/${slug}`,
        path: `/components/${encodeURIComponent(slug)}?style=${name}`,
      }))
  )

const routes: Route[] =
  requestedStyles.size === 0 && requestedSlugs.size === 0
    ? [
        { name: "home", path: "/" },
        { name: "components", path: "/components" },
        { name: "installation", path: "/installation" },
        ...componentRoutes,
      ]
    : componentRoutes

let browser: Browser | null = null
let serverProcess: ChildProcess | null = null
let serverLogs = ""
let activeServerLogs: string[] | null = null

function delay(ms: number) {
  return new Promise((resolve) => setTimeout(resolve, ms))
}

function appendServerLogs(chunk: unknown) {
  const text = String(chunk)
  serverLogs = `${serverLogs}${text}`.slice(-100_000)
  activeServerLogs?.push(text)
}

function isTransientDevServerError(error: string) {
  return [
    "net::ERR_CONNECTION_REFUSED",
    "net::ERR_EMPTY_RESPONSE",
    "net::ERR_INCOMPLETE_CHUNKED_ENCODING",
    "net::ERR_TIMED_OUT",
  ].some((message) => error.includes(message))
}

async function waitForServer() {
  const startedAt = Date.now()

  while (Date.now() - startedAt < setupTimeout) {
    if (serverProcess && serverProcess.exitCode !== null) {
      throw new Error(
        [`Next exited before ${baseUrl} became ready.`, serverLogs].filter(Boolean).join("\n\n")
      )
    }

    try {
      const response = await fetch(baseUrl, { signal: AbortSignal.timeout(5_000) })
      if (response.status < 500) return
    } catch {
      // Retry until the server is ready or the setup timeout expires.
    }

    await delay(250)
  }

  throw new Error(
    [`Timed out waiting for the Next server at ${baseUrl}.`, serverLogs]
      .filter(Boolean)
      .join("\n\n")
  )
}

function startServer() {
  const nextBin = path.join(repoRoot, "node_modules/.bin/next")
  const child = spawn(nextBin, ["dev", "--hostname", "127.0.0.1", "--port", String(port)], {
    cwd: repoRoot,
    env: { ...process.env, NEXT_TELEMETRY_DISABLED: "1" },
    stdio: ["ignore", "pipe", "pipe"],
  })

  child.stdout?.on("data", appendServerLogs)
  child.stderr?.on("data", appendServerLogs)
  return child
}

async function stopServer() {
  if (!serverProcess || serverProcess.exitCode !== null || serverProcess.killed) return

  await new Promise<void>((resolve) => {
    const timeout = setTimeout(() => serverProcess?.kill("SIGKILL"), 10_000)
    serverProcess?.once("exit", () => {
      clearTimeout(timeout)
      resolve()
    })
    serverProcess?.kill("SIGTERM")
  })
}

beforeAll(async () => {
  if (!process.env.PAGE_TEST_BASE_URL) serverProcess = startServer()
  await waitForServer()

  browser = await puppeteer.launch({
    headless: "shell",
    args: [
      "--lang=en-US",
      "--disable-gpu",
      ...(process.env.CI
        ? ["--no-sandbox", "--disable-setuid-sandbox", "--disable-dev-shm-usage"]
        : []),
    ],
  })
}, setupTimeout)

afterAll(async () => {
  await browser?.close()
  await stopServer()
})

describe("page load smoke test", () => {
  it.each(routes)("loads $name", async ({ path: routePath }) => {
    const maxAttempts = serverProcess ? 3 : 1

    for (let attempt = 1; attempt <= maxAttempts; attempt++) {
      const page = await browser!.newPage()
      const errors: string[] = []
      const routeServerLogs: string[] = []
      let shouldRetry = false
      activeServerLogs = routeServerLogs

      page.on("pageerror", (error) => errors.push(`Uncaught exception: ${error.message}`))
      page.on("console", (message) => {
        if (message.type() === "error") {
          const source = message.location().url
          errors.push(`Console error: ${message.text()}${source ? ` (${source})` : ""}`)
        }
      })

      try {
        let response
        try {
          response = await page.goto(new URL(routePath, baseUrl).href, {
            waitUntil: "domcontentloaded",
            timeout: pageTimeout,
          })
        } catch (error) {
          errors.push(`Navigation failed: ${error instanceof Error ? error.message : String(error)}`)
        }

        if (response) {
          await page.evaluate(
            () =>
              new Promise<void>((resolve) =>
                requestAnimationFrame(() => requestAnimationFrame(() => resolve()))
              )
          )
          await delay(100)

          const bodyText = await page.evaluate(() => document.body.innerText)
          const status = response.status()

          if (status >= 400) errors.push(`Navigation returned HTTP ${status}`)
          if (bodyText.includes("Application error:")) {
            errors.push("Next rendered an application error")
          }
        } else if (errors.length === 0) {
          errors.push("Navigation returned no HTTP response")
        }

        const routeServerOutput = routeServerLogs.join("")
        if (/[⨯×] Error:/.test(routeServerOutput)) {
          errors.push(`Next server error:\n${routeServerOutput.slice(-5_000)}`)
        }

        shouldRetry =
          attempt < maxAttempts &&
          errors.length > 0 &&
          errors.every(isTransientDevServerError)

        if (!shouldRetry) {
          expect(
            errors,
            [
              `${routePath} failed to load:`,
              ...errors,
              ...(routeServerOutput
                ? ["Next server output:", routeServerOutput.slice(-10_000)]
                : []),
            ].join("\n")
          ).toEqual([])
          return
        }
      } finally {
        activeServerLogs = null
        await page.close()
      }

      if (shouldRetry) await waitForServer()
    }
  }, pageTimeout * 3 + setupTimeout + 10_000)
})
