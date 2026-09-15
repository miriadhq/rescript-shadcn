@@directive("'use client'")

module IDate = ReactAria.InternationalizedDate

type formatter
type formatOptions = {dateStyle: string}
@new @scope("Intl")
external makeFormatter: (option<string>, formatOptions) => formatter = "DateTimeFormat"
@send external formatRange: (formatter, Date.t, Date.t) => string = "formatRange"

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let year = Date.make()->Date.getFullYear
  let start = IDate.calendarDate(year, 1, 20)
  let (dateRange, setDateRange) = React.useState(() => {
    ReactAria.Calendar.Range.start,
    end_: start->IDate.add({days: 20}),
  })

  <Field className="mx-auto w-60">
    <Field.Label htmlFor="date-picker-range"> {"Date Picker Range"->React.string} </Field.Label>
    <Popover.Trigger>
      <Button variant=Outline id="date-picker-range" className="justify-start px-2.5 font-normal">
        <Icons.Calendar dataIcon="inline-start" />
        {makeFormatter(None, {dateStyle: "long"})
        ->formatRange(
          dateRange.start->IDate.toDate(IDate.getLocalTimeZone()),
          dateRange.end_->IDate.toDate(IDate.getLocalTimeZone()),
        )
        ->React.string}
      </Button>
      <Popover className="w-auto p-0" placement=ReactAria.Common.BottomStart>
        <Calendar.Range
          value=dateRange onChange={range => setDateRange(_ => range)} numberOfMonths=2
        />
      </Popover>
    </Popover.Trigger>
  </Field>
}
