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
  badge: string,
}

let projects: array<project> = [
  {name: "Design Engineering", url: "#", icon: IconFrame, badge: "24"},
  {name: "Sales & Marketing", url: "#", icon: IconPieChart, badge: "12"},
  {name: "Travel", url: "#", icon: IconMap, badge: "3"},
  {name: "Support", url: "#", icon: IconLifeBuoy, badge: "21"},
  {name: "Feedback", url: "#", icon: IconSend, badge: "8"},
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
                  <Sidebar.MenuBadge> {project.badge->React.string} </Sidebar.MenuBadge>
                </Sidebar.MenuItem>
              )
              ->React.array}
            </Sidebar.Menu>
          </Sidebar.GroupContent>
        </Sidebar.Group>
      </Sidebar.Content>
    </Sidebar>
  </Sidebar.Provider>
