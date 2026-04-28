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
                  <Sidebar.MenuButton render={<a href={project.url} />}>
                    {project.icon}
                    <span> {project.name->React.string} </span>
                  </Sidebar.MenuButton>
                </Sidebar.MenuItem>
              )
              ->React.array}
            </Sidebar.Menu>
          </Sidebar.GroupContent>
        </Sidebar.Group>
      </Sidebar.Content>
    </Sidebar>
  </Sidebar.Provider>
