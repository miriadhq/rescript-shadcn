@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Slider defaultValue={[25., 50.]} max={100.} step={5.} className="mx-auto w-full max-w-xs" />
