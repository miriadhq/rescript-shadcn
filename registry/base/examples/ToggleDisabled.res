@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex flex-wrap items-center gap-2">
    <Toggle ariaLabel="Toggle disabled" disabled={true}> {"Disabled"->React.string} </Toggle>
    <Toggle variant=Toggle.Variant.Outline ariaLabel="Toggle disabled outline" disabled={true}>
      {"Disabled"->React.string}
    </Toggle>
  </div>
