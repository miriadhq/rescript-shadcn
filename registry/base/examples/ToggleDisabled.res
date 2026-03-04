@react.component
let make = () =>
  <div className="flex flex-wrap items-center gap-2">
    <Toggle ariaLabel="Toggle disabled" disabled={true}> {"Disabled"->React.string} </Toggle>
    <Toggle variant=Toggle.Variant.Outline ariaLabel="Toggle disabled outline" disabled={true}>
      {"Disabled"->React.string}
    </Toggle>
  </div>
