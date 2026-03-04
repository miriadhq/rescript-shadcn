@@directive("'use client'")

type dateRange = {
  from: option<Date.t>,
  to: option<Date.t>,
}

@react.component
let make = () => {
  let year = Date.make()->Date.getFullYear
  let startDate = Date.makeWithYMD(~year, ~month=0, ~day=12)
  let initialRange: dateRange = {
    from: Some(startDate),
    to: Some(Date.makeWithYMD(~year, ~month=0, ~day=42)),
  }
  let (dateRange, setDateRange) = React.useState(() => Some(initialRange))

  <Calendar
    mode="range"
    defaultMonth=?{switch dateRange {
    | Some(value) => value.from
    | None => None
    }}
    selected=dateRange
    onSelect={(value: option<dateRange>) => setDateRange(_ => value)}
    numberOfMonths=2
    className="rounded-lg border"
  />
}
