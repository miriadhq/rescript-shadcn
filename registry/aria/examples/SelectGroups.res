let fruits: array<ReactAria.Select.Item.t<string>> = [
  {label: "Apple", value: "apple"},
  {label: "Banana", value: "banana"},
  {label: "Blueberry", value: "blueberry"},
]

let vegetables: array<ReactAria.Select.Item.t<string>> = [
  {label: "Carrot", value: "carrot"},
  {label: "Broccoli", value: "broccoli"},
  {label: "Spinach", value: "spinach"},
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Select className="w-full max-w-48" placeholder="Select a fruit">
    <Select.Trigger>
      <Select.Value />
    </Select.Trigger>
    <Select.Content>
      <Select.Group>
        <Select.Label> {"Fruits"->React.string} </Select.Label>
        {fruits
        ->Array.map(item =>
          <Select.Item key=item.value id=item.value> {item.label->React.string} </Select.Item>
        )
        ->React.array}
      </Select.Group>
      <Select.Separator />
      <Select.Group>
        <Select.Label> {"Vegetables"->React.string} </Select.Label>
        {vegetables
        ->Array.map(item =>
          <Select.Item key=item.value id=item.value> {item.label->React.string} </Select.Item>
        )
        ->React.array}
      </Select.Group>
    </Select.Content>
  </Select>
