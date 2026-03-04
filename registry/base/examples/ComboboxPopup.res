@@directive("'use client'")

type country = {
  code: string,
  value: string,
  label: string,
  continent: string,
}

let countries = [
  {code: "", value: "", label: "Select country", continent: ""},
  {code: "ar", value: "argentina", label: "Argentina", continent: "South America"},
  {code: "au", value: "australia", label: "Australia", continent: "Oceania"},
  {code: "br", value: "brazil", label: "Brazil", continent: "South America"},
  {code: "ca", value: "canada", label: "Canada", continent: "North America"},
  {code: "cn", value: "china", label: "China", continent: "Asia"},
  {code: "co", value: "colombia", label: "Colombia", continent: "South America"},
  {code: "eg", value: "egypt", label: "Egypt", continent: "Africa"},
  {code: "fr", value: "france", label: "France", continent: "Europe"},
  {code: "de", value: "germany", label: "Germany", continent: "Europe"},
  {code: "it", value: "italy", label: "Italy", continent: "Europe"},
  {code: "jp", value: "japan", label: "Japan", continent: "Asia"},
  {code: "ke", value: "kenya", label: "Kenya", continent: "Africa"},
  {code: "mx", value: "mexico", label: "Mexico", continent: "North America"},
  {code: "nz", value: "new-zealand", label: "New Zealand", continent: "Oceania"},
  {code: "ng", value: "nigeria", label: "Nigeria", continent: "Africa"},
  {code: "za", value: "south-africa", label: "South Africa", continent: "Africa"},
  {code: "kr", value: "south-korea", label: "South Korea", continent: "Asia"},
  {code: "gb", value: "united-kingdom", label: "United Kingdom", continent: "Europe"},
  {code: "us", value: "united-states", label: "United States", continent: "North America"},
]

@react.component
let make = () =>
  <Combobox
    items={countries}
    defaultValue={countries
    ->Array.get(0)
    ->Option.getOr({code: "", value: "", label: "Select country", continent: ""})}
  >
    <Combobox.Trigger
      render={<Button
        variant=Button.Variant.Outline className="w-64 justify-between font-normal"
      />}
    >
      <Combobox.Value />
    </Combobox.Trigger>
    <Combobox.Content>
      <Combobox.Input showTrigger={false} placeholder="Search" />
      <Combobox.Empty> {"No items found."->React.string} </Combobox.Empty>
      <Combobox.List>
        {countries
        ->Array.map(item =>
          <Combobox.Item key={item.code} value={item}> {item.label->React.string} </Combobox.Item>
        )
        ->React.array}
      </Combobox.List>
    </Combobox.Content>
  </Combobox>
