@@directive("'use client'")

let frameworks = ["Next.js", "SvelteKit", "Nuxt.js", "Remix", "Astro"]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let anchor = Combobox.useAnchor()
  <Combobox.Multiple
    autoHighlight=true items={frameworks} defaultValue={[frameworks->Array.getUnsafe(0)]}
  >
    <Combobox.Chips ref=anchor className="w-full max-w-xs">
      <Combobox.Value>
        {values => <>
          {values
          ->Array.map(value => <Combobox.Chip key={value}> {value->React.string} </Combobox.Chip>)
          ->React.array}
          <Combobox.ChipsInput />
        </>}
      </Combobox.Value>
    </Combobox.Chips>
    <Combobox.Content>
      <Combobox.Empty> {"No items found."->React.string} </Combobox.Empty>
      <Combobox.List>
        {(item, _index) =>
          <Combobox.Item key=item value=item> {item->React.string} </Combobox.Item>}
      </Combobox.List>
    </Combobox.Content>
  </Combobox.Multiple>
}
