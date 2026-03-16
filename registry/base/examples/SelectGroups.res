let fruits = [
  {BaseUi.Select.Item.label: "Apple", value: Some("apple")},
  {label: "Banana", value: Some("banana")},
  {label: "Blueberry", value: Some("blueberry")},
]

let vegetables = [
  {BaseUi.Select.Item.label: "Carrot", value: Some("carrot")},
  {label: "Broccoli", value: Some("broccoli")},
  {label: "Spinach", value: Some("spinach")},
]

let allItems = [
  {BaseUi.Select.Item.label: "Select a fruit", value: None},
  {label: "Apple", value: Some("apple")},
  {label: "Banana", value: Some("banana")},
  {label: "Blueberry", value: Some("blueberry")},
  {label: "Carrot", value: Some("carrot")},
  {label: "Broccoli", value: Some("broccoli")},
  {label: "Spinach", value: Some("spinach")},
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Select items={allItems}>
    <Select.Trigger className="w-full max-w-48">
      <Select.Value />
    </Select.Trigger>
    <Select.Content>
      <Select.Group>
        <Select.Label> {"Fruits"->React.string} </Select.Label>
        {fruits
        ->Array.map(item =>
          <Select.Item key={item.label} value={item.value}>
            {item.label->React.string}
          </Select.Item>
        )
        ->React.array}
      </Select.Group>
      <Select.Separator />
      <Select.Group>
        <Select.Label> {"Vegetables"->React.string} </Select.Label>
        {vegetables
        ->Array.map(item =>
          <Select.Item key={item.label} value={item.value}>
            {item.label->React.string}
          </Select.Item>
        )
        ->React.array}
      </Select.Group>
    </Select.Content>
  </Select>
