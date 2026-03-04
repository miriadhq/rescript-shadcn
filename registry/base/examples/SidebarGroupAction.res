@@directive("'use client'")

@module("sonner") external toast: string => unit = "toast"

@react.component
let make = () =>
  <Sidebar.Provider>
    <Sonner />
    <Sidebar>
      <Sidebar.Content>
        <Sidebar.Group>
          <Sidebar.GroupLabel> {"Projects"->React.string} </Sidebar.GroupLabel>
          <Sidebar.GroupAction onClick={_ => toast("You clicked the group action!")}>
            <Icons.Plus />
            <span className="sr-only"> {"Add Project"->React.string} </span>
          </Sidebar.GroupAction>
          <Sidebar.GroupContent>
            <Sidebar.Menu>
              <Sidebar.MenuItem>
                <Sidebar.MenuButton render={<a href="#" />}>
                  <Icons.Frame />
                  <span> {"Design Engineering"->React.string} </span>
                </Sidebar.MenuButton>
              </Sidebar.MenuItem>
              <Sidebar.MenuItem>
                <Sidebar.MenuButton render={<a href="#" />}>
                  <Icons.PieChart />
                  <span> {"Sales & Marketing"->React.string} </span>
                </Sidebar.MenuButton>
              </Sidebar.MenuItem>
              <Sidebar.MenuItem>
                <Sidebar.MenuButton render={<a href="#" />}>
                  <Icons.Map />
                  <span> {"Travel"->React.string} </span>
                </Sidebar.MenuButton>
              </Sidebar.MenuItem>
            </Sidebar.Menu>
          </Sidebar.GroupContent>
        </Sidebar.Group>
      </Sidebar.Content>
    </Sidebar>
  </Sidebar.Provider>
