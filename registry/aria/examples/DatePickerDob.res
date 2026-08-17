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
    <Field.Label htmlFor="date"> {"Date of birth"->React.string} </Field.Label>
    <Popover.Trigger>
      <Button variant=Outline id="date" className="justify-start font-normal">
        {switch date {
        | Some(date) => date->formatDate->React.string
        | None => "Select date"->React.string
        }}
      </Button>
      <Popover
        className="w-auto overflow-hidden p-0" placement=ReactAria.Common.Placement.BottomStart
      >
        <Calendar
          value=?date
          captionLayout=Calendar.CaptionLayout.Dropdown
          onChange={date => setDate(_ => Some(date))}
        />
      </Popover>
    </Popover.Trigger>
  </Field>
}
