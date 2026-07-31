@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field>
    <Field.Label htmlFor="input-required">
      {"Required Field "->React.string}
      <span className="text-destructive"> {"*"->React.string} </span>
    </Field.Label>
    <Input id="input-required" placeholder="This field is required" required={true} />
    <Field.Description> {"This field must be filled out."->React.string} </Field.Description>
  </Field>
