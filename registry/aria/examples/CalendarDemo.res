@@directive("'use client'")

module IDate = ReactAria.InternationalizedDate

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (date, setDate) = React.useState(() => IDate.today(IDate.getLocalTimeZone()))

  <Calendar
    value=date
    onChange={date => setDate(_ => date)}
    className="rounded-lg border"
    captionLayout=Dropdown
  />
}
