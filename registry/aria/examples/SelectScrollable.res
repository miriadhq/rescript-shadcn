let northAmerica: array<ReactAria.Select.Item.t<string>> = [
  {label: "Eastern Standard Time", value: "est"},
  {label: "Central Standard Time", value: "cst"},
  {label: "Mountain Standard Time", value: "mst"},
  {label: "Pacific Standard Time", value: "pst"},
  {label: "Alaska Standard Time", value: "akst"},
  {label: "Hawaii Standard Time", value: "hst"},
]

let europeAfrica: array<ReactAria.Select.Item.t<string>> = [
  {label: "Greenwich Mean Time", value: "gmt"},
  {label: "Central European Time", value: "cet"},
  {label: "Eastern European Time", value: "eet"},
  {label: "Western European Summer Time", value: "west"},
  {label: "Central Africa Time", value: "cat"},
  {label: "East Africa Time", value: "eat"},
]

let asia: array<ReactAria.Select.Item.t<string>> = [
  {label: "Moscow Time", value: "msk"},
  {label: "India Standard Time", value: "ist"},
  {label: "China Standard Time", value: "cst_china"},
  {label: "Japan Standard Time", value: "jst"},
  {label: "Korea Standard Time", value: "kst"},
  {label: "Indonesia Central Standard Time", value: "ist_indonesia"},
]

let australiaPacific: array<ReactAria.Select.Item.t<string>> = [
  {label: "Australian Western Standard Time", value: "awst"},
  {label: "Australian Central Standard Time", value: "acst"},
  {label: "Australian Eastern Standard Time", value: "aest"},
  {label: "New Zealand Standard Time", value: "nzst"},
  {label: "Fiji Time", value: "fjt"},
]

let southAmerica: array<ReactAria.Select.Item.t<string>> = [
  {label: "Argentina Time", value: "art"},
  {label: "Bolivia Time", value: "bot"},
  {label: "Brasilia Time", value: "brt"},
  {label: "Chile Standard Time", value: "clt"},
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Select className="w-full max-w-64" placeholder="Select a timezone">
    <Select.Trigger>
      <Select.Value />
    </Select.Trigger>
    <Select.Content>
      <Select.Group>
        <Select.Label> {"North America"->React.string} </Select.Label>
        {northAmerica
        ->Array.map(item =>
          <Select.Item key=item.value id=item.value> {item.label->React.string} </Select.Item>
        )
        ->React.array}
      </Select.Group>
      <Select.Group>
        <Select.Label> {"Europe & Africa"->React.string} </Select.Label>
        {europeAfrica
        ->Array.map(item =>
          <Select.Item key=item.value id=item.value> {item.label->React.string} </Select.Item>
        )
        ->React.array}
      </Select.Group>
      <Select.Group>
        <Select.Label> {"Asia"->React.string} </Select.Label>
        {asia
        ->Array.map(item =>
          <Select.Item key=item.value id=item.value> {item.label->React.string} </Select.Item>
        )
        ->React.array}
      </Select.Group>
      <Select.Group>
        <Select.Label> {"Australia & Pacific"->React.string} </Select.Label>
        {australiaPacific
        ->Array.map(item =>
          <Select.Item key=item.value id=item.value> {item.label->React.string} </Select.Item>
        )
        ->React.array}
      </Select.Group>
      <Select.Group>
        <Select.Label> {"South America"->React.string} </Select.Label>
        {southAmerica
        ->Array.map(item =>
          <Select.Item key=item.value id=item.value> {item.label->React.string} </Select.Item>
        )
        ->React.array}
      </Select.Group>
    </Select.Content>
  </Select>
