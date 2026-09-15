let items: array<ReactAria.Select.Item.t<string>> = [
  {label: "Apple", value: "apple"},
  {label: "Banana", value: "banana"},
  {label: "Blueberry", value: "blueberry"},
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field dataInvalid={true} className="w-full max-w-48">
    <Field.Label> {"Fruit"->React.string} </Field.Label>
    <Select placeholder="Select a fruit" isInvalid={true}>
      <Select.Trigger>
        <Select.Value />
      </Select.Trigger>
      <Select.Content>
        <Select.Group>
          {items
          ->Array.map(item =>
            <Select.Item key=item.value id=item.value> {item.label->React.string} </Select.Item>
          )
          ->React.array}
        </Select.Group>
      </Select.Content>
    </Select>
    <Field.Error> {"Please select a fruit."->React.string} </Field.Error>
  </Field>
