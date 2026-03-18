@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field.Group>
    <Field>
      <Field.Label htmlFor="input-default-01">
        {"Default (No Input Group)"->React.string}
      </Field.Label>
      <Input placeholder="Placeholder" id="input-default-01" />
    </Field>
    <Field>
      <Field.Label htmlFor="input-group-02"> {"Input Group"->React.string} </Field.Label>
      <InputGroup>
        <InputGroup.Input id="input-group-02" placeholder="Placeholder" />
      </InputGroup>
    </Field>
    <Field dataDisabled={true}>
      <Field.Label htmlFor="input-disabled-03"> {"Disabled"->React.string} </Field.Label>
      <InputGroup>
        <InputGroup.Input
          id="input-disabled-03" placeholder="This field is disabled" disabled={true}
        />
      </InputGroup>
    </Field>
    <Field dataInvalid={true}>
      <Field.Label htmlFor="input-invalid-04"> {"Invalid"->React.string} </Field.Label>
      <InputGroup>
        <InputGroup.Input
          id="input-invalid-04" placeholder="This field is invalid" ariaInvalid={true}
        />
      </InputGroup>
    </Field>
  </Field.Group>
