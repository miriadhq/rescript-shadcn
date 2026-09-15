import { afterAll, beforeAll, expect, it } from "vitest";
import { createServer, type ViteDevServer } from "vite";
import puppeteer, { type Browser, type Page } from "puppeteer";

let server: ViteDevServer;
let browser: Browser;
let origin: string;

beforeAll(async () => {
  server = await createServer({
    configFile: false,
    root: process.cwd(),
    logLevel: "error",
    server: { host: "127.0.0.1", port: 0 },
    resolve: { dedupe: ["react", "react-dom", "@base-ui/react", "@shadcn/react"] },
    optimizeDeps: {
      entries: ["test/visual/vite-harness/interactions.tsx"],
      include: [
        "react", "react-dom/client", "react/jsx-runtime", "recharts",
        ...["checkbox", "switch", "tabs", "toggle", "toggle-group", "progress", "slider",
          "button", "use-render", "merge-props"].map(name => `@base-ui/react/${name}`),
        "react-aria-components", "sonner", "lucide-react",
      ],
    },
    plugins: [{
      name: "interaction-page",
      configureServer(server) {
        server.middlewares.use("/__interactions", (_req, res) => {
          res.setHeader("Content-Type", "text/html");
          res.end(`<html><body>
            <style>[data-slot="chart"]{width:800px;height:250px}</style>
            <div id="root"></div>
            <script type="module" src="/test/visual/vite-harness/interactions.tsx"></script>
          </body></html>`);
        });
      },
    }],
  });
  await server.listen();
  origin = server.resolvedUrls!.local[0];
  browser = await puppeteer.launch({
    headless: "shell",
    args: ["--lang=en-US", ...(process.env.CI ? ["--no-sandbox"] : [])],
  });
}, 60000);

afterAll(async () => {
  await browser?.close();
  await server?.close();
});

async function mount(page: Page, file: string, props = {}, form = false) {
  page.setDefaultTimeout(10000);
  const fixture = encodeURIComponent(JSON.stringify({ file, props, form }));
  await page.goto(`${origin}__interactions?fixture=${fixture}`);
  await page.waitForFunction(() => document.querySelector("#root")!.childElementCount > 0);
}

for (const variant of ["base", "aria"]) {
  it(`${variant} chart switches series with click and keyboard and displays a tooltip`, async () => {
    const page = await browser.newPage();
    try {
      await mount(page, `registry/${variant}/examples/ChartDemo.res.mjs`);
      await page.waitForSelector(".recharts-bar-rectangle path");
      expect(await page.$eval('button[data-active="true"]', el => el.textContent)).toContain("Desktop");
      expect(await page.$$eval("button[data-active]", buttons => buttons.map(el => el.textContent))).toEqual(["Desktop7,324", "Mobile7,250"]);
      const buttons = await page.$$("button[data-active]");
      await buttons[1].click();
      await page.waitForFunction(() => document.querySelector('button[data-active="true"]')?.textContent?.includes("Mobile"));
      await page.waitForFunction(() => document.querySelector('.recharts-bar-rectangle path')?.getAttribute("fill") === "var(--color-mobile)");
      await buttons[0].focus();
      await page.keyboard.press("Enter");
      await page.waitForFunction(() => document.querySelector('.recharts-bar-rectangle path')?.getAttribute("fill") === "var(--color-desktop)");
      await page.hover(".recharts-bar-rectangle path");
      await page.waitForFunction(() => document.querySelector(".recharts-tooltip-wrapper")?.textContent?.includes("Page Views"));
      const tooltip = await page.$eval(".recharts-tooltip-wrapper", el => el.textContent);
      expect(tooltip).toMatch(/Apr \d+, 2024/);
      expect(tooltip).toMatch(/\d/);
    } finally {
      await page.close();
    }
  }, 30000);
}

