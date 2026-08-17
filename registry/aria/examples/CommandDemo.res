@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Command className="max-w-sm rounded-lg border">
    <Command.Input placeholder="Type a command or search..." />
    <Command.List
      renderEmptyState={() => <Command.Empty> {"No results found."->React.string} </Command.Empty>}
    >
      <Command.Group heading="Suggestions">
        <Command.Item textValue="Calendar">
          <Icons.Calendar />
          <span> {"Calendar"->React.string} </span>
        </Command.Item>
        <Command.Item textValue="Search Emoji">
          <Icons.Smile />
          <span> {"Search Emoji"->React.string} </span>
        </Command.Item>
        <Command.Item textValue="Calculator" isDisabled={true}>
          <Icons.Calculator />
          <span> {"Calculator"->React.string} </span>
        </Command.Item>
      </Command.Group>
      <Command.Separator />
      <Command.Group heading="Settings">
        <Command.Item textValue="Profile">
          <Icons.User />
          <span> {"Profile"->React.string} </span>
          <Command.Shortcut> {"⌘P"->React.string} </Command.Shortcut>
        </Command.Item>
        <Command.Item textValue="Billing">
          <Icons.CreditCard />
          <span> {"Billing"->React.string} </span>
          <Command.Shortcut> {"⌘B"->React.string} </Command.Shortcut>
        </Command.Item>
        <Command.Item textValue="Settings">
          <Icons.Settings />
          <span> {"Settings"->React.string} </span>
          <Command.Shortcut> {"⌘S"->React.string} </Command.Shortcut>
        </Command.Item>
      </Command.Group>
    </Command.List>
  </Command>
