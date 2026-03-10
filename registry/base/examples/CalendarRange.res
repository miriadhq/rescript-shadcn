@@directive("'use client'")

type dateRange = {
  from: Date.t,
  to?: Date.t,
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (dateRange, setDateRange) = React.useState(() => {
    let year = Date.make()->Date.getFullYear
    let startDate = Date.makeWithYMD(~year, ~month=0, ~day=12)
    {
      from: startDate,
      to: Date.makeWithYMD(~year, ~month=0, ~day=42),
    }
  })

  <Calendar
    mode=Range
    defaultMonth={dateRange.from}
    selected=dateRange
    onSelect={value => setDateRange(_ => value)}
    numberOfMonths=2
    className="rounded-lg border"
  />
}
