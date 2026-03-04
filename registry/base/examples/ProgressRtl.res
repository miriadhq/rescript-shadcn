@@directive("'use client'")

@react.component
let make = () =>
  <Progress value={56.} className="w-full max-w-sm" dir="rtl">
    <Progress.Label> {"تقدم الرفع"->React.string} </Progress.Label>
    <Progress.Value />
  </Progress>
