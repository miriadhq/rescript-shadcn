import { afterEach, describe, expect, it, vi } from "vitest";
import React from "react";
import { renderToReadableStream, renderToStaticMarkup } from "react-dom/server";
import * as BaseSidebarRsc from "../registry/base/examples/SidebarRsc.res.mjs";
import * as AriaSidebarRsc from "../registry/aria/examples/SidebarRsc.res.mjs";

const projects = ["Design Engineering", "Sales & Marketing", "Travel", "Support", "Feedback"];

afterEach(() => vi.useRealTimers());

describe.each([
  ["Base", BaseSidebarRsc.make],
  ["Aria", AriaSidebarRsc.make],
])("%s Sidebar async example", (_, Component) => {
  it("shows skeletons while loading and links after the request resolves", async () => {
    vi.useFakeTimers({ toFake: ["setTimeout", "clearTimeout"] });

    // Each mount starts its own pending request, including repeated SSR renders.
    for (let render = 0; render < 2; render++) {
      const html = renderToStaticMarkup(React.createElement(Component));
      expect(html.match(/data-sidebar="menu-skeleton"/g)).toHaveLength(5);
      expect(html).not.toContain("Design Engineering");
    }

    const stream = await renderToReadableStream(React.createElement(Component));
    await vi.advanceTimersByTimeAsync(3000);
    await stream.allReady;
    const html = await new Response(stream).text();
    for (const project of projects) expect(html).toContain(project.replaceAll("&", "&amp;"));
    expect(html.match(/<a\b/g)).toHaveLength(5);
    expect(html).not.toContain('data-sidebar="menu-skeleton"');
  });
});
