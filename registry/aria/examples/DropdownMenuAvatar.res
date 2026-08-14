@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <DropdownMenu.Trigger>
<Button variant=Ghost size=Icon className="rounded-full">
      <Avatar>
        <Avatar.Image src="https://github.com/shadcn.png" alt="shadcn" />
        <Avatar.Fallback> {"LR"->React.string} </Avatar.Fallback>
      </Avatar>
    </Button>
<DropdownMenu placement=ReactAria.Common.BottomEnd>
      <DropdownMenu.Group>
        <DropdownMenu.Item>
          <Icons.BadgeCheck />
          {"Account"->React.string}
        </DropdownMenu.Item>
        <DropdownMenu.Item>
          <Icons.CreditCard />
          {"Billing"->React.string}
        </DropdownMenu.Item>
        <DropdownMenu.Item>
          <Icons.Bell />
          {"Notifications"->React.string}
        </DropdownMenu.Item>
      </DropdownMenu.Group>
      <DropdownMenu.Separator />
      <DropdownMenu.Item>
        <Icons.LogOut />
        {"Sign Out"->React.string}
      </DropdownMenu.Item>
    </DropdownMenu>
</DropdownMenu.Trigger>
