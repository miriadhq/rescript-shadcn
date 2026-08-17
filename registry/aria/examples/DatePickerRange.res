@@directive("'use client'")

module IDate = ReactAria.InternationalizedDate

let formatDate = date =>
  date
  ->IDate.toDate(IDate.getLocalTimeZone())
  ->Date.toLocaleDateStringWithLocaleAndOptions(
    "en-US",
    {day: #"2-digit", month: #short, year: #numeric},
  )

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let year = Date.make()->Date.getFullYear
  let start = IDate.calendarDate(year, 1, 20)
  let (dateRange, setDateRange) = React.useState((): ReactAria.Calendar.Range.Value.t<
    ReactAria.Calendar.CalendarDate.t,
  > => {
    ReactAria.Calendar.Range.Value.start,
    end: start->IDate.add({days: 20}),
  })

  <Field className="mx-auto w-60">
    <Field.Label htmlFor="date-picker-range"> {"Date Picker Range"->React.string} </Field.Label>
    <Popover.Trigger>
      <Button variant=Outline id="date-picker-range" className="justify-start px-2.5 font-normal">
        <Icons.Calendar dataIcon="inline-start" />
        {dateRange.start->formatDate->React.string}
        {" - "->React.string}
        {dateRange.end->formatDate->React.string}
      </Button>
      <Popover className="w-auto p-0" placement=ReactAria.Common.Placement.BottomStart>
        <Calendar.Range
          value=dateRange onChange={range => setDateRange(_ => range)} numberOfMonths=2
        />
      </Popover>
    </Popover.Trigger>
  </Field>
}
