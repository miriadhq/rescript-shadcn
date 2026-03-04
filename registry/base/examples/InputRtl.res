@@directive("'use client'")

@react.component
let make = () =>
  <Field dir="rtl">
    <Field.Label htmlFor="input-rtl-api-key"> {"مفتاح API"->React.string} </Field.Label>
    <Input id="input-rtl-api-key" type_="password" placeholder="sk-..." />
    <Field.Description>
      {"مفتاح API الخاص بك مشفر ومخزن بأمان."->React.string}
    </Field.Description>
  </Field>
