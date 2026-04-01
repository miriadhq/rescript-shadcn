@@directive("'use client'")

let items: array<BaseUi.Select.Item.t<option<string>>> = [
  {label: "Select a fruit", value: None},
  {label: "Apple", value: Some("apple")},
  {label: "Banana", value: Some("banana")},
  {label: "Blueberry", value: Some("blueberry")},
  {label: "Grapes", value: Some("grapes")},
  {label: "Pineapple", value: Some("pineapple")},
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (alignItemWithTrigger, setAlignItemWithTrigger) = React.useState(() => true)

  <Field.Group className="w-full max-w-xs">
    <Field orientation=BaseUi.Types.Orientation.Horizontal>
      <Field.Content>
        <Field.Label htmlFor="align-item"> {"Align Item"->React.string} </Field.Label>
        <Field.Description>
          {"Toggle to align the item with the trigger."->React.string}
        </Field.Description>
      </Field.Content>
      <Switch
        id="align-item"
        checked={alignItemWithTrigger}
        onCheckedChange={(checked, _) => setAlignItemWithTrigger(_ => checked)}
      />
    </Field>
    <Field>
      <Select items defaultValue=Some("banana")>
        <Select.Trigger>
          <Select.Value />
        </Select.Trigger>
        <Select.Content dataAlignTrigger={alignItemWithTrigger}>
          <Select.Group>
            {items
            ->Array.map(item =>
              <Select.Item key={item.label} value=?item.value>
                {item.label->React.string}
              </Select.Item>
            )
            ->React.array}
          </Select.Group>
        </Select.Content>
      </Select>
    </Field>
  </Field.Group>
}
