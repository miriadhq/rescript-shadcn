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

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Combobox items={timezones}>
    <Combobox.Input placeholder="Select a timezone" />
    <Combobox.Content>
      <Combobox.Empty> {"No timezones found."->React.string} </Combobox.Empty>
      <Combobox.List>
        {(group, index) =>
          <React.Fragment key={group.value}>
            <Combobox.Group>
              <Combobox.Label> {group.value->React.string} </Combobox.Label>
              {group.items
              ->Array.map(item =>
                <Combobox.Item key=item value=item> {item->React.string} </Combobox.Item>
              )
              ->React.array}
            </Combobox.Group>
            {index < Array.length(timezones) - 1 ? <Combobox.Separator /> : React.null}
          </React.Fragment>}
      </Combobox.List>
    </Combobox.Content>
  </Combobox>
