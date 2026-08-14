@module("react")
external createElement: (string, ReactAria.Common.elementProps) => React.element = "createElement"

let linkProps: ReactAria.Common.elementProps => ReactAria.Common.elementProps = %raw(`props => ({
  ...props,
  href: "#link",
})`)

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Badge render={props => createElement("a", props->linkProps)}>
    {"Open Link "->React.string}
    <Icons.ArrowUpRight dataIcon="inline-end" />
  </Badge>
