type item = {label: string, value: string}

let items: array<item> = [
  {label: "Apple", value: "apple"},
  {label: "Banana", value: "banana"},
  {label: "Blueberry", value: "blueberry"},
  {label: "Grapes", value: "grapes"},
  {label: "Pineapple", value: "pineapple"},
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Select placeholder="Select a fruit" className="w-full max-w-48">
    <Select.Trigger>
      <Select.Value />
    </Select.Trigger>
    <Select.Content>
      <Select.Group>
        <Select.Label> {"Fruits"->React.string} </Select.Label>
        {items
        ->Array.map(item =>
          <Select.Item key={item.value} id={item.value}>
            {item.label->React.string}
          </Select.Item>
        )
        ->React.array}
      </Select.Group>
    </Select.Content>
  </Select>
