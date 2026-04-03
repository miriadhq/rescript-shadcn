@@directive("'use client'")

@module("date-fns")
external formatDate: (Date.t, string) => string = "format"

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (date, setDate) = React.useState(() => None)
  let (isOpen, setOpen) = React.useState(() => false)

  <Field className="mx-auto w-72">
    <Popover open_=isOpen onOpenChange={(nextOpen, _) => setOpen(_ => nextOpen)}>
      <Field.Label htmlFor="date-picker-with-dropdowns-desktop">
        {"Date"->React.string}
      </Field.Label>
      <Popover.Trigger
        render={<Button
          variant=Outline
          id="date-picker-with-dropdowns-desktop"
          className="justify-start px-2.5 font-normal"
          dataSlot="popover-trigger"
        />}
      >
        <Icons.ChevronDown className="ml-auto" />
        {switch date {
        | Some(value) => formatDate(value, "PPP")->React.string
        | None => <span> {"Pick a date"->React.string} </span>
        }}
      </Popover.Trigger>
      <Popover.Content className="w-auto p-0" align=Start>
        <Calendar
          mode=Single
          selected=?date
          onSelect={value => setDate(_ => value)}
          captionLayout=Calendar.CaptionLayout.Dropdown
        />
        <div className="flex gap-2 border-t p-2">
          <Button variant=Outline size=Sm className="w-full" onClick={_ => setOpen(_ => false)}>
            {"Done"->React.string}
          </Button>
        </div>
      </Popover.Content>
    </Popover>
  </Field>
}
