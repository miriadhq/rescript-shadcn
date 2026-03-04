@react.component
let make = () =>
  <Field.Group>
    <Field>
      <Field.Label htmlFor="fieldgroup-name"> {"Name"->React.string} </Field.Label>
      <Input id="fieldgroup-name" placeholder="Jordan Lee" />
    </Field>
    <Field>
      <Field.Label htmlFor="fieldgroup-email"> {"Email"->React.string} </Field.Label>
      <Input id="fieldgroup-email" type_="email" placeholder="name@example.com" />
      <Field.Description> {"We'll send updates to this address."->React.string} </Field.Description>
    </Field>
    <Field orientation=BaseUi.Types.Orientation.Horizontal>
      <Button type_="reset" variant=Button.Variant.Outline> {"Reset"->React.string} </Button>
      <Button type_="submit"> {"Submit"->React.string} </Button>
    </Field>
  </Field.Group>
