@@directive("'use client'")

module IDate = ReactAria.InternationalizedDate

@module("chrono-node") external parseNaturalLanguage: string => nullable<Date.t> = "parseDate"

let parseDate = value =>
  value
  ->parseNaturalLanguage
  ->Nullable.map(date => date->IDate.fromDate(IDate.getLocalTimeZone())->IDate.toCalendarDate)
  ->Nullable.toOption

let formatDate = date =>
  date
  ->IDate.toDate(IDate.getLocalTimeZone())
  ->Date.toLocaleDateStringWithLocaleAndOptions(
    "en-US",
    {day: #"2-digit", month: #long, year: #numeric},
  )

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (open_, setOpen) = React.useState(() => false)
  let (value, setValue) = React.useState(() => "In 2 days")
  let (date, setDate) = React.useState(() => value->parseDate)

  <Field className="mx-auto max-w-xs">
    <Field.Label htmlFor="date-optional"> {"Schedule Date"->React.string} </Field.Label>
    <InputGroup>
      <InputGroup.Input
        id="date-optional"
        value
        placeholder="Tomorrow or next week"
        onChange={value => {
          setValue(_ => value)
          switch value->parseDate {
          | Some(date) => setDate(_ => Some(date))
          | None => ()
          }
        }}
        onKeyDown={event =>
          if event->ReactEvent.Keyboard.key == "ArrowDown" {
            event->ReactEvent.Keyboard.preventDefault
            setOpen(_ => true)
          }}
      />
      <InputGroup.Addon align=InlineEnd>
        <Popover.Trigger isOpen={open_} onOpenChange={open_ => setOpen(_ => open_)}>
          <InputGroup.Button
            id="date-picker" variant=Ghost size=IconXs ariaLabel="Select date"
          >
            <Icons.Calendar />
            <span className="sr-only"> {"Select date"->React.string} </span>
          </InputGroup.Button>
          <Popover
            className="w-auto overflow-hidden p-0"
            placement=ReactAria.Common.BottomEnd
            offset=8.
          >
            <Calendar
              value=?date
              captionLayout=Dropdown
              onChange={date => {
                setDate(_ => Some(date))
                setValue(_ => date->formatDate)
                setOpen(_ => false)
              }}
            />
          </Popover>
        </Popover.Trigger>
      </InputGroup.Addon>
    </InputGroup>
    <div className="px-1 text-sm text-muted-foreground">
      {"Your post will be published on "->React.string}
      <span className="font-medium">
        {date->Option.mapOr("", formatDate)->React.string}
      </span>
      {"."->React.string}
    </div>
  </Field>
}
