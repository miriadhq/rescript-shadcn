@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field>
    <Field.Label htmlFor="input-number"> {"Quantity"->React.string} </Field.Label>
    <Input
      id="input-number"
      type_="number"
      min="1"
      max="10"
      defaultValue="1"
      className="peer out-of-range:border-destructive out-of-range:ring-destructive/20"
      ariaDescribedby="input-number-description"
    />
    <Field.Description id="input-number-description">
      {"Enter a quantity between 1 and 10."->React.string}
    </Field.Description>
    <Field.Error id="input-number-error" className="hidden peer-out-of-range:block">
      {"Quantity must be between 1 and 10."->React.string}
    </Field.Error>
  </Field>
