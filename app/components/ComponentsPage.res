@@directive("'use client'")

type meta = {pages: array<string>}
@module("@/content/base/meta.json") external meta: meta = "default"

@react.component
let make = () => {
  <>
    <ComponentTitle title="Components" />
    <p className="text-[1.05rem] text-muted-foreground sm:text-base sm:text-balance md:max-w-[80%]">
      {"Browse all available components."->React.string}
    </p>
    <div className="mt-8 grid grid-cols-2 gap-3 sm:grid-cols-3 md:grid-cols-4">
      {meta.pages
      ->Array.map(slug => {
        <Next.Link
          key={slug}
          href={`/components/${slug}`}
          className="flex items-center rounded-lg border px-4 py-3 text-sm line-clamp-1
            font-medium transition-colors hover:bg-accent hover:text-accent-foreground"
        >
          {slug->React.string}
        </Next.Link>
      })
      ->React.array}
    </div>
  </>
}

let default = make
