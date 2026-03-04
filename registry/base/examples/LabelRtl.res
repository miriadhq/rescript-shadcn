@@directive("'use client'")

@react.component
let make = () =>
  <div className="flex gap-2" dir="rtl">
    <Checkbox id="terms-rtl" dir="rtl" />
    <Label htmlFor="terms-rtl" dir="rtl">
      {"قبول الشروط والأحكام"->React.string}
    </Label>
  </div>
