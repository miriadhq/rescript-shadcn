@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (open_, setOpen) = React.useState(() => false)

  <div className="flex flex-col gap-4">
    <Button onClick={_ => setOpen(_ => true)} variant=Button.Variant.Outline className="w-fit">
      {"Open Menu"->React.string}
    </Button>
    <Command.Dialog open_={open_} onOpenChange={(v, _) => setOpen(_ => v)}>
      <Command>
        <Command.Input placeholder="Type a command or search..." />
        <Command.List>
          <Command.Empty> {"No results found."->React.string} </Command.Empty>
          <Command.Group heading="Suggestions">
            <Command.Item>
              <Icons.Calendar />
              <span> {"Calendar"->React.string} </span>
            </Command.Item>
            <Command.Item>
              <Icons.Smile />
              <span> {"Search Emoji"->React.string} </span>
            </Command.Item>
            <Command.Item>
              <Icons.Calculator />
              <span> {"Calculator"->React.string} </span>
            </Command.Item>
          </Command.Group>
          <Command.Separator />
          <Command.Group heading="Settings">
            <Command.Item>
              <Icons.User />
              <span> {"Profile"->React.string} </span>
              <Command.Shortcut> {"⌘P"->React.string} </Command.Shortcut>
            </Command.Item>
            <Command.Item>
              <Icons.CreditCard />
              <span> {"Billing"->React.string} </span>
              <Command.Shortcut> {"⌘B"->React.string} </Command.Shortcut>
            </Command.Item>
            <Command.Item>
              <Icons.Settings />
              <span> {"Settings"->React.string} </span>
              <Command.Shortcut> {"⌘S"->React.string} </Command.Shortcut>
            </Command.Item>
          </Command.Group>
        </Command.List>
      </Command>
    </Command.Dialog>
  </div>
}
