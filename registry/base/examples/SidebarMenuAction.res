@@directive("'use client'")

type icon =
  | IconFrame
  | IconLifeBuoy
  | IconMap
  | IconPieChart
  | IconSend

let renderIcon = (~icon) =>
  switch icon {
  | IconFrame => <Icons.Frame />
  | IconLifeBuoy => <Icons.LifeBuoy />
  | IconMap => <Icons.Map />
  | IconPieChart => <Icons.PieChart />
  | IconSend => <Icons.Send />
  }

type project = {
  name: string,
  url: string,
  icon: icon,
}

let projects: array<project> = [
  {name: "Design Engineering", url: "#", icon: IconFrame},
  {name: "Sales & Marketing", url: "#", icon: IconPieChart},
  {name: "Travel", url: "#", icon: IconMap},
  {name: "Support", url: "#", icon: IconLifeBuoy},
  {name: "Feedback", url: "#", icon: IconSend},
]

@react.component
let make = () =>
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
                    className="group-has-[[data-state=open]]/menu-item:bg-sidebar-accent"
                  >
                    {renderIcon(~icon=project.icon)}
                    <span> {project.name->React.string} </span>
                  </Sidebar.MenuButton>
                  <DropdownMenu>
                    <DropdownMenu.Trigger render={<Sidebar.MenuAction />}>
                      <Icons.MoreHorizontal />
                      <span className="sr-only"> {"More"->React.string} </span>
                    </DropdownMenu.Trigger>
                    <DropdownMenu.Content
                      side=BaseUi.Types.Side.Right align=BaseUi.Types.Align.Start
                    >
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