it("Base checkboxes and switches preserve focus defaults and disabled state", async () => {
  const page = await browser.newPage();
  try {
    for (const [component, role] of [["Checkbox", "checkbox"], ["Switch", "switch"]]) {
      await mount(page, `registry/base/ui/${component}.res.mjs`, { "aria-label": component });
      await page.focus(`[role="${role}"]`);
      expect(await page.$eval(`[role="${role}"]`, el => el.getAttribute("tabindex"))).toBe("0");
      await page.keyboard.press("Space");
      await page.waitForFunction(role => document.querySelector(`[role="${role}"]`)?.getAttribute("aria-checked") === "true", {}, role);
      await mount(page, `registry/base/ui/${component}.res.mjs`, { disabled: true, "aria-label": component });
      expect(await page.$eval(`[role="${role}"]`, el => el.getAttribute("tabindex"))).toBe("-1");
      expect(await page.$eval(`[role="${role}"]`, el => el.getAttribute("aria-disabled"))).toBe("true");
    }
  } finally {
    await page.close();
  }
}, 30000);

it("Base vertical tabs and toggle groups move focus with ArrowDown", async () => {
  const page = await browser.newPage();
  try {
    for (const [component, selector] of [["TabsVertical", '[role="tab"]'], ["ToggleGroupVertical", "button"]]) {
      await mount(page, `registry/base/examples/${component}.res.mjs`);
      const items = await page.$$(selector);
      await items[0].focus();
      await page.keyboard.press("ArrowDown");
      await page.waitForFunction(el => document.activeElement === el, {}, items[1]);
      expect(await items[1].evaluate(el => el.getAttribute("tabindex"))).toBe("0");
    }
  } finally {
    await page.close();
  }
}, 30000);

it("Base scalar progress control has one keyboard-operable slider thumb", async () => {
  const page = await browser.newPage();
  try {
    await mount(page, "registry/base/examples/ProgressControlled.res.mjs");
    const sliders = await page.$$('input[type="range"]');
    expect(sliders).toHaveLength(1);
    await sliders[0].focus();
    await page.keyboard.press("ArrowRight");
    await page.waitForFunction(() => document.querySelector('[role="progressbar"]')?.getAttribute("aria-valuenow") === "51");
  } finally {
    await page.close();
  }
}, 30000);

it("Aria bubble actions do not submit their containing form", async () => {
  const page = await browser.newPage();
  try {
    await mount(page, "registry/aria/examples/BubbleLinkButton.res.mjs", {}, true);
    const buttons = await page.$$("button");
    expect(buttons).toHaveLength(3);
    for (const button of buttons) {
      expect(await button.evaluate(el => el.getAttribute("type"))).toBe("button");
      await button.click();
    }
    expect(await page.evaluate(() => document.body.dataset.submitted)).toBeUndefined();
  } finally {
    await page.close();
  }
}, 30000);

it("Aria disclosure exposes expanded state used by the sidebar selector", async () => {
  const page = await browser.newPage();
  try {
    await mount(page, "registry/aria/examples/CollapsibleDemo.res.mjs");
    const trigger = await page.$('button[aria-expanded]');
    expect(await trigger!.evaluate(el => el.getAttribute("aria-expanded"))).toBe("false");
    await trigger!.focus();
    await page.keyboard.press("Enter");
    await page.waitForSelector('[data-slot="collapsible"][data-expanded]');
    expect(await trigger!.evaluate(el => el.getAttribute("aria-expanded"))).toBe("true");
  } finally {
    await page.close();
  }
}, 30000);

it("Base custom button targets retain keyboard button semantics", async () => {
  const page = await browser.newPage();
  try {
    await mount(page, "registry/base/ui/Button.res.mjs");
    const button = await page.$('a[role="button"]');
    expect(button).not.toBeNull();
    expect(await button!.evaluate(el => el.getAttribute("tabindex"))).toBe("0");
    await button!.focus();
    await page.keyboard.press("Space");
    await page.waitForFunction(() => document.body.dataset.activated === "true");
  } finally {
    await page.close();
  }
}, 30000);

it("Aria context-menu trigger exposes a role and opens its menu", async () => {
  const page = await browser.newPage();
  try {
    await mount(page, "registry/aria/examples/ContextMenuShortcuts.res.mjs");
    await page.click('[role="button"]', { button: "right" });
    await page.waitForSelector('[role="menu"]');
    await page.keyboard.press("Escape");
    await page.waitForSelector('[role="menu"]', { hidden: true });
  } finally {
    await page.close();
  }
}, 30000);
