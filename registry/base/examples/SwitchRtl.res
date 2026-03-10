@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field orientation=BaseUi.Types.Orientation.Horizontal className="max-w-sm" dir="rtl">
    <Field.Content>
      <Field.Label htmlFor="switch-focus-mode-rtl" dir="rtl">
        {"المشاركة عبر الأجهزة"->React.string}
      </Field.Label>
      <Field.Description dir="rtl">
        {"يتم مشاركة التركيز عبر الأجهزة، ويتم إيقاف تشغيله عند مغادرة التطبيق."->React.string}
      </Field.Description>
    </Field.Content>
    <Switch id="switch-focus-mode-rtl" dir="rtl" />
  </Field>
