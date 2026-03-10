@@directive("'use client'")

type meta = {pages: array<string>}
@module("@/content/base/meta.json") external meta: meta = "default"

@react.component
let make = () => {
  let pathname = Next.Navigation.usePathname()

  <Sidebar>
    <Sidebar.Header>
      <Sidebar.MenuButton render={<Next.Link href="/" />}>
        {"ReScript Shadcn"->React.string}
      </Sidebar.MenuButton>
    </Sidebar.Header>
    <Sidebar.Content>
      <Sidebar.Group>
        <Sidebar.GroupLabel> {"Components"->React.string} </Sidebar.GroupLabel>
        <Sidebar.GroupContent>
          <Sidebar.Menu>
            {meta.pages
            ->Array.map(slug => {
              let href = `/components/${slug}`
              let isActive = pathname === href
              <Sidebar.MenuItem key={slug}>
                <Sidebar.MenuButton
                  render={<Next.Link
                    href
                    className={`rounded-md px-3 py-1.5 text-sm transition-colors ${isActive
                        ? "bg-accent text-accent-foreground font-medium"
                        : "text-muted-foreground hover:bg-accent/50 hover:text-foreground"}`}
                  />}
                >
                  {slug->React.string}
                </Sidebar.MenuButton>
              </Sidebar.MenuItem>
            })
            ->React.array}
          </Sidebar.Menu>
        </Sidebar.GroupContent>
      </Sidebar.Group>
    </Sidebar.Content>
  </Sidebar>
}
