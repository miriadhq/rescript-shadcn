@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Toggle ariaLabel="Toggle italic">
    <Icons.Italic />
    {"Italic"->React.string}
  </Toggle>
