@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Badge render={<a href="#link" />}>
    {"Open Link "->React.string}
    <Icons.ArrowUpRight dataIcon="inline-end" />
  </Badge>
