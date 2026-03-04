@react.component
let make = () =>
  <Field>
    <Field.Label htmlFor="input-button-group"> {"Search"->React.string} </Field.Label>
    <ButtonGroup>
      <Input id="input-button-group" placeholder="Type to search..." />
      <Button variant=Button.Variant.Outline> {"Search"->React.string} </Button>
    </ButtonGroup>
  </Field>
