@@directive("'use client'")

module IDate = ReactAria.InternationalizedDate

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (open_, setOpen) = React.useState(() => false)
  let (date, setDate) = React.useState(() => None)

  <Field.Group className="mx-auto max-w-xs flex-row">
    <Field>
      <Field.Label htmlFor="date-picker-optional"> {"Date"->React.string} </Field.Label>
      <Popover.Trigger isOpen={open_} onOpenChange={open_ => setOpen(_ => open_)}>
        <Button
          variant=Outline id="date-picker-optional" className="w-32 justify-between font-normal"
        >
          {switch date {
          | Some(date) =>
            date
            ->IDate.toDate(IDate.getLocalTimeZone())
            ->Date.toLocaleDateString
            ->React.string
          | None => "Select date"->React.string
          }}
          <Icons.ChevronDown dataIcon="inline-end" />
        </Button>
        <Popover
          className="w-auto overflow-hidden p-0" placement=ReactAria.Common.Placement.BottomStart
        >
          <Calendar
            value=?date
            captionLayout=Dropdown
            onChange={date => {
              setDate(_ => Some(date))
              setOpen(_ => false)
            }}
          />
        </Popover>
      </Popover.Trigger>
    </Field>
    <Field className="w-32">
      <Field.Label htmlFor="time-picker-optional"> {"Time"->React.string} </Field.Label>
      <Input
        type_="time"
        id="time-picker-optional"
        step=1.
        defaultValue="10:30:00"
        className="appearance-none bg-background [&::-webkit-calendar-picker-indicator]:hidden [&::-webkit-calendar-picker-indicator]:appearance-none"
      />
    </Field>
  </Field.Group>
}
