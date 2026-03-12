@@directive("'use client'")

@module("date-fns") external format: (Date.t, string) => string = "format"
@module("date-fns") external addDays: (Date.t, int) => Date.t = "addDays"

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (dateRange, setDateRange) = React.useState(() => {
    let now = Date.make()
    let fromDate = Date.makeWithYMD(~year=Date.getFullYear(now), ~month=0, ~day=20)
    Some({
      Calendar.DateRange.from: fromDate,
      to: addDays(fromDate, 20),
    })
  })

  <Field className="mx-auto w-60">
    <Field.Label htmlFor="date-picker-range"> {"Date Picker Range"->React.string} </Field.Label>
    <Popover>
      <Popover.Trigger
        render={<Button
          variant=Button.Variant.Outline
          id="date-picker-range"
          className="justify-start px-2.5 font-normal"
        />}
      >
        <Icons.Calendar dataIcon="inline-start" />
        {switch dateRange {
        | Some({Calendar.DateRange.from: from, to}) =>
          React.string(`${from->format("LLL dd, y")} - ${to->format("LLL dd, y")}`)
        | Some({Calendar.DateRange.from: from}) => from->format("LLL dd, y")->React.string
        | _ => <span> {"Pick a date"->React.string} </span>
        }}
      </Popover.Trigger>
      <Popover.Content className="w-auto p-0" align=BaseUi.Types.Align.Start>
        <Calendar
          mode=Range
          defaultMonth=?{dateRange->Option.map(r => r.from)}
          selected=?dateRange
          onSelect={value => setDateRange(_ => value)}
          numberOfMonths={2}
        />
      </Popover.Content>
    </Popover>
  </Field>
}
