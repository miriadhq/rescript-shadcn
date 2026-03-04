type item = {
  label: string,
  value: string,
}

let items = [
  {label: "Choose department", value: ""},
  {label: "Engineering", value: "engineering"},
  {label: "Design", value: "design"},
  {label: "Marketing", value: "marketing"},
  {label: "Sales", value: "sales"},
  {label: "Customer Support", value: "support"},
  {label: "Human Resources", value: "hr"},
  {label: "Finance", value: "finance"},
  {label: "Operations", value: "operations"},
]

@react.component
let make = () =>
  <Field className="w-full max-w-xs">
    <Field.Label> {"Department"->React.string} </Field.Label>
    <Select items>
      <Select.Trigger>
        <Select.Value />
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
