let northAmerica: array<BaseUi.Select.Item.t<null<string>>> = [
  {label: "Eastern Standard Time", value: Null.Value("est")},
  {label: "Central Standard Time", value: Value("cst")},
  {label: "Mountain Standard Time", value: Value("mst")},
  {label: "Pacific Standard Time", value: Value("pst")},
  {label: "Alaska Standard Time", value: Value("akst")},
  {label: "Hawaii Standard Time", value: Value("hst")},
]

let europeAfrica: array<BaseUi.Select.Item.t<null<string>>> = [
  {label: "Greenwich Mean Time", value: Null.Value("gmt")},
  {label: "Central European Time", value: Value("cet")},
  {label: "Eastern European Time", value: Value("eet")},
  {label: "Western European Summer Time", value: Value("west")},
  {label: "Central Africa Time", value: Value("cat")},
  {label: "East Africa Time", value: Value("eat")},
]

let asia: array<BaseUi.Select.Item.t<null<string>>> = [
  {label: "Moscow Time", value: Null.Value("msk")},
  {label: "India Standard Time", value: Value("ist")},
  {label: "China Standard Time", value: Value("cst_china")},
  {label: "Japan Standard Time", value: Value("jst")},
  {label: "Korea Standard Time", value: Value("kst")},
  {label: "Indonesia Central Standard Time", value: Value("ist_indonesia")},
]

let australiaPacific: array<BaseUi.Select.Item.t<null<string>>> = [
  {label: "Australian Western Standard Time", value: Null.Value("awst")},
  {label: "Australian Central Standard Time", value: Value("acst")},
  {label: "Australian Eastern Standard Time", value: Value("aest")},
  {label: "New Zealand Standard Time", value: Value("nzst")},
  {label: "Fiji Time", value: Value("fjt")},
]

let southAmerica: array<BaseUi.Select.Item.t<null<string>>> = [
  {label: "Argentina Time", value: Null.Value("art")},
  {label: "Bolivia Time", value: Value("bot")},
  {label: "Brasilia Time", value: Value("brt")},
  {label: "Chile Standard Time", value: Value("clt")},
]

let items: array<BaseUi.Select.Item.t<null<string>>> = [
  {label: "Select a timezone", value: Null.null},
  {label: "Eastern Standard Time", value: Value("est")},
  {label: "Central Standard Time", value: Value("cst")},
  {label: "Mountain Standard Time", value: Value("mst")},
  {label: "Pacific Standard Time", value: Value("pst")},
  {label: "Alaska Standard Time", value: Value("akst")},
  {label: "Hawaii Standard Time", value: Value("hst")},
  {label: "Greenwich Mean Time", value: Value("gmt")},
  {label: "Central European Time", value: Value("cet")},
  {label: "Eastern European Time", value: Value("eet")},
  {label: "Western European Summer Time", value: Value("west")},
  {label: "Central Africa Time", value: Value("cat")},
  {label: "East Africa Time", value: Value("eat")},
  {label: "Moscow Time", value: Value("msk")},
  {label: "India Standard Time", value: Value("ist")},
  {label: "China Standard Time", value: Value("cst_china")},
  {label: "Japan Standard Time", value: Value("jst")},
  {label: "Korea Standard Time", value: Value("kst")},
  {label: "Indonesia Central Standard Time", value: Value("ist_indonesia")},
  {label: "Australian Western Standard Time", value: Value("awst")},
  {label: "Australian Central Standard Time", value: Value("acst")},
  {label: "Australian Eastern Standard Time", value: Value("aest")},
  {label: "New Zealand Standard Time", value: Value("nzst")},
  {label: "Fiji Time", value: Value("fjt")},
  {label: "Argentina Time", value: Value("art")},
  {label: "Bolivia Time", value: Value("bot")},
  {label: "Brasilia Time", value: Value("brt")},
  {label: "Chile Standard Time", value: Value("clt")},
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
