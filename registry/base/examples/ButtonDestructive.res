@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Button variant=Destructive> {"Destructive"->React.string} </Button>
