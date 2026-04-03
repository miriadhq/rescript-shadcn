@@directive("'use client'")

@module("date-fns") external format: (Date.t, string) => string = "format"

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (open_, setOpen) = React.useState(() => false)
  let (date, setDate) = React.useState(() => None)

  <Field.Group className="mx-auto max-w-xs flex-row">
    <Field>
      <Field.Label htmlFor="date-picker-optional"> {"Date"->React.string} </Field.Label>
      <Popover open_={open_} onOpenChange={(v, _) => setOpen(_ => v)}>
        <Popover.Trigger
          render={<Button
            variant=Outline id="date-picker-optional" className="w-32 justify-between font-normal"
          />}
        >
          {switch date {
          | Some(d) => d->format("PPP")->React.string
          | None => "Select date"->React.string
          }}
          <Icons.ChevronDown dataIcon="inline-end" />
        </Popover.Trigger>
        <Popover.Content className="w-auto overflow-hidden p-0" align=Start>
          <Calendar
            mode=Single
            selected=?date
            captionLayout={Calendar.CaptionLayout.Dropdown}
            defaultMonth=?{date}
            onSelect={value => {
              setDate(_ => value)
              setOpen(_ => false)
            }}
          />
        </Popover.Content>
      </Popover>
    </Field>
    <Field className="w-32">
      <Field.Label htmlFor="time-picker-optional"> {"Time"->React.string} </Field.Label>
      <Input
        type_="time"
        id="time-picker-optional"
        step={1.}
        defaultValue="10:30:00"
        className="bg-background appearance-none [&::-webkit-calendar-picker-indicator]:hidden [&::-webkit-calendar-picker-indicator]:appearance-none"
      />
    </Field>
  </Field.Group>
}
