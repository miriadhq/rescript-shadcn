@@directive("'use client'")

type preset = {
  label: string,
  value: int,
}

let presets: array<preset> = [
  {label: "Today", value: 0},
  {label: "Tomorrow", value: 1},
  {label: "In 3 days", value: 3},
  {label: "In a week", value: 7},
  {label: "In 2 weeks", value: 14},
]

@react.component
let make = () => {
  let now = Date.make()
  let year = now->Date.getFullYear
  let month = now->Date.getMonth
  let (date, setDate) = React.useState(() => Some(Date.makeWithYMD(~year, ~month=1, ~day=12)))
  let (currentMonth, setCurrentMonth) = React.useState(() =>
    Date.makeWithYMD(~year, ~month, ~day=1)
  )

  <Card className="mx-auto w-fit max-w-[300px]" size=Sm>
    <Card.Content>
      <Calendar
        mode="single"
        selected=date
        onSelect={(value: option<Date.t>) => setDate(_ => value)}
        month=currentMonth
        onMonthChange={(value: Date.t) => setCurrentMonth(_ => value)}
        fixedWeeks={true}
        className="p-0 [--cell-size:--spacing(9.5)]"
      />
    </Card.Content>
    <Card.Footer className="flex flex-wrap gap-2 border-t">
      {presets
      ->Array.map(preset =>
        <Button
          key={preset.value->Int.toString}
          variant=Button.Variant.Outline
          size=Button.Size.Sm
          className="flex-1"
          onClick={_ => {
            let today = Date.make()
            let newDate = Date.makeWithYMD(
              ~year=today->Date.getFullYear,
              ~month=today->Date.getMonth,
              ~day=today->Date.getDate + preset.value,
            )
            setDate(_ => Some(newDate))
            setCurrentMonth(_ =>
              Date.makeWithYMD(
                ~year=newDate->Date.getFullYear,
                ~month=newDate->Date.getMonth,
                ~day=1,
              )
            )
          }}
        >
          {preset.label->React.string}
        </Button>
      )
      ->React.array}
    </Card.Footer>
  </Card>
}
