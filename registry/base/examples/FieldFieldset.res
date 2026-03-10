@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field.Set className="w-full max-w-sm">
    <Field.Legend> {"Address Information"->React.string} </Field.Legend>
    <Field.Description>
      {"We need your address to deliver your order."->React.string}
    </Field.Description>
    <Field.Group>
      <Field>
        <Field.Label htmlFor="street"> {"Street Address"->React.string} </Field.Label>
        <Input id="street" type_="text" placeholder="123 Main St" />
      </Field>
      <div className="grid grid-cols-2 gap-4">
        <Field>
          <Field.Label htmlFor="city"> {"City"->React.string} </Field.Label>
          <Input id="city" type_="text" placeholder="New York" />
        </Field>
        <Field>
          <Field.Label htmlFor="zip"> {"Postal Code"->React.string} </Field.Label>
          <Input id="zip" type_="text" placeholder="90502" />
        </Field>
      </div>
    </Field.Group>
  </Field.Set>
