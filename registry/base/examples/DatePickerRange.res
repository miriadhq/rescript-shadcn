@@directive("'use client'")

@module("date-fns") external format: (Date.t, string) => string = "format"
@module("date-fns") external addDays: (Date.t, int) => Date.t = "addDays"

type dateRange = {
  from?: Date.t,
  to?: Date.t,
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (dateRange, setDateRange) = React.useState(() => {
    let now = Date.make()
    let fromDate = Date.makeWithYMD(~year=Date.getFullYear(now), ~month=0, ~day=20)
    Some({
      from: fromDate,
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
        | Some({from: ?Some(from), to}) =>
          React.string(`${from->format("LLL dd, y")} - ${to->format("LLL dd, y")}`)
        | Some({from: ?Some(from)}) => from->format("LLL dd, y")->React.string
        | _ => <span> {"Pick a date"->React.string} </span>
        }}
      </Popover.Trigger>
      <Popover.Content className="w-auto p-0" align=BaseUi.Types.Align.Start>
        <Calendar
          mode=Range
          defaultMonth=?{dateRange->Option.flatMap(r => r.from)}
          selected={dateRange}
          onSelect={(value: option<dateRange>) => setDateRange(_ => value)}
          numberOfMonths={2}
        />
      </Popover.Content>
    </Popover>
  </Field>
}
