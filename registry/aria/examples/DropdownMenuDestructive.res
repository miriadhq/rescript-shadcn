@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <DropdownMenu.Trigger>
    <Button variant=Outline> {"Actions"->React.string} </Button>
    <DropdownMenu>
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
    </DropdownMenu>
  </DropdownMenu.Trigger>
