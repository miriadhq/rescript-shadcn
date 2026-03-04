@react.component
let make = () =>
  <Field>
    <Field.Label htmlFor="picture"> {"Picture"->React.string} </Field.Label>
    <Input id="picture" type_="file" />
    <Field.Description> {"Select a picture to upload."->React.string} </Field.Description>
  </Field>
