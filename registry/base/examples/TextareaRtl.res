@@directive("'use client'")

@react.component
let make = () =>
  <Field className="w-full max-w-xs" dir="rtl">
    <Field.Label htmlFor="feedback" dir="rtl"> {"التعليقات"->React.string} </Field.Label>
    <Textarea
      id="feedback"
      placeholder="تعليقاتك تساعدنا على التحسين..."
      dir="rtl"
      rows={4}
    />
    <Field.Description dir="rtl">
      {"شاركنا أفكارك حول خدمتنا."->React.string}
    </Field.Description>
  </Field>
