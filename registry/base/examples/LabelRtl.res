@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex gap-2" dir="rtl">
    <Checkbox id="terms-rtl" dir="rtl" />
    <Label htmlFor="terms-rtl" dir="rtl">
      {"قبول الشروط والأحكام"->React.string}
    </Label>
  </div>
