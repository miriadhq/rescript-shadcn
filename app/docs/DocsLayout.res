@@directive("'use client'")

type meta = {pages: array<string>}
@module("@/content/base/meta.json") external meta: meta = "default"

@react.component
let make = (~children) => {
  let pathname = Next.Navigation.usePathname()

  <div className="flex h-screen">
    <aside className="h-full w-56 shrink-0 overflow-y-auto border-r bg-background p-4">
      <Next.Link href="/" className="text-lg font-semibold mb-4">
        {"ReScript Shadcn"->React.string}
      </Next.Link>

      <nav className="flex flex-col gap-0.5">
        {meta.pages
        ->Array.map(slug => {
          let href = `/docs/${slug}`
          let isActive = pathname === href
          <Next.Link
            key={slug}
            href
            className={`rounded-md px-3 py-1.5 text-sm transition-colors ${isActive
                ? "bg-accent text-accent-foreground font-medium"
                : "text-muted-foreground hover:bg-accent/50 hover:text-foreground"}`}
          >
            {slug->React.string}
          </Next.Link>
        })
        ->React.array}
      </nav>
    </aside>
    <main className="overflow-auto w-full"> {children} </main>
  </div>
}

let default = make
