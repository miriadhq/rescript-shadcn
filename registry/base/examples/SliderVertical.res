open BaseUi.Types

@react.component
let make = () =>
  <div className="mx-auto flex w-full max-w-xs items-center justify-center gap-6">
    <Slider
      defaultValue={[50.]} max={100.} step={1.} orientation=Orientation.Vertical className="h-40"
    >
      {React.null}
    </Slider>
    <Slider
      defaultValue={[25.]} max={100.} step={1.} orientation=Orientation.Vertical className="h-40"
    >
      {React.null}
    </Slider>
  </div>
