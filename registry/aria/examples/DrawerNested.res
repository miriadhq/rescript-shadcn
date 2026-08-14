@@directive("'use client'")

module Placeholder = {
  @react.component
  let make = () =>
    <div className="flex-1 p-4">
      <div className="bg-muted group-data-[swipe-axis=x]/drawer-popup:size-full group-data-[swipe-axis=y]/drawer-popup:aspect-video group-data-[swipe-axis=y]/drawer-popup:w-full" />
    </div>
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let isMobile = Sidebar.useIsMobile()
  let swipeDirection = isMobile ? Drawer.SwipeDirection.Down : Drawer.SwipeDirection.Right

  <Drawer showSwipeHandle=isMobile swipeDirection>
    <Drawer.Trigger render={<Button variant=Secondary />}>
      {"Open Drawer"->React.string}
    </Drawer.Trigger>
    <Drawer.Content>
      <Drawer.Header>
        <Drawer.Title> {"Drawer"->React.string} </Drawer.Title>
        <Drawer.Description>
          {"Open another drawer from the same direction."->React.string}
        </Drawer.Description>
      </Drawer.Header>
      <Placeholder />
      <Drawer.Footer>
        <Drawer showSwipeHandle=isMobile swipeDirection>
          <Drawer.Trigger render={<Button variant=Outline />}>
            {"Open Nested Drawer"->React.string}
          </Drawer.Trigger>
          <Drawer.Content>
            <Drawer.Header>
              <Drawer.Title> {"Nested Drawer"->React.string} </Drawer.Title>
              <Drawer.Description>
                {"The parent drawer stays mounted behind this one."->React.string}
              </Drawer.Description>
            </Drawer.Header>
            <Placeholder />
            <Drawer.Footer>
              <Drawer showSwipeHandle=isMobile swipeDirection>
                <Drawer.Trigger render={<Button variant=Outline />}>
                  {"Open Third Drawer"->React.string}
                </Drawer.Trigger>
                <Drawer.Content>
                  <Drawer.Header>
                    <Drawer.Title> {"Third Drawer"->React.string} </Drawer.Title>
                    <Drawer.Description>
                      {"Two drawers are stacked behind this one."->React.string}
                    </Drawer.Description>
                  </Drawer.Header>
                  <Placeholder />
                  <Drawer.Footer>
                    <Drawer showSwipeHandle=isMobile swipeDirection>
                      <Drawer.Trigger render={<Button variant=Outline />}>
                        {"Open Fourth Drawer"->React.string}
                      </Drawer.Trigger>
                      <Drawer.Content>
                        <Drawer.Header>
                          <Drawer.Title> {"Fourth Drawer"->React.string} </Drawer.Title>
                          <Drawer.Description>
                            {"This is the frontmost drawer in the stack."->React.string}
                          </Drawer.Description>
                        </Drawer.Header>
                        <Placeholder />
                        <Drawer.Footer>
                          <Drawer.Close render={<Button variant=Outline />}>
                            {"Close"->React.string}
                          </Drawer.Close>
                        </Drawer.Footer>
                      </Drawer.Content>
                    </Drawer>
                    <Drawer.Close render={<Button variant=Outline />}>
                      {"Close"->React.string}
                    </Drawer.Close>
                  </Drawer.Footer>
                </Drawer.Content>
              </Drawer>
              <Drawer.Close render={<Button variant=Outline />}>
                {"Close"->React.string}
              </Drawer.Close>
            </Drawer.Footer>
          </Drawer.Content>
        </Drawer>
        <Drawer.Close render={<Button variant=Outline />}> {"Close"->React.string} </Drawer.Close>
      </Drawer.Footer>
    </Drawer.Content>
  </Drawer>
}
