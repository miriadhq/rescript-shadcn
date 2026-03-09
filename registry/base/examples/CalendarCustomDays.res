@@directive("'use client'")

type dateRange = {
  from: Date.t,
  to?: Date.t,
}

@react.component
let make = () => {
  let (range, setRange) = React.useState(() => {
    let year = Date.make()->Date.getFullYear
    let startDate = Date.makeWithYMD(~year, ~month=11, ~day=8)
    {
      from: startDate,
      to: Date.makeWithYMD(~year, ~month=11, ~day=18),
    }
  })

  <Card className="mx-auto w-fit p-0">
    <Card.Content className="p-0">
      <Calendar
        mode=Range
        defaultMonth={range.from}
        selected=range
        onSelect={value => setRange(_ => value)}
        numberOfMonths=1
        captionLayout=Calendar.CaptionLayout.Dropdown
        className="[--cell-size:--spacing(10)] md:[--cell-size:--spacing(12)]"
        formatters={{
          formatMonthDropdown: date =>
            date->Date.toLocaleDateStringWithLocaleAndOptions("default", {month: #long}),
        }}
        components={{
          dayButton: props => {
            let isWeekend = switch props.day.date->Date.getDay {
            | 0 | 6 => true
            | _ => false
            }
            <Calendar.DayButton {...props}>
              {props.children}
              {if props.modifiers.outside->Option.getOr(false) {
                React.null
              } else {
                <span>
                  {if isWeekend {
                    "$120"
                  } else {
                    "$100"
                  }->React.string}
                </span>
              }}
            </Calendar.DayButton>
          },
        }}
      />
    </Card.Content>
  </Card>
}
