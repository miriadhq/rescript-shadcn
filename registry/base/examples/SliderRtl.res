@@directive("'use client'")

@react.component
let make = () =>
  <Slider defaultValue={[75.]} max={100.} step={1.} className="mx-auto w-full max-w-xs" dir="rtl">
    {React.null}
  </Slider>
