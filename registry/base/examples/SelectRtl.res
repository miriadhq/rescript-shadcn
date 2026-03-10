@@directive("'use client'")

type item = {
  label: string,
  value: string,
}

let fruits: array<item> = [
  {label: "تفاح", value: "apple"},
  {label: "موز", value: "banana"},
  {label: "توت أزرق", value: "blueberry"},
  {label: "عنب", value: "grapes"},
  {label: "أناناس", value: "pineapple"},
]

let vegetables: array<item> = [
  {label: "جزر", value: "carrot"},
  {label: "بروكلي", value: "broccoli"},
  {label: "سبانخ", value: "spinach"},
]

let allItems = Array.concat(
  [{label: "اختر فاكهة", value: ""}],
  Array.concat(fruits, vegetables),
)

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Select items={allItems}>
    <Select.Trigger className="w-32">
      <Select.Value />
    </Select.Trigger>
    <Select.Content>
      <Select.Group>
        <Select.Label> {"الفواكه"->React.string} </Select.Label>
        {fruits
        ->Array.map(item =>
          <Select.Item key={item.value} value={item.value}>
            {item.label->React.string}
          </Select.Item>
        )
        ->React.array}
      </Select.Group>
      <Select.Separator />
      <Select.Group>
        <Select.Label> {"الخضروات"->React.string} </Select.Label>
        {vegetables
        ->Array.map(item =>
          <Select.Item key={item.value} value={item.value}>
            {item.label->React.string}
          </Select.Item>
        )
        ->React.array}
      </Select.Group>
    </Select.Content>
  </Select>
