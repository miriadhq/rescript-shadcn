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
                    {renderIcon(~icon=project.icon)}
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
