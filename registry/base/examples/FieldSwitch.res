@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field orientation=Horizontal className="w-fit">
    <Field.Label htmlFor="2fa"> {"Multi-factor authentication"->React.string} </Field.Label>
    <Switch id="2fa" />
  </Field>
