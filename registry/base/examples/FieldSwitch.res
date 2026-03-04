@react.component
let make = () =>
  <Field orientation=BaseUi.Types.Orientation.Horizontal className="w-fit">
    <Field.Label htmlFor="2fa"> {"Multi-factor authentication"->React.string} </Field.Label>
    <Switch id="2fa" />
  </Field>
