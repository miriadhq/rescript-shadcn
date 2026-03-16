let items = [
  {BaseUi.Select.Item.label: "Select a fruit", value: None},
  {label: "Apple", value: Some("apple")},
  {label: "Banana", value: Some("banana")},
  {label: "Blueberry", value: Some("blueberry")},
  {label: "Grapes", value: Some("grapes")},
  {label: "Pineapple", value: Some("pineapple")},
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Select items>
    <Select.Trigger className="w-full max-w-48">
      <Select.Value />
    </Select.Trigger>
    <Select.Content>
      <Select.Group>
        <Select.Label> {"Fruits"->React.string} </Select.Label>
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
