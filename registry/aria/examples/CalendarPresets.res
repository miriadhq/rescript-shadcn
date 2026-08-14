@@directive("'use client'")

module IDate = ReactAria.InternationalizedDate

type preset = {label: string, value: int}

let presets = [
  {label: "Today", value: 0},
  {label: "Tomorrow", value: 1},
  {label: "In 3 days", value: 3},
  {label: "In a week", value: 7},
  {label: "In 2 weeks", value: 14},
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let today = IDate.today(IDate.getLocalTimeZone())
  let (date, setDate) = React.useState(() => today)
  let (focusedDate, setFocusedDate) = React.useState(() => today)

  <Card className="mx-auto w-fit max-w-[300px]" size=Sm>
    <Card.Content>
      <Calendar
        value=date
        onChange={date => setDate(_ => date)}
        focusedValue=focusedDate
        onFocusChange={date => setFocusedDate(_ => date)}
        className="p-0 [--cell-size:--spacing(9.5)]"
      />
    </Card.Content>
    <Card.Footer className="flex flex-wrap gap-2 border-t">
      {presets
      ->Array.map(preset =>
        <Button
          key={preset.value->Int.toString}
          variant=Outline
          size=Sm
          className="flex-1"
          onPress={_ => {
            let nextDate = today->IDate.add({days: preset.value})
            setDate(_ => nextDate)
            setFocusedDate(_ => nextDate)
          }}
        >
          {preset.label->React.string}
        </Button>
      )
      ->React.array}
    </Card.Footer>
  </Card>
}
