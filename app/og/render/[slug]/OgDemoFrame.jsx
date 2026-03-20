"use client";

import { make as DemoLoader } from "@/src/generated/DemoLoader.res.mjs";

export default function OgDemoFrame({ demoName }) {
  return (
    <div data-og-demo className="flex flex-col items-center justify-center bg-background p-8 max-w-[600px] min-h-[315px]">
      <DemoLoader name={demoName} />
    </div>
  );
}
