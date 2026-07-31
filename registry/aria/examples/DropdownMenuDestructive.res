@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <DropdownMenu>
    <DropdownMenu.Trigger render={<Button variant=Outline />}>
      {"Actions"->React.string}
    </DropdownMenu.Trigger>
    <DropdownMenu.Content>
      <DropdownMenu.Group>
        <DropdownMenu.Item>
          <Icons.Pencil />
          {"Edit"->React.string}
        </DropdownMenu.Item>
        <DropdownMenu.Item>
          <Icons.Share />
          {"Share"->React.string}
        </DropdownMenu.Item>
      </DropdownMenu.Group>
      <DropdownMenu.Separator />
      <DropdownMenu.Group>
        <DropdownMenu.Item variant=Destructive>
          <Icons.Trash />
          {"Delete"->React.string}
        </DropdownMenu.Item>
      </DropdownMenu.Group>
    </DropdownMenu.Content>
  </DropdownMenu>
