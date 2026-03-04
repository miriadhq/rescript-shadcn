@react.component
let make = () =>
  <Toggle ariaLabel="Toggle italic">
    <Icons.Italic />
    {"Italic"->React.string}
  </Toggle>
