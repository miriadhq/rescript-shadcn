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

module NavProjectsSkeleton = {
  @react.component
  let make = () =>
    <Sidebar.Menu>
      {[0, 1, 2, 3, 4]
      ->Array.map(i =>
        <Sidebar.MenuItem key={Int.toString(i)}>
          <Sidebar.MenuSkeleton showIcon=true />
        </Sidebar.MenuItem>
      )
      ->React.array}
    </Sidebar.Menu>
}

module NavProjects = {
  @react.component
  let make = () =>
    <Sidebar.Menu>
      {projects
      ->Array.map(project =>
        <Sidebar.MenuItem key={project.name}>
          <Sidebar.MenuButton render={<a href={project.url} />}>
            {renderIcon(~icon=project.icon)}
            <span> {project.name->React.string} </span>
          </Sidebar.MenuButton>
        </Sidebar.MenuItem>
      )
      ->React.array}
    </Sidebar.Menu>
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Sidebar.Provider>
    <Sidebar>
      <Sidebar.Content>
        <Sidebar.Group>
          <Sidebar.GroupLabel> {"Projects"->React.string} </Sidebar.GroupLabel>
          <Sidebar.GroupContent>
            <React.Suspense fallback={<NavProjectsSkeleton />}>
              <NavProjects />
            </React.Suspense>
          </Sidebar.GroupContent>
        </Sidebar.Group>
      </Sidebar.Content>
    </Sidebar>
  </Sidebar.Provider>
