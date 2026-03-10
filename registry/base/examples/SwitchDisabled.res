@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field orientation=BaseUi.Types.Orientation.Horizontal dataDisabled={true} className="w-fit">
    <Switch id="switch-disabled-unchecked" disabled={true} />
    <Field.Label htmlFor="switch-disabled-unchecked"> {"Disabled"->React.string} </Field.Label>
  </Field>
