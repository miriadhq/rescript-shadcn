@@directive("'use client'")

type country = {code: string, value: string, label: string, continent: string}

let countries: array<country> = [
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

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let contains = ReactAria.Autocomplete.useFilter({sensitivity: "base"}).contains
  <Select placeholder="Select country" className="w-full max-w-48">
    <Select.Trigger> <Select.Value /> </Select.Trigger>
    <ReactAria.Autocomplete filter=contains>
      <Select.Popover>
        <Select.Input />
        <Select.List
          renderEmptyState={() => <Select.Empty> {"No items found."->React.string} </Select.Empty>}
        >
          <Select.Group items=countries>
            {country =>
              <Select.Item id={country.value}> {country.label->React.string} </Select.Item>}
          </Select.Group>
        </Select.List>
      </Select.Popover>
    </ReactAria.Autocomplete>
  </Select>
}
