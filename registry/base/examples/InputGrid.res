@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field.Group className="grid max-w-sm grid-cols-2">
    <Field>
      <Field.Label htmlFor="first-name"> {"First Name"->React.string} </Field.Label>
      <Input id="first-name" placeholder="Jordan" />
    </Field>
    <Field>
      <Field.Label htmlFor="last-name"> {"Last Name"->React.string} </Field.Label>
      <Input id="last-name" placeholder="Lee" />
    </Field>
  </Field.Group>
