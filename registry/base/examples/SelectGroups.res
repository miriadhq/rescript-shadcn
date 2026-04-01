let fruits: array<BaseUi.Select.Item.t<null<string>>> = [
  {label: "Apple", value: Null.Value("apple")},
  {label: "Banana", value: Value("banana")},
  {label: "Blueberry", value: Value("blueberry")},
]

let vegetables: array<BaseUi.Select.Item.t<null<string>>> = [
  {label: "Carrot", value: Null.Value("carrot")},
  {label: "Broccoli", value: Value("broccoli")},
  {label: "Spinach", value: Value("spinach")},
]

let allItems: array<BaseUi.Select.Item.t<null<string>>> = [
  {label: "Select a fruit", value: Null.null},
  {label: "Apple", value: Value("apple")},
  {label: "Banana", value: Value("banana")},
  {label: "Blueberry", value: Value("blueberry")},
  {label: "Carrot", value: Value("carrot")},
  {label: "Broccoli", value: Value("broccoli")},
  {label: "Spinach", value: Value("spinach")},
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
