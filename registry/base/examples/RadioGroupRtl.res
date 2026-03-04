@@directive("'use client'")

@react.component
let make = () =>
  <RadioGroup defaultValue="comfortable" className="w-fit" dir="rtl">
    <Field orientation=BaseUi.Types.Orientation.Horizontal>
      <RadioGroup.Item value="default" id="r1-rtl" dir="rtl" />
      <Field.Content>
        <Field.Label htmlFor="r1-rtl" dir="rtl"> {"افتراضي"->React.string} </Field.Label>
        <Field.Description dir="rtl">
          {"تباعد قياسي لمعظم حالات الاستخدام."->React.string}
        </Field.Description>
      </Field.Content>
    </Field>
    <Field orientation=BaseUi.Types.Orientation.Horizontal>
      <RadioGroup.Item value="comfortable" id="r2-rtl" dir="rtl" />
      <Field.Content>
        <Field.Label htmlFor="r2-rtl" dir="rtl"> {"مريح"->React.string} </Field.Label>
        <Field.Description dir="rtl">
          {"مساحة أكبر بين العناصر."->React.string}
        </Field.Description>
      </Field.Content>
    </Field>
    <Field orientation=BaseUi.Types.Orientation.Horizontal>
      <RadioGroup.Item value="compact" id="r3-rtl" dir="rtl" />
      <Field.Content>
        <Field.Label htmlFor="r3-rtl" dir="rtl"> {"مضغوط"->React.string} </Field.Label>
        <Field.Description dir="rtl">
          {"تباعد أدنى للتخطيطات الكثيفة."->React.string}
        </Field.Description>
      </Field.Content>
    </Field>
  </RadioGroup>
