@@directive("'use client'")

let frameworks = ["Next.js", "SvelteKit", "Nuxt.js", "Remix", "Astro"]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let anchor = Combobox.useAnchor()
  <Combobox
    selectionMode=ReactAria.Combobox.SelectionMode.Multiple
    items={frameworks}
    defaultValue={[frameworks->Array.getUnsafe(0)]}
    allowsEmptyCollection=true
  >
    <Combobox.Chips ref=anchor className="w-full max-w-xs">
      <Combobox.ChipList>
        {value => <Combobox.Chip key=value id=value> {value->React.string} </Combobox.Chip>}
      </Combobox.ChipList>
      <Combobox.ChipsInput />
    </Combobox.Chips>
    <Combobox.Content>
      <Combobox.List
        renderEmptyState={_ => <Combobox.Empty> {"No items found."->React.string} </Combobox.Empty>}
      >
        {item => <Combobox.Item key=item value=item> {item->React.string} </Combobox.Item>}
      </Combobox.List>
    </Combobox.Content>
  </Combobox>
}
