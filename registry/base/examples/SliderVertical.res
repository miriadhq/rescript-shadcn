open BaseUi.Types

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="mx-auto flex w-full max-w-xs items-center justify-center gap-6">
    <Slider
      defaultValue={[50.]} max={100.} step={1.} orientation=Orientation.Vertical className="h-40"
    />
    <Slider
      defaultValue={[25.]} max={100.} step={1.} orientation=Orientation.Vertical className="h-40"
    />
  </div>
