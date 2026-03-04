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
                <Sidebar.MenuItem key={Int.toString(index)}>
                  <Sidebar.MenuButton render={<a href={item.url} />}>
                    <span> {item.title->React.string} </span>
                  </Sidebar.MenuButton>
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
                </Sidebar.MenuItem>
              )
              ->React.array}
            </Sidebar.Menu>
          </Sidebar.GroupContent>
        </Sidebar.Group>
      </Sidebar.Content>
    </Sidebar>
  </Sidebar.Provider>
