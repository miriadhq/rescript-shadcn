@@directive("'use client'")

type framework = {id: string, name: string}

let frameworks = ["Next.js", "SvelteKit", "Nuxt.js", "Remix", "Astro"]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  <Combobox
    ariaLabel="Frameworks"
    selectionMode=ReactAria.Combobox.Multiple
    items={frameworks->Array.map(name => {id: name, name})}
    defaultValue={[frameworks->Array.getUnsafe(0)]}
    allowsEmptyCollection=true
    className="w-[250px] max-w-full"
  >
    <Combobox.Chips>
      <Combobox.ChipList>
        {value =>
          <Combobox.Chip key=value.name id=value.name> {value.name->React.string} </Combobox.Chip>}
      </Combobox.ChipList>
      <Combobox.ChipsInput />
    </Combobox.Chips>
    <Combobox.Content>
      <Combobox.List
        renderEmptyState={_ => <Combobox.Empty> {"No items found."->React.string} </Combobox.Empty>}
      >
        {item =>
          <Combobox.Item key=item.name id=item.name value=item>
            {item.name->React.string}
          </Combobox.Item>}
      </Combobox.List>
    </Combobox.Content>
  </Combobox>
}
