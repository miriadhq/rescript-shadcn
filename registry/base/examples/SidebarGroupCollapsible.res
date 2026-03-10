@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Sidebar.Provider>
    <Sidebar>
      <Sidebar.Content>
        <Collapsible defaultOpen={true} className="group/collapsible">
          <Sidebar.Group>
            <Sidebar.GroupLabel
              render={<Collapsible.Trigger />}
              className="hover:bg-sidebar-accent hover:text-sidebar-accent-foreground text-sm"
            >
              {"Help"->React.string}
              <Icons.ChevronDown
                className="ml-auto transition-transform group-data-[state=open]/collapsible:rotate-180"
              />
            </Sidebar.GroupLabel>
            <Collapsible.Content>
              <Sidebar.GroupContent>
                <Sidebar.Menu>
                  <Sidebar.MenuItem>
                    <Sidebar.MenuButton>
                      <Icons.LifeBuoy />
                      {"Support"->React.string}
                    </Sidebar.MenuButton>
                  </Sidebar.MenuItem>
                  <Sidebar.MenuItem>
                    <Sidebar.MenuButton>
                      <Icons.Send />
                      {"Feedback"->React.string}
                    </Sidebar.MenuButton>
                  </Sidebar.MenuItem>
                </Sidebar.Menu>
              </Sidebar.GroupContent>
            </Collapsible.Content>
          </Sidebar.Group>
        </Collapsible>
      </Sidebar.Content>
    </Sidebar>
  </Sidebar.Provider>
