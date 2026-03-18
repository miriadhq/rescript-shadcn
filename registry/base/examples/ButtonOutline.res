@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Button variant=Button.Variant.Outline> {"Outline"->React.string} </Button>
