@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  <DropdownMenu>
    <DropdownMenu.Trigger render={<Button variant=Ghost size=Icon className="rounded-full" />}>
      <Avatar>
        <Avatar.Image src="https://github.com/shadcn.png" alt="shadcn" />
        <Avatar.Fallback> {"CN"->React.string} </Avatar.Fallback>
      </Avatar>
    </DropdownMenu.Trigger>
    <DropdownMenu.Content className="w-32">
      <DropdownMenu.Group>
        <DropdownMenu.Item> {"Profile"->React.string} </DropdownMenu.Item>
        <DropdownMenu.Item> {"Billing"->React.string} </DropdownMenu.Item>
        <DropdownMenu.Item> {"Settings"->React.string} </DropdownMenu.Item>
      </DropdownMenu.Group>
      <DropdownMenu.Separator />
      <DropdownMenu.Group>
        <DropdownMenu.Item variant=Destructive> {"Log out"->React.string} </DropdownMenu.Item>
      </DropdownMenu.Group>
    </DropdownMenu.Content>
  </DropdownMenu>
}
