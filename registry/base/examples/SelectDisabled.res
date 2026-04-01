type row = {
  label: string,
  value: null<string>,
  disabled: bool,
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let rows = [
    {label: "Select a fruit", value: Null.null, disabled: false},
    {label: "Apple", value: Value("apple"), disabled: false},
    {label: "Banana", value: Value("banana"), disabled: false},
    {label: "Blueberry", value: Value("blueberry"), disabled: false},
    {label: "Grapes", value: Value("grapes"), disabled: true},
    {label: "Pineapple", value: Value("pineapple"), disabled: false},
  ]

  <Select
    items={rows->Array.map((r: row): BaseUi.Select.Item.t<null<string>> => {
      label: r.label,
      value: r.value,
    })} disabled={true}
  >
    <Select.Trigger className="w-full max-w-48">
      <Select.Value />
    </Select.Trigger>
    <Select.Content>
      <Select.Group>
        {rows
        ->Array.map(row =>
          <Select.Item key={row.label} value={row.value} disabled={row.disabled}>
            {row.label->React.string}
          </Select.Item>
        )
        ->React.array}
      </Select.Group>
    </Select.Content>
  </Select>
}
