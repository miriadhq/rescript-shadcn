@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <DropdownMenu>
    <DropdownMenu.Trigger render={<Button variant=Outline dataSlot="dropdown-menu-trigger" />}>
      {"Open"->React.string}
    </DropdownMenu.Trigger>
    <DropdownMenu.Content>
      <DropdownMenu.Item>
        <Icons.User />
        {"Profile"->React.string}
      </DropdownMenu.Item>
      <DropdownMenu.Item>
        <Icons.CreditCard />
        {"Billing"->React.string}
      </DropdownMenu.Item>
      <DropdownMenu.Item>
        <Icons.Settings />
        {"Settings"->React.string}
      </DropdownMenu.Item>
      <DropdownMenu.Separator />
      <DropdownMenu.Item variant=Destructive>
        <Icons.LogOut />
        {"Log out"->React.string}
      </DropdownMenu.Item>
    </DropdownMenu.Content>
  </DropdownMenu>
