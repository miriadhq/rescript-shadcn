@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field className="max-w-sm">
    <Field.Label htmlFor="inline-end-input"> {"Input"->React.string} </Field.Label>
    <InputGroup>
      <InputGroup.Input id="inline-end-input" type_="password" placeholder="Enter password" />
      <InputGroup.Addon align=InlineEnd>
        <Icons.EyeOff />
      </InputGroup.Addon>
    </InputGroup>
    <Field.Description> {"Icon positioned at the end."->React.string} </Field.Description>
  </Field>
