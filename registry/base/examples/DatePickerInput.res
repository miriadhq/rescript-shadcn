@@directive("'use client'")

let formatDate = (date: option<Date.t>) =>
  switch date {
  | None => ""
  | Some(d) =>
    d->Date.toLocaleDateStringWithLocaleAndOptions(
      "en-US",
      {day: #"2-digit", month: #long, year: #numeric},
    )
  }

let isValidDate = (d: Date.t) => {
  let t = d->Date.getTime
  !Float.isNaN(t)
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (open_, setOpen) = React.useState(() => false)
  let initialDate = Some(Date.fromString("2025-06-01"))
  let (date, setDate) = React.useState(() => initialDate)
  let (month, setMonth) = React.useState(() => initialDate->Option.getOr(Date.make()))
  let (value, setValue) = React.useState(() => formatDate(initialDate))

  <Field className="mx-auto w-48">
    <Field.Label htmlFor="date-required"> {"Subscription Date"->React.string} </Field.Label>
    <InputGroup>
      <InputGroup.Input
        id="date-required"
        value={value}
        placeholder="June 01, 2025"
        onValueChange={(v, _) => {
          let parsed = Date.fromString(v)
          setValue(_ => v)
          if parsed->isValidDate {
            setDate(_ => Some(parsed))
            setMonth(_ => parsed)
          }
        }}
      />
      <InputGroup.Addon align=InlineEnd>
        <Popover open_={open_} onOpenChange={(v, _) => setOpen(_ => v)}>
          <Popover.Trigger
            render={<InputGroup.Button
              id="date-picker" ariaLabel="Select date" variant=Ghost size=IconXs
            />}
          >
            <Icons.Calendar />
            <span className="sr-only"> {"Select date"->React.string} </span>
          </Popover.Trigger>
          <Popover.Content
            className="w-auto overflow-hidden p-0" align=End alignOffset={-8.} sideOffset={10.}
          >
            <Calendar
              mode=Single
              selected=?{date}
              month={month}
              onMonthChange={(d: Date.t) => setMonth(_ => d)}
              onSelect={value => {
                setDate(_ => value)
                setValue(_ => formatDate(value))
                setOpen(_ => false)
              }}
            />
          </Popover.Content>
        </Popover>
      </InputGroup.Addon>
    </InputGroup>
  </Field>
}
