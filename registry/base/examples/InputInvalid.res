@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field dataInvalid={true}>
    <Field.Label htmlFor="input-invalid"> {"Invalid Input"->React.string} </Field.Label>
    <Input id="input-invalid" placeholder="Error" ariaInvalid={true} />
    <Field.Description>
      {"This field contains validation errors."->React.string}
    </Field.Description>
  </Field>
