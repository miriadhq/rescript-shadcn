@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <DropdownMenu.Trigger>
    <Button variant=Outline> {"Open"->React.string} </Button>
    <DropdownMenu>
      <DropdownMenu.Group>
        <DropdownMenu.Label> {"My Account"->React.string} </DropdownMenu.Label>
        <DropdownMenu.Item> {"Profile"->React.string} </DropdownMenu.Item>
        <DropdownMenu.Item> {"Billing"->React.string} </DropdownMenu.Item>
        <DropdownMenu.Item> {"Settings"->React.string} </DropdownMenu.Item>
      </DropdownMenu.Group>
      <DropdownMenu.Separator />
      <DropdownMenu.Item> {"GitHub"->React.string} </DropdownMenu.Item>
      <DropdownMenu.Item> {"Support"->React.string} </DropdownMenu.Item>
      <DropdownMenu.Item isDisabled={true}> {"API"->React.string} </DropdownMenu.Item>
    </DropdownMenu>
  </DropdownMenu.Trigger>
