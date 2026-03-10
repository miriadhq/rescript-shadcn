@@directive("'use client'")

let frameworks = ["Next.js", "SvelteKit", "Nuxt.js", "Remix", "Astro"]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Combobox items={frameworks} defaultValue={"Next.js"}>
    <Combobox.Input placeholder="Select a framework" showClear={true} />
    <Combobox.Content>
      <Combobox.Empty> {"No items found."->React.string} </Combobox.Empty>
      <Combobox.List>
        {frameworks
        ->Array.map(item =>
          <Combobox.Item key=item value=item> {item->React.string} </Combobox.Item>
        )
        ->React.array}
      </Combobox.List>
    </Combobox.Content>
  </Combobox>
