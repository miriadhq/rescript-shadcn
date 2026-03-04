@@directive("'use client'")

let frameworks = ["Next.js", "SvelteKit", "Nuxt.js", "Remix", "Astro"]

@react.component
let make = () =>
  <Combobox multiple={true} items={frameworks}>
    <Combobox.Chips className="w-full max-w-xs">
      <Combobox.Chip> {"Next.js"->React.string} </Combobox.Chip>
      <Combobox.ChipsInput />
    </Combobox.Chips>
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
