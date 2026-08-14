@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <DropdownMenu.Trigger>
<Button variant=Outline>
      {"Open"->React.string}
    </Button>
<DropdownMenu>
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
    </DropdownMenu>
</DropdownMenu.Trigger>
