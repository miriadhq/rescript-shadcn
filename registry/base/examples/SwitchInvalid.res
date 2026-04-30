@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field orientation=Horizontal className="max-w-sm" dataInvalid={true}>
    <Field.Content>
      <Field.Label htmlFor="switch-terms">
        {"Accept terms and conditions"->React.string}
      </Field.Label>
      <Field.Description>
        {"You must accept the terms and conditions to continue."->React.string}
      </Field.Description>
    </Field.Content>
    <Switch id="switch-terms" ariaInvalid={#"true"} />
  </Field>
