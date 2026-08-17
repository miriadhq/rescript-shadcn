@@directive("'use client'")

let frameworks = ["Next.js", "SvelteKit", "Nuxt.js", "Remix", "Astro"]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Combobox items={frameworks}>
    <Combobox.Input placeholder="Select a framework" ariaInvalid={#"true"} />
    <Combobox.Content>
      <Combobox.List
        renderEmptyState={_ => <Combobox.Empty> {"No items found."->React.string} </Combobox.Empty>}
      >
        {item => <Combobox.Item key=item value=item> {item->React.string} </Combobox.Item>}
      </Combobox.List>
    </Combobox.Content>
  </Combobox>
