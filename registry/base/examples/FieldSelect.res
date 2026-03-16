let items = [
  {BaseUi.Select.Item.label: "Engineering", value: "engineering"},
  {label: "Design", value: "design"},
  {label: "Marketing", value: "marketing"},
  {label: "Sales", value: "sales"},
  {label: "Customer Support", value: "support"},
  {label: "Human Resources", value: "hr"},
  {label: "Finance", value: "finance"},
  {label: "Operations", value: "operations"},
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field className="w-full max-w-xs">
    <Field.Label> {"Department"->React.string} </Field.Label>
    <Select items>
      <Select.Trigger>
        <Select.Value placeholder="Choose department" />
      </Select.Trigger>
      <Select.Content>
        <Select.Group>
          {items
          ->Array.map(item =>
            <Select.Item key={item.value} value={item.value}>
              {item.label->React.string}
            </Select.Item>
          )
          ->React.array}
        </Select.Group>
      </Select.Content>
    </Select>
    <Field.Description>
      {"Select your department or area of work."->React.string}
    </Field.Description>
  </Field>
