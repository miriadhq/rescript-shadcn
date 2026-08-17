@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  <div className="flex gap-6">
    <Popover.Trigger>
      <Button variant=Outline size=Sm> {"Start"->React.string} </Button>
      <Popover placement=ReactAria.Common.Placement.BottomStart className="w-40">
        {"Aligned to start"->React.string}
      </Popover>
    </Popover.Trigger>
    <Popover.Trigger>
      <Button variant=Outline size=Sm> {"Center"->React.string} </Button>
      <Popover placement=ReactAria.Common.Placement.Bottom className="w-40">
        {"Aligned to center"->React.string}
      </Popover>
    </Popover.Trigger>
    <Popover.Trigger>
      <Button variant=Outline size=Sm> {"End"->React.string} </Button>
      <Popover placement=ReactAria.Common.Placement.BottomEnd className="w-40">
        {"Aligned to end"->React.string}
      </Popover>
    </Popover.Trigger>
  </div>
}
