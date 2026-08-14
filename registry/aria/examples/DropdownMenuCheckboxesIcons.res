@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (selectedKeys, setSelectedKeys) = React.useState(() => ["email", "push"])
  <DropdownMenu.Trigger>
    <Button variant=Outline className="w-fit"> {"Notifications"->React.string} </Button>
    <DropdownMenu className="min-w-56">
      <DropdownMenu.Group
        selectionMode=Multiple
        selectedKeys
        onSelectionChange={selection =>
          switch selection {
          | ReactAria.Common.Keys(keys) => setSelectedKeys(_ => keys->Set.values->Iterator.toArray)
          | ReactAria.Common.All => ()
          }
        }
      >
        <DropdownMenu.Label> {"Notification Preferences"->React.string} </DropdownMenu.Label>
        <DropdownMenu.Item id="email">
          <Icons.Mail />
          {"Email notifications"->React.string}
        </DropdownMenu.Item>
        <DropdownMenu.Item id="sms">
          <Icons.MessageSquare />
          {"SMS notifications"->React.string}
        </DropdownMenu.Item>
        <DropdownMenu.Item id="push">
          <Icons.Bell />
          {"Push notifications"->React.string}
        </DropdownMenu.Item>
      </DropdownMenu.Group>
    </DropdownMenu>
  </DropdownMenu.Trigger>
}
