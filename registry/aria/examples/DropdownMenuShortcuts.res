@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <DropdownMenu.Trigger>
<Button variant=Outline>
      {"Open"->React.string}
    </Button>
<DropdownMenu>
      <DropdownMenu.Group>
        <DropdownMenu.Label> {"My Account"->React.string} </DropdownMenu.Label>
        <DropdownMenu.Item>
          {"Profile"->React.string}
          <DropdownMenu.Shortcut> {"⇧⌘P"->React.string} </DropdownMenu.Shortcut>
        </DropdownMenu.Item>
        <DropdownMenu.Item>
          {"Billing"->React.string}
          <DropdownMenu.Shortcut> {"⌘B"->React.string} </DropdownMenu.Shortcut>
        </DropdownMenu.Item>
        <DropdownMenu.Item>
          {"Settings"->React.string}
          <DropdownMenu.Shortcut> {"⌘S"->React.string} </DropdownMenu.Shortcut>
        </DropdownMenu.Item>
      </DropdownMenu.Group>
      <DropdownMenu.Separator />
      <DropdownMenu.Item>
        {"Log out"->React.string}
        <DropdownMenu.Shortcut> {"⇧⌘Q"->React.string} </DropdownMenu.Shortcut>
      </DropdownMenu.Item>
    </DropdownMenu>
</DropdownMenu.Trigger>
