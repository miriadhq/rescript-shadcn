@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Slider
    defaultValue={[50.]} max={100.} step={1.} disabled={true} className="mx-auto w-full max-w-xs"
  />
