@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <p className="shimmer text-sm text-muted-foreground">
    {"Generating response…"->React.string}
  </p>
