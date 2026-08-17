@@directive("'use client'")

module IDate = ReactAria.InternationalizedDate

let formatDate = date =>
  date
  ->IDate.toDate(IDate.getLocalTimeZone())
  ->Date.toLocaleDateStringWithLocaleAndOptions("en-US", {dateStyle: #long})

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (date, setDate) = React.useState(() => None)
  let (open_, setOpen) = React.useState(() => false)

  <Field className="mx-auto w-72">
    <Field.Label htmlFor="date-picker-with-dropdowns-desktop"> {"Date"->React.string} </Field.Label>
    <Popover.Trigger isOpen={open_} onOpenChange={open_ => setOpen(_ => open_)}>
      <Button
        variant=Outline
        id="date-picker-with-dropdowns-desktop"
        className="justify-start px-2.5 font-normal"
      >
        <Icons.ChevronDown className="ml-auto" />
        {switch date {
        | Some(date) => date->formatDate->React.string
        | None => <span> {"Pick a date"->React.string} </span>
        }}
      </Button>
      <Popover className="w-auto p-0" placement=ReactAria.Common.Placement.BottomStart>
        <Calendar value=?date onChange={date => setDate(_ => Some(date))} captionLayout=Dropdown />
        <div className="flex gap-2 border-t p-2">
          <Button variant=Outline size=Sm className="w-full" onPress={_ => setOpen(_ => false)}>
            {"Done"->React.string}
          </Button>
        </div>
      </Popover>
    </Popover.Trigger>
  </Field>
}
