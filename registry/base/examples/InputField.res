@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field>
    <Field.Label htmlFor="input-field-username"> {"Username"->React.string} </Field.Label>
    <Input id="input-field-username" type_="text" placeholder="Enter your username" />
    <Field.Description>
      {"Choose a unique username for your account."->React.string}
    </Field.Description>
  </Field>
