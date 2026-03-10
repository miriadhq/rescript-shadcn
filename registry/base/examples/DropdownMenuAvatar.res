@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <DropdownMenu>
    <DropdownMenu.Trigger
      render={<Button
        variant=Button.Variant.Ghost
        size=Button.Size.Icon
        className="rounded-full"
        dataSlot="dropdown-menu-trigger"
      />}
    >
      <Avatar>
        <Avatar.Image src="https://github.com/shadcn.png" alt="shadcn" />
        <Avatar.Fallback> {"LR"->React.string} </Avatar.Fallback>
      </Avatar>
    </DropdownMenu.Trigger>
    <DropdownMenu.Content align=BaseUi.Types.Align.End>
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
    </DropdownMenu.Content>
  </DropdownMenu>
