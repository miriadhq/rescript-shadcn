@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <a href="#" className={Button.buttonVariants(~variant=Secondary, ~size=Sm)}>
    {"Login"->React.string}
  </a>
