@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Calendar
    mode=Single captionLayout=Calendar.CaptionLayout.Dropdown className="rounded-lg border"
  />
