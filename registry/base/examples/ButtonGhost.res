@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Button variant=Button.Variant.Ghost> {"Ghost"->React.string} </Button>
