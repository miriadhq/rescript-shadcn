@module("react")
external createElement: (string, ReactAria.Types.DomProps.t) => React.element = "createElement"

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Badge render={props => createElement("a", {...props, href: "#link"})}>
    {"Open Link "->React.string}
    <Icons.ArrowUpRight dataIcon="inline-end" />
  </Badge>
