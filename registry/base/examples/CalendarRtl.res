@@directive("'use client'")

@module("react-day-picker/locale")
external arSA: Calendar.Locale.t = "arSA"

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (date, setDate) = React.useState(() => Some(Date.make()))

  <Calendar
    mode=Single
    selected=?date
    onSelect={d => setDate(_ => Some(d))}
    className="rounded-lg border [--cell-size:--spacing(9)]"
    captionLayout=Calendar.CaptionLayout.Dropdown
    dir="rtl"
    locale=arSA
  />
}
