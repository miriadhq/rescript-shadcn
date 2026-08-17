@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Drawer
    modal=BaseUi.Types.Modal.False
    disablePointerDismissal={true}
    swipeDirection=Drawer.SwipeDirection.Right
  >
    <Drawer.Trigger render={<Button variant=Outline />}>
      {"Non Modal"->React.string}
    </Drawer.Trigger>
    <Drawer.Content>
      <Drawer.Header>
        <Drawer.Title> {"Non Modal Drawer"->React.string} </Drawer.Title>
      </Drawer.Header>
      <div className="flex-1 p-4">
        <div
          className="rounded-2xl bg-muted group-data-[swipe-axis=x]/drawer-popup:size-full group-data-[swipe-axis=y]/drawer-popup:h-80 group-data-[swipe-axis=y]/drawer-popup:w-full"
        />
      </div>
      <Drawer.Footer>
        <Drawer.Close render={<Button />}> {"Close"->React.string} </Drawer.Close>
      </Drawer.Footer>
    </Drawer.Content>
  </Drawer>
