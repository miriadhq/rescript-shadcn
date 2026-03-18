let items = [
  {BaseUi.Select.Item.label: "Select a fruit", value: Null.null},
  {label: "Apple", value: Value("apple")},
  {label: "Banana", value: Value("banana")},
  {label: "Blueberry", value: Value("blueberry")},
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field dataInvalid={true} className="w-full max-w-48">
    <Field.Label> {"Fruit"->React.string} </Field.Label>
    <Select items>
      <Select.Trigger render={<button type_="button" ariaInvalid=#"true" />}>
        <Select.Value />
      </Select.Trigger>
      <Select.Content>
        <Select.Group>
          {items
          ->Array.map(item =>
            <Select.Item key={item.label} value={item.value}>
              {item.label->React.string}
            </Select.Item>
          )
          ->React.array}
        </Select.Group>
      </Select.Content>
    </Select>
    <Field.Error> {"Please select a fruit."->React.string} </Field.Error>
  </Field>
