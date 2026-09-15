@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Drawer direction=Left>
    <Drawer.Trigger asChild=true>
      <Button variant=Secondary> {"Open Left Drawer"->React.string} </Button>
    </Drawer.Trigger>
    <Drawer.Content>
      <Drawer.Header>
        <Drawer.Title> {"Move Goal"->React.string} </Drawer.Title>
        <Drawer.Description> {"Set your daily activity goal."->React.string} </Drawer.Description>
      </Drawer.Header>
      <div className="flex-1 p-4">
        <div className="size-full rounded-2xl bg-muted" />
      </div>
      <Drawer.Footer>
        <Drawer.Close asChild=true>
          <Button> {"Close"->React.string} </Button>
        </Drawer.Close>
      </Drawer.Footer>
    </Drawer.Content>
  </Drawer>
