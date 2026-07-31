@@directive("'use client'")

type meta = {pages: array<string>}
@module("@/content/base/meta.json") external baseMeta: meta = "default"
@module("@/content/aria/meta.json") external ariaMeta: meta = "default"

@react.component
let make = () => {
  let pathname = Next.Navigation.usePathname()
  let (selection, _, _) = Config.Selection.use()
  let selectionParam = selection->Config.Selection.toString
  let pages = switch selection.lib {
  | Config.Lib.Base => baseMeta.pages
  | Config.Lib.Aria => ariaMeta.pages
  }

  <Sidebar>
    <Sidebar.Header className="flex-row items-center gap-1">
      <Sidebar.MenuButton render={<Next.Link href="/" />} className="text-sm">
        <BrandIcons.RescriptShadcn className="h-2" />
        {"ReScript Shadcn"->React.string}
      </Sidebar.MenuButton>
      <ModeSwitcher />
      <Separator orientation=Vertical />
      <GithubLink />
    </Sidebar.Header>
    <Sidebar.Content>
      <Sidebar.Group>
        <Sidebar.GroupLabel> {"Get started"->React.string} </Sidebar.GroupLabel>
        <Sidebar.GroupContent>
          <Sidebar.Menu>
            <Sidebar.MenuItem>
              <Sidebar.MenuButton
                render={<Next.Link
                  href="/installation"
                  className={`rounded-md px-3 py-1.5 text-sm transition-colors ${pathname === "/installation"
                      ? "bg-accent text-accent-foreground font-medium"
                      : "text-muted-foreground hover:bg-accent/50 hover:text-foreground"}`}
                />}
              >
                {"Installation"->React.string}
              </Sidebar.MenuButton>
            </Sidebar.MenuItem>
          </Sidebar.Menu>
        </Sidebar.GroupContent>
      </Sidebar.Group>
      <Sidebar.Group>
        <Sidebar.GroupLabel render={<Next.Link href={`/components?style=${selectionParam}`} />}>
          {"Components"->React.string}
        </Sidebar.GroupLabel>
        <Sidebar.GroupContent>
          <Sidebar.Menu>
            {pages
            ->Array.map(slug => {
              let href = `/components/${slug}`
              let isActive = pathname === href
              <Sidebar.MenuItem key={slug}>
                <Sidebar.MenuButton
                  render={<Next.Link
                    href={`${href}?style=${selectionParam}`}
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
