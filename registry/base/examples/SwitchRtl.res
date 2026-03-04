@@directive("'use client'")

@react.component
let make = () =>
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
