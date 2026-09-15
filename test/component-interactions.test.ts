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
    cacheDir: "test/artifacts/interactions/.vite",
    logLevel: "error",
    server: { host: "127.0.0.1", port: 0 },
    resolve: { dedupe: ["react", "react-dom", "@base-ui/react", "@shadcn/react"] },
    optimizeDeps: {
      entries: ["test/visual/vite-harness/interactions.tsx"],
      include: [
        "react", "react-dom/client", "react/jsx-runtime", "recharts",
        ...["checkbox", "switch", "tabs", "toggle", "toggle-group", "progress", "slider",
          "button", "use-render", "merge-props", "input", "menu", "dialog", "drawer", "tooltip", "separator", "scroll-area"].map(name => `@base-ui/react/${name}`),
        "react-aria-components", "sonner", "lucide-react", "cn",
        "@shadcn/react/questionnaire", "@shadcn/react/message-scroller", "@tanstack/react-table",
        "@shadcn/helpers/ai-sdk", "@shadcn/helpers/tanstack-ai", "@ai-sdk/react", "@tanstack/ai-react", "motion/react",
      ],
    },
    plugins: [{
      name: "interaction-page",
      configureServer(server) {
        server.middlewares.use("/__interactions", (_req, res) => {
          res.setHeader("Content-Type", "text/html");
          res.end(`<html><body>
            <style>
              [data-slot="chart"]{width:800px;height:250px}
              /* Keep the popup above Base UI's fixed inert backdrop without loading Tailwind. */
              [data-slot="dialog-content"],[data-slot="drawer-popup"]{position:relative;z-index:50}
            </style>
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
  const errors: string[] = [];
  page.on("pageerror", error => errors.push(error.stack || String(error)));
  await page.goto(`${origin}__interactions?fixture=${fixture}`);
  await page.waitForFunction(() => document.querySelector("#root")!.childElementCount > 0).catch(error => {
    throw new Error(errors.join("\n") || String(error));
  });
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
      await page.locator(".recharts-bar-rectangle path").hover();
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

for (const variant of ["base", "aria"]) {
  it(`${variant} Questionnaire validates required steps and follows controlled navigation`, async () => {
    const page = await browser.newPage();
    try {
      await mount(page, `registry/${variant}/examples/QuestionnaireControlled.res.mjs`);
      await page.click('[data-slot="questionnaire-next"]');
      await page.waitForSelector('fieldset:has(input[name="scope"])[data-invalid]');
      await page.click('input[name="scope"][value="component"]');
      await page.click('[data-slot="questionnaire-next"]');
      await page.waitForSelector('fieldset:has(input[name="checks"])[data-active]');
      expect(await page.$eval('p[role="status"]', el => el.textContent)).toContain("Verification");
      await page.click('[data-slot="questionnaire-previous"]');
      await page.waitForSelector('fieldset:has(input[name="scope"])[data-active]');
      expect(await page.$eval('input[name="scope"][value="component"]', el => (el as HTMLInputElement).checked)).toBe(true);
    } finally { await page.close(); }
  }, 30000);

  it(`${variant} Questionnaire skips disabled steps and includes newly enabled steps`, async () => {
    const page = await browser.newPage();
    try {
      await mount(page, `registry/${variant}/examples/QuestionnaireConditional.res.mjs`);
      await page.click('[data-slot="questionnaire-next"]');
      await page.waitForSelector('fieldset:has(input[name="approval"])[data-active]');
      await page.click('[data-slot="questionnaire-previous"]');
      await page.click('input[name="runtime"][value="cloud"]');
      await page.click('[data-slot="questionnaire-next"]');
      await page.waitForSelector('fieldset:has(input[name="environment"])[data-active]');
    } finally { await page.close(); }
  }, 30000);

  it(`${variant} Questionnaire applies shortcuts and lets freeform answers replace choices`, async () => {
    const page = await browser.newPage();
    try {
      await mount(page, `registry/${variant}/examples/QuestionnaireFreeform.res.mjs`);
      await page.focus('input[value="incremental"]');
      await page.keyboard.press("b");
      await page.waitForFunction(() => document.querySelector<HTMLInputElement>('input[value="module"]')?.checked);
      await page.type('input[aria-label="Another refactoring approach"]', "Keep the API stable");
      const answer = await page.$eval('form', form => new FormData(form).getAll("approach"));
      expect(answer).toEqual(["Keep the API stable"]);
      await mount(page, `registry/${variant}/examples/QuestionnaireShortcuts.res.mjs`);
      await page.select('select[aria-label="Shortcut style"]', "numbers");
      await page.focus('input[value="inspect"]');
      await page.keyboard.press("2");
      await page.waitForFunction(() => document.querySelector<HTMLInputElement>('input[value="tests"]')?.checked);
    } finally { await page.close(); }
  }, 30000);

  it(`${variant} Questionnaire preserves saved answers and restores them on reset`, async () => {
    const page = await browser.newPage();
    try {
      await mount(page, `registry/${variant}/examples/QuestionnaireResume.res.mjs`);
      await page.waitForSelector('fieldset:has(input[name="verification"])[data-active]');
      expect(await page.$eval('form', form => new FormData(form).getAll("verification"))).toEqual(["tests", "typecheck"]);
      await page.click('input[value="manual"]');
      expect(await page.$eval('form', form => new FormData(form).getAll("verification"))).toEqual(["tests", "typecheck", "manual"]);
      await page.click('button[type="reset"]');
      await page.waitForFunction(() => !document.querySelector<HTMLInputElement>('input[value="manual"]')?.checked);
      expect(await page.$eval('form', form => new FormData(form).getAll("verification"))).toEqual(["tests", "typecheck"]);
    } finally { await page.close(); }
  }, 30000);

  it(`${variant} Questionnaire returns to a cross-field validation error and clears it`, async () => {
    const page = await browser.newPage();
    try {
      await mount(page, `registry/${variant}/examples/QuestionnaireValidation.res.mjs`);
      await page.click('input[value="summary"]');
      await page.click('[data-slot="questionnaire-next"]');
      await page.click('input[value="public"]');
      await page.click('[data-slot="questionnaire-submit"]');
      await page.waitForSelector('fieldset:has(input[name="detail"])[data-active][data-invalid]');
      expect(await page.$eval('[role="alert"]', el => el.textContent)).toBe("Public answers need enough context. Choose a complete answer.");
      await page.click('input[value="complete"]');
      await page.waitForSelector('fieldset:has(input[name="detail"])[data-invalid]', { hidden: true });
      await page.click('[data-slot="questionnaire-next"]');
      await page.click('[data-slot="questionnaire-submit"]');
      expect(await page.$$('fieldset[data-invalid]')).toHaveLength(0);
    } finally { await page.close(); }
  }, 30000);

  it(`${variant} Table v9 filters rows and clears the filter`, async () => {
    const page = await browser.newPage();
    try {
      await mount(page, `registry/${variant}/examples/DataTableDemo.res.mjs`);
      await page.type('input[placeholder="Filter emails..."]', "ken99");
      await page.waitForFunction(() => document.querySelectorAll('tbody tr').length === 1);
      expect(await page.$eval('tbody', el => el.textContent)).toContain("ken99@example.com");
      await page.$eval('input[placeholder="Filter emails..."]', el => {
        const input = el as HTMLInputElement;
        Object.getOwnPropertyDescriptor(HTMLInputElement.prototype, "value")!.set!.call(input, "");
        input.dispatchEvent(new Event("input", { bubbles: true }));
      });
      await page.waitForFunction(() => document.querySelectorAll('tbody tr').length === 5);
    } finally { await page.close(); }
  }, 30000);
}

it("Aria HoverCard opens from its preview trigger and closes with Escape", async () => {
  const page = await browser.newPage();
  try {
    await mount(page, "registry/aria/examples/HoverCardDemo.res.mjs");
    await page.mouse.move(400, 400);
    await page.hover('button');
    await page.waitForSelector('[data-slot="hover-card-content"]', { visible: true });
    expect(await page.$eval('[data-slot="hover-card-content"]', el => el.textContent)).toContain("@nextjs");
    await page.focus("button");
    await page.keyboard.press("Escape");
    await page.waitForSelector('[data-slot="hover-card-content"]', { hidden: true });
  } finally { await page.close(); }
}, 30000);

for (const variant of ["base", "aria"]) {
  it(`${variant} Questionnaire submits its dialog form and closes the dialog`, async () => {
    const page = await browser.newPage();
    try {
      await mount(page, `registry/${variant}/examples/QuestionnaireDialog.res.mjs`);
      await page.click('button');
      await page.waitForSelector('[role="dialog"]', { visible: true });
      await page.click('input[name="scope"][value="feature"]');
      await page.click('[data-slot="questionnaire-next"]');
      await page.click('input[name="tests"][value="full"]');
      await page.click('[data-slot="questionnaire-submit"]');
      await page.waitForSelector('[role="dialog"]', { hidden: true });
    } finally { await page.close(); }
  }, 30000);
}

for (const name of ["AiSdkHelperDemo", "TanstackAiHelperDemo", "MessageScrollerStreaming", "MessageScrollerDemo"]) {
  it(`Base ${name} streams its scripted reply and resets the conversation`, async () => {
    const page = await browser.newPage();
    try {
      await mount(page, `registry/base/examples/${name}.res.mjs`);
      await page.click('button[type="submit"]');
      await page.waitForFunction(() => document.querySelectorAll('[data-slot="message-scroller-item"]').length >= 2);
      expect(await page.$eval('button[type="submit"]', button => (button as HTMLButtonElement).disabled)).toBe(true);
      await page.waitForFunction(() => document.querySelector('[data-slot="message-scroller-content"]')?.getAttribute("aria-busy") === "false", {timeout: 20000});
      expect(await page.$eval('[data-slot="message-scroller-content"]', el => el.textContent)).toContain("That's the classic streaming scroll problem.");
      if (name === "AiSdkHelperDemo" || name === "TanstackAiHelperDemo") {
        expect(await page.$eval('[data-slot="message-scroller-content"]', el => el.textContent)).toContain("Reasoning");
      }
      await page.click('button[aria-label^="Reset"]');
      await page.waitForSelector('[data-slot="empty"]');
      expect(await page.$$('[data-slot="message-scroller-item"]')).toHaveLength(0);
    } finally { await page.close(); }
  }, 40000);
}

it("Base scroll area updates its thumb when only content width changes", async () => {
  const page = await browser.newPage();
  try {
    await mount(page, "registry/base/examples/ScrollAreaHorizontalDemo.res.mjs");
    await page.addStyleTag({content: `
      [data-slot="scroll-area"], [data-slot="scroll-area-viewport"] {width:384px;height:400px}
      [data-slot="scroll-area-viewport"] > [role="presentation"] > div {width:960px;display:flex}
      [data-slot="scroll-area-viewport"] figure {width:300px;flex-shrink:0;margin:0}
    `});
    const selector = '[data-orientation="horizontal"] [data-slot="scroll-area-thumb"]';
    await page.waitForFunction(selector => (document.querySelector(selector)?.getBoundingClientRect().width ?? 0) > 0, {}, selector);
    const before = await page.$eval(selector, el => el.getBoundingClientRect().width);
    await page.$eval('[data-slot="scroll-area-viewport"] > [role="presentation"] > div', el => {
      (el as HTMLElement).style.width = "1600px";
    });
    await page.waitForFunction((selector, before) => document.querySelector(selector)!.getBoundingClientRect().width < before, {}, selector, before);
    expect(await page.$eval('[data-slot="scroll-area-viewport"]', el => el.clientWidth)).toBe(384);
  } finally { await page.close(); }
}, 30000);

it("Base nested drawers open as a stack and close only the active drawer", async () => {
  const page = await browser.newPage();
  try {
    await mount(page, "registry/base/examples/DrawerNested.res.mjs");
    await page.click('[data-slot="drawer-trigger"]');
    await page.waitForSelector('[data-slot="drawer-popup"]');
    await page.click('[data-slot="drawer-popup"] [data-slot="drawer-trigger"]');
    await page.waitForFunction(() => document.querySelectorAll('[data-slot="drawer-popup"]').length === 2);
    expect(await page.$eval('[data-nested-drawer-open]', el => el.getAttribute("data-slot"))).toBe("drawer-popup");
    await page.keyboard.press("Escape");
    await page.waitForFunction(() => document.querySelectorAll('[data-slot="drawer-popup"]').length === 1);
  } finally { await page.close(); }
}, 30000);
