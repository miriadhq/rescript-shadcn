@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex flex-wrap items-center gap-2">
    <Toggle ariaLabel="Toggle disabled" isDisabled={true}> {"Disabled"->React.string} </Toggle>
    <Toggle variant=Outline ariaLabel="Toggle disabled outline" isDisabled={true}>
      {"Disabled"->React.string}
    </Toggle>
  </div>
