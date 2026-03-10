@@directive("'use client'")

type timezone = {
  value: string,
  items: array<string>,
}

let timezones = [
  {
    value: "Americas",
    items: [
      "(GMT-5) New York",
      "(GMT-8) Los Angeles",
      "(GMT-6) Chicago",
      "(GMT-5) Toronto",
      "(GMT-8) Vancouver",
      "(GMT-3) São Paulo",
    ],
  },
  {
    value: "Europe",
    items: [
      "(GMT+0) London",
      "(GMT+1) Paris",
      "(GMT+1) Berlin",
      "(GMT+1) Rome",
      "(GMT+1) Madrid",
      "(GMT+1) Amsterdam",
    ],
  },
  {
    value: "Asia/Pacific",
    items: [
      "(GMT+9) Tokyo",
      "(GMT+8) Shanghai",
      "(GMT+8) Singapore",
      "(GMT+4) Dubai",
      "(GMT+11) Sydney",
      "(GMT+9) Seoul",
    ],
  },
]

let allItems = timezones->Array.flatMap(g => g.items)

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Combobox items={allItems}>
    <Combobox.Input placeholder="Select a timezone">
      <InputGroup.Addon>
        <Icons.Globe />
      </InputGroup.Addon>
    </Combobox.Input>
    <Combobox.Content alignOffset={-28.} className="w-60">
      <Combobox.Empty> {"No timezones found."->React.string} </Combobox.Empty>
      <Combobox.List>
        {timezones
        ->Array.map(group =>
          <Combobox.Group key={group.value}>
            <Combobox.Label> {group.value->React.string} </Combobox.Label>
            {group.items
            ->Array.map(item =>
              <Combobox.Item key=item value=item> {item->React.string} </Combobox.Item>
            )
            ->React.array}
          </Combobox.Group>
        )
        ->React.array}
      </Combobox.List>
    </Combobox.Content>
  </Combobox>
