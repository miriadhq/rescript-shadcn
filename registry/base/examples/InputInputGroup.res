@react.component
let make = () =>
  <Field>
    <Field.Label htmlFor="input-group-url"> {"Website URL"->React.string} </Field.Label>
    <InputGroup>
      <InputGroup.Input id="input-group-url" placeholder="example.com" />
      <InputGroup.Addon>
        <InputGroup.Text> {"https://"->React.string} </InputGroup.Text>
      </InputGroup.Addon>
      <InputGroup.Addon align=InlineEnd>
        <Icons.Info />
      </InputGroup.Addon>
    </InputGroup>
  </Field>
