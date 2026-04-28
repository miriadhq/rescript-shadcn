@@directive("'use client'")

type project = {
  name: string,
  url: string,
  icon: React.element,
  badge: string,
}

let projects: array<project> = [
  {name: "Design Engineering", url: "#", icon: <Icons.Frame />, badge: "24"},
  {name: "Sales & Marketing", url: "#", icon: <Icons.PieChart />, badge: "12"},
  {name: "Travel", url: "#", icon: <Icons.Map />, badge: "3"},
  {name: "Support", url: "#", icon: <Icons.LifeBuoy />, badge: "21"},
  {name: "Feedback", url: "#", icon: <Icons.Send />, badge: "8"},
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
