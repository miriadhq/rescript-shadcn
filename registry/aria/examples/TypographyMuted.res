@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <p className="text-muted-foreground text-sm"> {"Enter your email address."->React.string} </p>
