@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Drawer showSwipeHandle={true}>
    <Drawer.Trigger render={<Button variant=Secondary />}>
      {"Open Drawer"->React.string}
    </Drawer.Trigger>
    <Drawer.Content>
      <Drawer.Header>
        <Drawer.Title> {"Drawer"->React.string} </Drawer.Title>
        <Drawer.Description> {"Drawer with a swipe handle."->React.string} </Drawer.Description>
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
