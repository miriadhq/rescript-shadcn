@@directive("'use client'")

module IDate = ReactAria.InternationalizedDate

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let year = Date.make()->Date.getFullYear
  let start = IDate.calendarDate(year, 1, 12)
  let (dateRange, setDateRange) = React.useState(() => {
    ReactAria.Calendar.Range.start: start,
    end_: start->IDate.add({days: 30}),
  })

  <Calendar.Range
    value=dateRange
    onChange={range => setDateRange(_ => range)}
    numberOfMonths=2
    className="rounded-lg border"
  />
}
