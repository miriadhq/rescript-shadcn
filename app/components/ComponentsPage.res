@@directive("'use client'")

type meta = {pages: array<string>}
@module("@/content/base/meta.json") external meta: meta = "default"

@react.component
let make = () => {
  <div
    className="flex flex-col scroll-mt-24 items-center pb-8 text-[1.05rem] sm:text-[15px] xl:w-full p-5"
  >
    <div className="max-w-160 w-full">
      <h1 className="scroll-m-24 text-3xl font-semibold tracking-tight sm:text-3xl">
        {"Components"->React.string}
      </h1>
      <p className="text-[1.05rem] text-muted-foreground sm:text-base sm:text-balance md:max-w-[80%]">
        {"Browse all available components."->React.string}
      </p>
      <div className="mt-8 grid grid-cols-2 gap-3 sm:grid-cols-3 md:grid-cols-4">
        {meta.pages
        ->Array.map(slug => {
          <Next.Link
            key={slug}
            href={`/components/${slug}`}
            className="flex items-center rounded-lg border px-4 py-3 text-sm font-medium transition-colors hover:bg-accent hover:text-accent-foreground"
          >
            {slug->React.string}
          </Next.Link>
        })
        ->React.array}
      </div>
    </div>
  </div>
}

let default = make
