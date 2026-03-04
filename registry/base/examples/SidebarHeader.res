@@directive("'use client'")

@react.component
let make = () =>
  <Sidebar.Provider>
    <Sidebar>
      <Sidebar.Header>
        <Sidebar.Menu>
          <Sidebar.MenuItem>
            <DropdownMenu>
              <DropdownMenu.Trigger
                render={<Sidebar.MenuButton
                  className="data-[state=open]:bg-sidebar-accent data-[state=open]:text-sidebar-accent-foreground"
                />}
              >
                {"Select Workspace"->React.string}
                <Icons.ChevronDown className="ml-auto" />
              </DropdownMenu.Trigger>
              <DropdownMenu.Content className="w-(--radix-popper-anchor-width)">
                <DropdownMenu.Item>
                  <span> {"Acme Inc"->React.string} </span>
                </DropdownMenu.Item>
                <DropdownMenu.Item>
                  <span> {"Acme Corp."->React.string} </span>
                </DropdownMenu.Item>
              </DropdownMenu.Content>
            </DropdownMenu>
          </Sidebar.MenuItem>
        </Sidebar.Menu>
      </Sidebar.Header>
    </Sidebar>
    <Sidebar.Inset>
      <header className="flex h-12 items-center justify-between px-4">
        <Sidebar.Trigger />
      </header>
    </Sidebar.Inset>
  </Sidebar.Provider>
