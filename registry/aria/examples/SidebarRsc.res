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

// The preview loader is client-side. Keep the request above the Suspense boundary
// so retries reuse it, while matching the upstream server example's loading state.
let fetchProjects = () =>
  Promise.make((resolve, _) => {
    let _ = setTimeout(~handler=() => resolve(projects), ~timeout=3000)
  })

module NavProjectsSkeleton = {
  @react.component
  let make = () =>
    <Sidebar.Menu>
      {Array.fromInitializer(~length=5, i =>
        <Sidebar.MenuItem key={Int.toString(i)}>
          <Sidebar.MenuSkeleton showIcon=true />
        </Sidebar.MenuItem>
      )->React.array}
    </Sidebar.Menu>
}

module NavProjects = {
  @react.component
  let make = (~projects: promise<array<project>>) => {
    let projects = React.usePromise(projects)
    <Sidebar.Menu>
      {projects
      ->Array.map(project =>
        <Sidebar.MenuItem key={project.name}>
          <Sidebar.MenuButton href={project.url}>
            {project.icon}
            <span> {project.name->React.string} </span>
          </Sidebar.MenuButton>
        </Sidebar.MenuItem>
      )
      ->React.array}
    </Sidebar.Menu>
  }
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (projects, _) = React.useState(fetchProjects)
  <Sidebar.Provider>
    <Sidebar>
      <Sidebar.Content>
        <Sidebar.Group>
          <Sidebar.GroupLabel> {"Projects"->React.string} </Sidebar.GroupLabel>
          <Sidebar.GroupContent>
            <React.Suspense fallback={<NavProjectsSkeleton />}>
              <NavProjects projects />
            </React.Suspense>
          </Sidebar.GroupContent>
        </Sidebar.Group>
      </Sidebar.Content>
    </Sidebar>
  </Sidebar.Provider>
}
