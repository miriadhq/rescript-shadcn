@@directive("'use client'")

let snapPoints = [Drawer.SnapPoint.Pixels("31rem"), Drawer.SnapPoint.Ratio(1.)]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Drawer snapPoints showSwipeHandle={true}>
    <Drawer.Trigger render={<Button variant=Outline />}>
      {"Open Snap Drawer"->React.string}
    </Drawer.Trigger>
    <Drawer.Content>
      <Drawer.Header>
        <Drawer.Title> {"Snap points"->React.string} </Drawer.Title>
        <Drawer.Description>
          {"Drag the drawer to snap between a compact peek and a near full-height view."->React.string}
        </Drawer.Description>
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
