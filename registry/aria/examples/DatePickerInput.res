@@directive("'use client'")

module IDate = ReactAria.InternationalizedDate

let formatDate = date =>
  date
  ->IDate.toDate(IDate.getLocalTimeZone())
  ->Date.toLocaleDateStringWithLocaleAndOptions(
    "en-US",
    {day: #"2-digit", month: #long, year: #numeric},
  )

let isValidDate = date => !(date->Date.getTime->Float.isNaN)

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (open_, setOpen) = React.useState(() => false)
  let initialDate = IDate.parseDate("2025-06-01")
  let (date, setDate) = React.useState(() => Some(initialDate))
  let (month, setMonth) = React.useState(() => initialDate)
  let (value, setValue) = React.useState(() => initialDate->formatDate)

  <Field className="mx-auto w-48">
    <Field.Label htmlFor="date-required"> {"Subscription Date"->React.string} </Field.Label>
    <InputGroup>
      <InputGroup.Input
        id="date-required"
        value
        placeholder="June 01, 2025"
        onChange={value => {
          let parsed = Date.fromString(value)
          setValue(_ => value)
          if parsed->isValidDate {
            let calendarDate =
              parsed->IDate.fromDate(IDate.getLocalTimeZone())->IDate.toCalendarDate
            setDate(_ => Some(calendarDate))
            setMonth(_ => calendarDate)
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
          <InputGroup.Button id="date-picker" variant=Ghost size=IconXs ariaLabel="Select date">
            <Icons.Calendar />
            <span className="sr-only"> {"Select date"->React.string} </span>
          </InputGroup.Button>
          <Popover
            className="w-auto overflow-hidden p-0"
            placement=ReactAria.Common.Placement.BottomEnd
            crossOffset={-8.}
            offset=10.
          >
            <Calendar
              value=?date
              focusedValue=month
              onFocusChange={month => setMonth(_ => month)}
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
  </Field>
}
