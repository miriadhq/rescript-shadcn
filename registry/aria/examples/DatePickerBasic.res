@@directive("'use client'")

module IDate = ReactAria.InternationalizedDate

let formatDate = date =>
  date
  ->IDate.toDate(IDate.getLocalTimeZone())
  ->Date.toLocaleDateStringWithLocaleAndOptions(
    "en-US",
    {day: #numeric, month: #long, year: #numeric},
  )

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (date, setDate) = React.useState(() => None)

  <Field className="mx-auto w-44">
    <Field.Label htmlFor="date-picker-simple"> {"Date"->React.string} </Field.Label>
    <Popover.Trigger>
      <Button variant=Outline id="date-picker-simple" className="justify-start font-normal">
        {switch date {
        | Some(date) => date->formatDate->React.string
        | None => <span> {"Pick a date"->React.string} </span>
        }}
      </Button>
      <Popover className="w-auto p-0" placement=ReactAria.Common.BottomStart>
        <Calendar value=?date onChange={date => setDate(_ => Some(date))} />
      </Popover>
    </Popover.Trigger>
  </Field>
}
