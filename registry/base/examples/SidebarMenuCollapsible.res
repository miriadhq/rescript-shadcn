@@directive("'use client'")

type subItem = {
  title: string,
  url: string,
}

type item = {
  title: string,
  url: string,
  items: array<subItem>,
}

let items: array<item> = [
  {
    title: "Getting Started",
    url: "#",
    items: [{title: "Installation", url: "#"}, {title: "Project Structure", url: "#"}],
  },
  {
    title: "Build Your Application",
    url: "#",
    items: [
      {title: "Routing", url: "#"},
      {title: "Data Fetching", url: "#"},
      {title: "Rendering", url: "#"},
      {title: "Caching", url: "#"},
      {title: "Styling", url: "#"},
      {title: "Optimizing", url: "#"},
      {title: "Configuring", url: "#"},
      {title: "Testing", url: "#"},
      {title: "Authentication", url: "#"},
      {title: "Deploying", url: "#"},
      {title: "Upgrading", url: "#"},
      {title: "Examples", url: "#"},
    ],
  },
  {
    title: "API Reference",
    url: "#",
    items: [
      {title: "Components", url: "#"},
      {title: "File Conventions", url: "#"},
      {title: "Functions", url: "#"},
      {title: "next.config.js Options", url: "#"},
      {title: "CLI", url: "#"},
      {title: "Edge Runtime", url: "#"},
    ],
  },
  {
    title: "Architecture",
    url: "#",
    items: [
      {title: "Accessibility", url: "#"},
      {title: "Fast Refresh", url: "#"},
      {title: "Next.js Compiler", url: "#"},
      {title: "Supported Browsers", url: "#"},
      {title: "Turbopack", url: "#"},
    ],
  },
]

@react.component
let make = () =>
  <Sidebar.Provider>
    <Sidebar>
      <Sidebar.Content>
        <Sidebar.Group>
          <Sidebar.GroupContent>
            <Sidebar.Menu>
              {items
              ->Array.mapWithIndex((item, index) =>
                <Collapsible
                  key={Int.toString(index)} className="group/collapsible" defaultOpen={index == 0}
                >
                  <Sidebar.MenuItem>
                    <Collapsible.Trigger render={<Sidebar.MenuButton />}>
                      <span> {item.title->React.string} </span>
                      <Icons.ChevronRight
                        className="ml-auto transition-transform group-data-[state=open]/collapsible:rotate-90"
                      />
                    </Collapsible.Trigger>
                    <Collapsible.Content>
                      <Sidebar.MenuSub>
                        {item.items
                        ->Array.mapWithIndex((subItem, subIndex) =>
                          <Sidebar.MenuSubItem key={Int.toString(subIndex)}>
                            <Sidebar.MenuSubButton render={<a href={subItem.url} />}>
                              <span> {subItem.title->React.string} </span>
                            </Sidebar.MenuSubButton>
                          </Sidebar.MenuSubItem>
                        )
                        ->React.array}
                      </Sidebar.MenuSub>
                    </Collapsible.Content>
                  </Sidebar.MenuItem>
                </Collapsible>
              )
              ->React.array}
            </Sidebar.Menu>
          </Sidebar.GroupContent>
        </Sidebar.Group>
      </Sidebar.Content>
    </Sidebar>
  </Sidebar.Provider>
