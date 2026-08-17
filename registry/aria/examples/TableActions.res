@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Table>
    <Table.Header>
      <Table.Head> {"Product"->React.string} </Table.Head>
      <Table.Head> {"Price"->React.string} </Table.Head>
      <Table.Head className="text-right"> {"Actions"->React.string} </Table.Head>
    </Table.Header>
    <Table.Body>
      <Table.Row>
        <Table.Cell className="font-medium"> {"Wireless Mouse"->React.string} </Table.Cell>
        <Table.Cell> {"$29.99"->React.string} </Table.Cell>
        <Table.Cell className="text-right">
          <DropdownMenu.Trigger>
            <Button variant=Ghost size=Icon className="size-8">
              <Icons.MoreHorizontal />
              <span className="sr-only"> {"Open menu"->React.string} </span>
            </Button>
            <DropdownMenu placement=ReactAria.Common.Placement.BottomEnd>
              <DropdownMenu.Item> {"Edit"->React.string} </DropdownMenu.Item>
              <DropdownMenu.Item> {"Duplicate"->React.string} </DropdownMenu.Item>
              <DropdownMenu.Separator />
              <DropdownMenu.Item variant=Destructive> {"Delete"->React.string} </DropdownMenu.Item>
            </DropdownMenu>
          </DropdownMenu.Trigger>
        </Table.Cell>
      </Table.Row>
      <Table.Row>
        <Table.Cell className="font-medium"> {"Mechanical Keyboard"->React.string} </Table.Cell>
        <Table.Cell> {"$129.99"->React.string} </Table.Cell>
        <Table.Cell className="text-right">
          <DropdownMenu.Trigger>
            <Button variant=Ghost size=Icon className="size-8">
              <Icons.MoreHorizontal />
              <span className="sr-only"> {"Open menu"->React.string} </span>
            </Button>
            <DropdownMenu placement=ReactAria.Common.Placement.BottomEnd>
              <DropdownMenu.Item> {"Edit"->React.string} </DropdownMenu.Item>
              <DropdownMenu.Item> {"Duplicate"->React.string} </DropdownMenu.Item>
              <DropdownMenu.Separator />
              <DropdownMenu.Item variant=Destructive> {"Delete"->React.string} </DropdownMenu.Item>
            </DropdownMenu>
          </DropdownMenu.Trigger>
        </Table.Cell>
      </Table.Row>
      <Table.Row>
        <Table.Cell className="font-medium"> {"USB-C Hub"->React.string} </Table.Cell>
        <Table.Cell> {"$49.99"->React.string} </Table.Cell>
        <Table.Cell className="text-right">
          <DropdownMenu.Trigger>
            <Button variant=Ghost size=Icon className="size-8">
              <Icons.MoreHorizontal />
              <span className="sr-only"> {"Open menu"->React.string} </span>
            </Button>
            <DropdownMenu placement=ReactAria.Common.Placement.BottomEnd>
              <DropdownMenu.Item> {"Edit"->React.string} </DropdownMenu.Item>
              <DropdownMenu.Item> {"Duplicate"->React.string} </DropdownMenu.Item>
              <DropdownMenu.Separator />
              <DropdownMenu.Item variant=Destructive> {"Delete"->React.string} </DropdownMenu.Item>
            </DropdownMenu>
          </DropdownMenu.Trigger>
        </Table.Cell>
      </Table.Row>
    </Table.Body>
  </Table>
