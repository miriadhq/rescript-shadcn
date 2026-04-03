@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (open_, setOpen) = React.useState(() => false)

  <div className="flex flex-col gap-4">
    <Button onClick={_ => setOpen(_ => true)} variant=Outline className="w-fit">
      {"Open Menu"->React.string}
    </Button>
    <Command.Dialog open_={open_} onOpenChange={(v, _) => setOpen(_ => v)}>
      <Command>
        <Command.Input placeholder="Type a command or search..." />
        <Command.List>
          <Command.Empty> {"No results found."->React.string} </Command.Empty>
          <Command.Group heading="Suggestions">
            <Command.Item> {"Calendar"->React.string} </Command.Item>
            <Command.Item> {"Search Emoji"->React.string} </Command.Item>
            <Command.Item> {"Calculator"->React.string} </Command.Item>
          </Command.Group>
        </Command.List>
      </Command>
    </Command.Dialog>
  </div>
}
