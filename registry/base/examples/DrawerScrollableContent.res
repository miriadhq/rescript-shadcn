@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Drawer direction=Right>
    <Drawer.Trigger asChild=true>
      <Button variant=Outline dataSlot="drawer-trigger">
        {"Scrollable Content"->React.string}
      </Button>
    </Drawer.Trigger>
    <Drawer.Content>
      <Drawer.Header>
        <Drawer.Title> {"Move Goal"->React.string} </Drawer.Title>
        <Drawer.Description> {"Set your daily activity goal."->React.string} </Drawer.Description>
      </Drawer.Header>
      <div className="no-scrollbar overflow-y-auto px-4">
        {Array.fromInitializer(~length=10, i =>
          <p key={Int.toString(i)} className="mb-4 leading-normal">
            {"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."->React.string}
          </p>
        )->React.array}
      </div>
      <Drawer.Footer>
        <Button> {"Submit"->React.string} </Button>
        <Drawer.Close asChild=true>
          <Button variant=Outline> {"Cancel"->React.string} </Button>
        </Drawer.Close>
      </Drawer.Footer>
    </Drawer.Content>
  </Drawer>
