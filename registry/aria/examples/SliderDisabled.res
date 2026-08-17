@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Slider
    defaultValue={[50.]}
    maxValue={100.}
    step={1.}
    isDisabled={true}
    className="mx-auto w-full max-w-xs"
  />
