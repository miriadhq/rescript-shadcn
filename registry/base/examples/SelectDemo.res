let items: array<BaseUi.Select.Item.t<null<string>>> = [
  {label: "Select a fruit", value: Null.null},
  {label: "Apple", value: Value("apple")},
  {label: "Banana", value: Value("banana")},
  {label: "Blueberry", value: Value("blueberry")},
  {label: "Grapes", value: Value("grapes")},
  {label: "Pineapple", value: Value("pineapple")},
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
