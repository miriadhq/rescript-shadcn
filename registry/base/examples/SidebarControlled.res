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
let make = ({}: Demo.Props.t) => {
  let (open_, setOpen) = React.useState(() => true)

  <Sidebar.Provider open_={open_} onOpenChange={v => setOpen(_ => v)}>
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
    <Sidebar.Inset>
      <header className="flex h-12 items-center justify-between px-4">
        <Button onClick={_ => setOpen(prev => !prev)} size=Sm variant=Ghost>
          {open_ ? <Icons.PanelLeftClose /> : <Icons.PanelLeftOpen />}
          <span>
            {if open_ {
              "Close"
            } else {
              "Open"
            }->React.string}
            {" Sidebar"->React.string}
          </span>
        </Button>
      </header>
    </Sidebar.Inset>
  </Sidebar.Provider>
}
