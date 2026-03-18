@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let year = Date.make()->Date.getFullYear
  let initialDate = Date.makeWithYMD(~year, ~month=0, ~day=6)
  let (date, setDate) = React.useState(() => Some(initialDate))
  let bookedDates = Array.fromInitializer(~length=15, i =>
    Date.makeWithYMD(~year, ~month=0, ~day=12 + i)
  )

  <Card className="mx-auto w-fit p-0">
    <Card.Content className="p-0">
      <Calendar
        mode=Single
        defaultMonth=?date
        selected=?date
        onSelect={value => setDate(_ => value)}
        disabled=Dates(bookedDates)
        modifiers={dict{"booked": Calendar.DayPicker.Matcher.Dates(bookedDates)}}
        modifiersClassNames={dict{"booked": "[&>button]:line-through opacity-100"}}
      />
    </Card.Content>
  </Card>
}
