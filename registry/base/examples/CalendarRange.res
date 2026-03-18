@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (dateRange, setDateRange) = React.useState(() => {
    let year = Date.make()->Date.getFullYear
    let startDate = Date.makeWithYMD(~year, ~month=0, ~day=12)
    {
      Calendar.DateRange.from: startDate,
      to: Date.makeWithYMD(~year, ~month=0, ~day=42),
    }->Some
  })

  <Calendar
    mode=Range
    defaultMonth=?{dateRange->Option.map(r => r.from)}
    selected=?dateRange
    onSelect={value => setDateRange(_ => value)}
    numberOfMonths=2
    className="rounded-lg border"
  />
}
