@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let countries: array<BaseUi.Select.Item.t<string>> = [
    {label: "United States", value: "us"},
    {label: "United Kingdom", value: "uk"},
    {label: "Canada", value: "ca"},
  ]
  <form className="w-full max-w-sm">
    <Field.Group>
      <Field>
        <Field.Label htmlFor="form-name"> {"Name"->React.string} </Field.Label>
        <Input id="form-name" type_="text" placeholder="Evil Rabbit" required={true} />
      </Field>
      <Field>
        <Field.Label htmlFor="form-email"> {"Email"->React.string} </Field.Label>
        <Input id="form-email" type_="email" placeholder="john@example.com" />
        <Field.Description>
          {"We'll never share your email with anyone."->React.string}
        </Field.Description>
      </Field>
      <div className="grid grid-cols-2 gap-4">
        <Field>
          <Field.Label htmlFor="form-phone"> {"Phone"->React.string} </Field.Label>
          <Input id="form-phone" type_="tel" placeholder="+1 (555) 123-4567" />
        </Field>
        <Field>
          <Field.Label htmlFor="form-country"> {"Country"->React.string} </Field.Label>
          <Select items={countries} defaultValue="us">
            <Select.Trigger id="form-country">
              <Select.Value />
            </Select.Trigger>
            <Select.Content>
              <Select.Group>
                {countries
                ->Array.map(c =>
                  <Select.Item key={c.value} value={c.value}> {c.label->React.string} </Select.Item>
                )
                ->React.array}
              </Select.Group>
            </Select.Content>
          </Select>
        </Field>
      </div>
      <Field>
        <Field.Label htmlFor="form-address"> {"Address"->React.string} </Field.Label>
        <Input id="form-address" type_="text" placeholder="123 Main St" />
      </Field>
      <Field orientation=BaseUi.Types.Orientation.Horizontal>
        <Button type_="button" variant=Button.Variant.Outline> {"Cancel"->React.string} </Button>
        <Button type_="submit"> {"Submit"->React.string} </Button>
      </Field>
    </Field.Group>
  </form>
}
