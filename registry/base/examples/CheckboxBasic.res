@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field.Group className="mx-auto w-56">
    <Field orientation=Horizontal>
      <Checkbox id="terms-checkbox-basic" name="terms-checkbox-basic" />
      <Field.Label htmlFor="terms-checkbox-basic">
        {"Accept terms and conditions"->React.string}
      </Field.Label>
    </Field>
  </Field.Group>
