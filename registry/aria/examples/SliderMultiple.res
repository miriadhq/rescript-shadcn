@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Slider
    defaultValue={[10., 20., 70.]} maxValue={100.} step={10.} className="mx-auto w-full max-w-xs"
  />
