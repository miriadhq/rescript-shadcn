@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Slider defaultValue={[75.]} max={100.} step={1.} className="mx-auto w-full max-w-xs" />
