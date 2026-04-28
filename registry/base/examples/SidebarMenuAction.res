@@directive("'use client'")

type project = {
  name: string,
  url: string,
  icon: React.element,
}

let projects: array<project> = [
  {name: "Design Engineering", url: "#", icon: <Icons.Frame />},
  {name: "Sales & Marketing", url: "#", icon: <Icons.PieChart />},
  {name: "Travel", url: "#", icon: <Icons.Map />},
  {name: "Support", url: "#", icon: <Icons.LifeBuoy />},
  {name: "Feedback", url: "#", icon: <Icons.Send />},
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Sidebar.Provider>
    <Sidebar>
      <Sidebar.Content>
        <Sidebar.Group>
          <Sidebar.GroupLabel> {"Projects"->React.string} </Sidebar.GroupLabel>
          <Sidebar.GroupContent>
            <Sidebar.Menu>
              {projects
              ->Array.map(project =>
                <Sidebar.MenuItem key={project.name}>
                  <Sidebar.MenuButton
                    render={<a href={project.url} />}
                    className="group-has-data-[state=open]/menu-item:bg-sidebar-accent"
                  >
                    {project.icon}
                    <span> {project.name->React.string} </span>
                  </Sidebar.MenuButton>
                  <DropdownMenu>
                    <DropdownMenu.Trigger render={<Sidebar.MenuAction />}>
                      <Icons.MoreHorizontal />
                      <span className="sr-only"> {"More"->React.string} </span>
                    </DropdownMenu.Trigger>
                    <DropdownMenu.Content side=BaseUi.Types.Side.Right align=Start>
                      <DropdownMenu.Item>
                        <span> {"Edit Project"->React.string} </span>
                      </DropdownMenu.Item>
                      <DropdownMenu.Item>
                        <span> {"Delete Project"->React.string} </span>
                      </DropdownMenu.Item>
                    </DropdownMenu.Content>
                  </DropdownMenu>
                </Sidebar.MenuItem>
              )
              ->React.array}
            </Sidebar.Menu>
          </Sidebar.GroupContent>
        </Sidebar.Group>
      </Sidebar.Content>
    </Sidebar>
  </Sidebar.Provider>
