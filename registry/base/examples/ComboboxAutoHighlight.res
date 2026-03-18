@@directive("'use client'")

let frameworks = ["Next.js", "SvelteKit", "Nuxt.js", "Remix", "Astro"]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Combobox items={frameworks} autoHighlight=false>
    <Combobox.Input placeholder="Select a framework" />
    <Combobox.Content>
      <Combobox.Empty> {"No items found."->React.string} </Combobox.Empty>
      <Combobox.List>
        {(item, _index) =>
          <Combobox.Item key=item value=item> {item->React.string} </Combobox.Item>}
      </Combobox.List>
    </Combobox.Content>
  </Combobox>
