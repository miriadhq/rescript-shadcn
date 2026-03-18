@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <small className="text-sm leading-none font-medium"> {"Email address"->React.string} </small>
