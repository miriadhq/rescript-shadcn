@@directive("'use client'")

@module("date-fns") external format: (Date.t, string) => string = "format"

@react.component
let make = () => {
  let (date, setDate) = React.useState(() => None)

  <Field className="mx-auto w-44">
    <Field.Label htmlFor="date-picker-simple"> {"Date"->React.string} </Field.Label>
    <Popover>
      <Popover.Trigger
        render={<Button
          variant=Button.Variant.Outline
          id="date-picker-simple"
          className="justify-start font-normal"
        />}
      >
        {switch date {
        | Some(d) => d->format("PPP")->React.string
        | None => <span> {"Pick a date"->React.string} </span>
        }}
      </Popover.Trigger>
      <Popover.Content className="w-auto p-0" align=BaseUi.Types.Align.Start>
        <Calendar
          mode="single"
          selected={date}
          onSelect={(value: option<Date.t>) => setDate(_ => value)}
          defaultMonth=?{date}
        />
      </Popover.Content>
    </Popover>
  </Field>
}
