@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <p className="leading-7 [&:not(:first-child)]:mt-6">
    {"The king, seeing how much happier his subjects were, realized the error of his ways and repealed the joke tax."->React.string}
  </p>
