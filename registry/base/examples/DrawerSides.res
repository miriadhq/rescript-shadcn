@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Drawer swipeDirection=Left>
    <Drawer.Trigger render={<Button variant=Secondary />}>
      {"Open Left Drawer"->React.string}
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
        <Drawer.Close render={<Button />}> {"Close"->React.string} </Drawer.Close>
      </Drawer.Footer>
    </Drawer.Content>
  </Drawer>
