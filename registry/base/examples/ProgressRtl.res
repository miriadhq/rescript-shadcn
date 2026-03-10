@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Progress value={56.} className="w-full max-w-sm" dir="rtl">
    <Progress.Label> {"تقدم الرفع"->React.string} </Progress.Label>
    <Progress.Value />
  </Progress>
