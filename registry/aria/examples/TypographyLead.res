@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <p className="text-muted-foreground text-xl">
    {"A modal dialog that interrupts the user with important content and expects a response."->React.string}
  </p>
