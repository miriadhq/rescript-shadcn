@@directive("'use client'")

type item = {label: string, value: string, disabled: bool}

let items: array<item> = [
  {label: "Apple", value: "apple", disabled: false},
  {label: "Banana", value: "banana", disabled: false},
  {label: "Blueberry", value: "blueberry", disabled: false},
  {label: "Grapes", value: "grapes", disabled: true},
  {label: "Pineapple", value: "pineapple", disabled: false},
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Select items defaultValue="banana" ariaLabel="Fruits" placeholder="Select a fruit">
    <Select.Trigger>
      <Select.Value />
    </Select.Trigger>
    <Select.Content>
      <Select.Group>
        {items
        ->Array.map(item =>
          <Select.Item
            key={item.value} value={item.value} isDisabled={item.disabled}
          >
            {item.label->React.string}
          </Select.Item>
        )
        ->React.array}
      </Select.Group>
    </Select.Content>
  </Select>
