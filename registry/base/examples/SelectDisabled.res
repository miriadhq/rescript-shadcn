type item = {
  label: string,
  value: option<string>,
  disabled: bool,
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let items = [
    {label: "Select a fruit", value: None, disabled: false},
    {label: "Apple", value: Some("apple"), disabled: false},
    {label: "Banana", value: Some("banana"), disabled: false},
    {label: "Blueberry", value: Some("blueberry"), disabled: false},
    {label: "Grapes", value: Some("grapes"), disabled: true},
    {label: "Pineapple", value: Some("pineapple"), disabled: false},
  ]

  <Select
    items={items->Array.map(({label, value}) => {BaseUi.Select.Item.label, value})} disabled={true}
  >
    <Select.Trigger className="w-full max-w-48">
      <Select.Value />
    </Select.Trigger>
    <Select.Content>
      <Select.Group>
        {items
        ->Array.map(item =>
          <Select.Item key={item.label} value={item.value} disabled={item.disabled}>
            {item.label->React.string}
          </Select.Item>
        )
        ->React.array}
      </Select.Group>
    </Select.Content>
  </Select>
}
