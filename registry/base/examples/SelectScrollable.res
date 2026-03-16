let northAmerica = [
  {BaseUi.Select.Item.label: "Eastern Standard Time", value: Some("est")},
  {label: "Central Standard Time", value: Some("cst")},
  {label: "Mountain Standard Time", value: Some("mst")},
  {label: "Pacific Standard Time", value: Some("pst")},
  {label: "Alaska Standard Time", value: Some("akst")},
  {label: "Hawaii Standard Time", value: Some("hst")},
]

let europeAfrica = [
  {BaseUi.Select.Item.label: "Greenwich Mean Time", value: Some("gmt")},
  {label: "Central European Time", value: Some("cet")},
  {label: "Eastern European Time", value: Some("eet")},
  {label: "Western European Summer Time", value: Some("west")},
  {label: "Central Africa Time", value: Some("cat")},
  {label: "East Africa Time", value: Some("eat")},
]

let asia = [
  {BaseUi.Select.Item.label: "Moscow Time", value: Some("msk")},
  {label: "India Standard Time", value: Some("ist")},
  {label: "China Standard Time", value: Some("cst_china")},
  {label: "Japan Standard Time", value: Some("jst")},
  {label: "Korea Standard Time", value: Some("kst")},
  {label: "Indonesia Central Standard Time", value: Some("ist_indonesia")},
]

let australiaPacific = [
  {BaseUi.Select.Item.label: "Australian Western Standard Time", value: Some("awst")},
  {label: "Australian Central Standard Time", value: Some("acst")},
  {label: "Australian Eastern Standard Time", value: Some("aest")},
  {label: "New Zealand Standard Time", value: Some("nzst")},
  {label: "Fiji Time", value: Some("fjt")},
]

let southAmerica = [
  {BaseUi.Select.Item.label: "Argentina Time", value: Some("art")},
  {label: "Bolivia Time", value: Some("bot")},
  {label: "Brasilia Time", value: Some("brt")},
  {label: "Chile Standard Time", value: Some("clt")},
]

let items = [
  {BaseUi.Select.Item.label: "Select a timezone", value: None},
  {label: "Eastern Standard Time", value: Some("est")},
  {label: "Central Standard Time", value: Some("cst")},
  {label: "Mountain Standard Time", value: Some("mst")},
  {label: "Pacific Standard Time", value: Some("pst")},
  {label: "Alaska Standard Time", value: Some("akst")},
  {label: "Hawaii Standard Time", value: Some("hst")},
  {label: "Greenwich Mean Time", value: Some("gmt")},
  {label: "Central European Time", value: Some("cet")},
  {label: "Eastern European Time", value: Some("eet")},
  {label: "Western European Summer Time", value: Some("west")},
  {label: "Central Africa Time", value: Some("cat")},
  {label: "East Africa Time", value: Some("eat")},
  {label: "Moscow Time", value: Some("msk")},
  {label: "India Standard Time", value: Some("ist")},
  {label: "China Standard Time", value: Some("cst_china")},
  {label: "Japan Standard Time", value: Some("jst")},
  {label: "Korea Standard Time", value: Some("kst")},
  {label: "Indonesia Central Standard Time", value: Some("ist_indonesia")},
  {label: "Australian Western Standard Time", value: Some("awst")},
  {label: "Australian Central Standard Time", value: Some("acst")},
  {label: "Australian Eastern Standard Time", value: Some("aest")},
  {label: "New Zealand Standard Time", value: Some("nzst")},
  {label: "Fiji Time", value: Some("fjt")},
  {label: "Argentina Time", value: Some("art")},
  {label: "Bolivia Time", value: Some("bot")},
  {label: "Brasilia Time", value: Some("brt")},
  {label: "Chile Standard Time", value: Some("clt")},
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Select items>
    <Select.Trigger className="w-full max-w-64">
      <Select.Value />
    </Select.Trigger>
    <Select.Content>
      <Select.Group>
        <Select.Label> {"North America"->React.string} </Select.Label>
        {northAmerica
        ->Array.map(item =>
          <Select.Item key={item.label} value={item.value}>
            {item.label->React.string}
          </Select.Item>
        )
        ->React.array}
      </Select.Group>
      <Select.Group>
        <Select.Label> {"Europe & Africa"->React.string} </Select.Label>
        {europeAfrica
        ->Array.map(item =>
          <Select.Item key={item.label} value={item.value}>
            {item.label->React.string}
          </Select.Item>
        )
        ->React.array}
      </Select.Group>
      <Select.Group>
        <Select.Label> {"Asia"->React.string} </Select.Label>
        {asia
        ->Array.map(item =>
          <Select.Item key={item.label} value={item.value}>
            {item.label->React.string}
          </Select.Item>
        )
        ->React.array}
      </Select.Group>
      <Select.Group>
        <Select.Label> {"Australia & Pacific"->React.string} </Select.Label>
        {australiaPacific
        ->Array.map(item =>
          <Select.Item key={item.label} value={item.value}>
            {item.label->React.string}
          </Select.Item>
        )
        ->React.array}
      </Select.Group>
      <Select.Group>
        <Select.Label> {"South America"->React.string} </Select.Label>
        {southAmerica
        ->Array.map(item =>
          <Select.Item key={item.label} value={item.value}>
            {item.label->React.string}
          </Select.Item>
        )
        ->React.array}
      </Select.Group>
    </Select.Content>
  </Select>
