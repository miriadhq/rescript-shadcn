@@directive("'use client'")

type country = {
  code: string,
  value: string,
  label: string,
  continent: string,
}

let countries = [
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
let make = ({}: Demo.Props.t) =>
  <Combobox items={countries} itemToStringValue={(c: country) => c.label}>
    <Combobox.Input placeholder="Search countries..." />
    <Combobox.Content>
      <Combobox.Empty> {"No countries found."->React.string} </Combobox.Empty>
      <Combobox.List>
        {(country, _index) =>
          <Combobox.Item key={country.code} value={country}>
            <Item size=Item.Size.Xs className="p-0">
              <Item.Content>
                <Item.Title className="whitespace-nowrap">
                  {country.label->React.string}
                </Item.Title>
                <Item.Description>
                  {`${country.continent} (${country.code})`->React.string}
                </Item.Description>
              </Item.Content>
            </Item>
          </Combobox.Item>}
      </Combobox.List>
    </Combobox.Content>
  </Combobox>
