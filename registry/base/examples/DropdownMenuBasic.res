@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <DropdownMenu>
    <DropdownMenu.Trigger
      render={<Button variant=Button.Variant.Outline dataSlot="dropdown-menu-trigger" />}
    >
      {"Open"->React.string}
    </DropdownMenu.Trigger>
    <DropdownMenu.Content>
      <DropdownMenu.Group>
        <DropdownMenu.Label> {"My Account"->React.string} </DropdownMenu.Label>
        <DropdownMenu.Item> {"Profile"->React.string} </DropdownMenu.Item>
        <DropdownMenu.Item> {"Billing"->React.string} </DropdownMenu.Item>
        <DropdownMenu.Item> {"Settings"->React.string} </DropdownMenu.Item>
      </DropdownMenu.Group>
      <DropdownMenu.Separator />
      <DropdownMenu.Item> {"GitHub"->React.string} </DropdownMenu.Item>
      <DropdownMenu.Item> {"Support"->React.string} </DropdownMenu.Item>
      <DropdownMenu.Item disabled={true}> {"API"->React.string} </DropdownMenu.Item>
    </DropdownMenu.Content>
  </DropdownMenu>
