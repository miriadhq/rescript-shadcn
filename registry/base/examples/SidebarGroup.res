@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Sidebar.Provider>
    <Sidebar>
      <Sidebar.Content>
        <Sidebar.Group>
          <Sidebar.GroupLabel> {"Help"->React.string} </Sidebar.GroupLabel>
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
        </Sidebar.Group>
      </Sidebar.Content>
    </Sidebar>
  </Sidebar.Provider>
