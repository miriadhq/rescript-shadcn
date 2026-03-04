@react.component
let make = () =>
  <Field dataDisabled={true}>
    <Field.Label htmlFor="input-demo-disabled"> {"Email"->React.string} </Field.Label>
    <Input id="input-demo-disabled" type_="email" placeholder="Email" disabled={true} />
    <Field.Description> {"This field is currently disabled."->React.string} </Field.Description>
  </Field>
