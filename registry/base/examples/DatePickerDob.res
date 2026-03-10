@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (open_, setOpen) = React.useState(() => false)
  let (date, setDate) = React.useState(() => None)

  <Field className="mx-auto w-44">
    <Field.Label htmlFor="date"> {"Date of birth"->React.string} </Field.Label>
    <Popover open_={open_} onOpenChange={(v, _) => setOpen(_ => v)}>
      <Popover.Trigger
        render={<Button
          variant=Button.Variant.Outline id="date" className="justify-start font-normal"
        />}
      >
        {switch date {
        | Some(d) => d->Date.toLocaleDateString->React.string
        | None => "Select date"->React.string
        }}
      </Popover.Trigger>
      <Popover.Content className="w-auto overflow-hidden p-0" align=BaseUi.Types.Align.Start>
        <Calendar
          mode=Single
          selected={date}
          defaultMonth=?{date}
          captionLayout={Calendar.CaptionLayout.Dropdown}
          onSelect={(value: option<Date.t>) => {
            setDate(_ => value)
            setOpen(_ => false)
          }}
        />
      </Popover.Content>
    </Popover>
  </Field>
}
