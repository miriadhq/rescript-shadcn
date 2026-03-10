@@directive("'use client'")

let categories = ["technology", "design", "business", "marketing", "education", "health"]

let categoryLabelsAr = Dict.fromArray([
  ("technology", "التكنولوجيا"),
  ("design", "التصميم"),
  ("business", "الأعمال"),
  ("marketing", "التسويق"),
  ("education", "التعليم"),
  ("health", "الصحة"),
])

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  <Field className="mx-auto w-full max-w-xs">
    <Field.Label> {"الفئات"->React.string} </Field.Label>
    <Combobox
      multiple={true}
      items={categories}
      itemToStringValue={(item: string) => categoryLabelsAr->Dict.get(item)->Option.getOr(item)}
    >
      <Combobox.Chips>
        <Combobox.Chip> {"التكنولوجيا"->React.string} </Combobox.Chip>
        <Combobox.ChipsInput placeholder="أضف فئات" />
      </Combobox.Chips>
      <Combobox.Content dir="rtl" dataLang="ar">
        <Combobox.Empty>
          {"لم يتم العثور على فئات."->React.string}
        </Combobox.Empty>
        <Combobox.List>
          {categories
          ->Array.map(item =>
            <Combobox.Item key=item value=item>
              {categoryLabelsAr->Dict.get(item)->Option.getOr(item)->React.string}
            </Combobox.Item>
          )
          ->React.array}
        </Combobox.List>
      </Combobox.Content>
    </Combobox>
  </Field>
}
