@@directive("'use client'")

type meta = {pages: array<string>}
@module("@/content/base/meta.json") external baseMeta: meta = "default"
@module("@/content/aria/meta.json") external ariaMeta: meta = "default"

@react.component
let make = () => {
  let pathname = Next.Navigation.usePathname()
  let (libStyle, _, _) = Config.LibStyle.use()
  let libStyleParam = libStyle->Config.LibStyle.toString
  let pages = switch libStyle.lib {
  | Config.Lib.Base => baseMeta.pages
  | Config.Lib.Aria => ariaMeta.pages
  }

  <Sidebar>
    <Sidebar.Header className="flex-row items-center gap-1">
      <Sidebar.MenuButton
        render={<Next.Link href={`/?style=${libStyleParam}`} />} className="text-sm"
      >
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
                  href={`/installation?style=${libStyleParam}`}
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
        <Sidebar.GroupLabel render={<Next.Link href={`/components?style=${libStyleParam}`} />}>
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
                    href={`${href}?style=${libStyleParam}`}
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
