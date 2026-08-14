@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Sidebar.Provider>
    <Sidebar>
      <Sidebar.Header />
      <Sidebar.Content />
      <Sidebar.Footer>
        <Sidebar.Menu>
          <Sidebar.MenuItem>
            <DropdownMenu.Trigger>
              <Sidebar.MenuButton
                className="data-[state=open]:bg-sidebar-accent data-[state=open]:text-sidebar-accent-foreground"
              >
                {"Username"->React.string}
                <Icons.ChevronUp className="ml-auto" />
              </Sidebar.MenuButton>
              <DropdownMenu
                placement=ReactAria.Common.TopStart className="w-(--radix-popper-anchor-width)"
              >
                <DropdownMenu.Item>
                  <span> {"Account"->React.string} </span>
                </DropdownMenu.Item>
                <DropdownMenu.Item>
                  <span> {"Billing"->React.string} </span>
                </DropdownMenu.Item>
                <DropdownMenu.Item>
                  <span> {"Sign out"->React.string} </span>
                </DropdownMenu.Item>
              </DropdownMenu>
            </DropdownMenu.Trigger>
          </Sidebar.MenuItem>
        </Sidebar.Menu>
      </Sidebar.Footer>
    </Sidebar>
    <Sidebar.Inset>
      <header className="flex h-12 items-center justify-between px-4">
        <Sidebar.Trigger />
      </header>
    </Sidebar.Inset>
  </Sidebar.Provider>
