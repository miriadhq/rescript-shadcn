@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Button variant=Button.Variant.Destructive> {"Destructive"->React.string} </Button>
