@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Calendar captionLayout=Calendar.CaptionLayout.Dropdown className="rounded-lg border" />
