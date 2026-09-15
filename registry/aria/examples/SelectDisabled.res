type row = {
  label: string,
  value: string,
  disabled: bool,
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let rows = [
    {label: "Apple", value: "apple", disabled: false},
    {label: "Banana", value: "banana", disabled: false},
    {label: "Blueberry", value: "blueberry", disabled: false},
    {label: "Grapes", value: "grapes", disabled: true},
    {label: "Pineapple", value: "pineapple", disabled: false},
  ]

  <Select className="w-full max-w-48" placeholder="Select a fruit" isDisabled={true}>
    <Select.Trigger>
      <Select.Value />
    </Select.Trigger>
    <Select.Content>
      <Select.Group>
        {rows
        ->Array.map(row =>
          <Select.Item key=row.value id=row.value isDisabled={row.disabled}>
            {row.label->React.string}
          </Select.Item>
        )
        ->React.array}
      </Select.Group>
    </Select.Content>
  </Select>
}
