@@directive("'use client'")

@react.component
let make = () =>
  <Calendar
    mode=Single captionLayout=Calendar.CaptionLayout.Dropdown className="rounded-lg border"
  />
