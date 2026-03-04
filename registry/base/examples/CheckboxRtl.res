@@directive("'use client'")

@react.component
let make = () =>
  <Field.Group className="max-w-sm" dir="rtl">
    <Field orientation=BaseUi.Types.Orientation.Horizontal>
      <Checkbox id="terms-checkbox-rtl" name="terms-checkbox" />
      <Label htmlFor="terms-checkbox-rtl">
        {"قبول الشروط والأحكام"->React.string}
      </Label>
    </Field>
    <Field orientation=BaseUi.Types.Orientation.Horizontal>
      <Checkbox id="terms-checkbox-2-rtl" name="terms-checkbox-2" defaultChecked={true} />
      <Field.Content>
        <Field.Label htmlFor="terms-checkbox-2-rtl">
          {"قبول الشروط والأحكام"->React.string}
        </Field.Label>
        <Field.Description>
          {"بالنقر على هذا المربع، فإنك توافق على الشروط."->React.string}
        </Field.Description>
      </Field.Content>
    </Field>
    <Field orientation=BaseUi.Types.Orientation.Horizontal dataDisabled={true}>
      <Checkbox id="toggle-checkbox-rtl" name="toggle-checkbox" disabled={true} />
      <Field.Label htmlFor="toggle-checkbox-rtl">
        {"تفعيل الإشعارات"->React.string}
      </Field.Label>
    </Field>
    <Field.Label>
      <Field orientation=BaseUi.Types.Orientation.Horizontal>
        <Checkbox id="toggle-checkbox-2" name="toggle-checkbox-2" />
        <Field.Content>
          <Field.Title> {"تفعيل الإشعارات"->React.string} </Field.Title>
          <Field.Description>
            {"يمكنك تفعيل أو إلغاء تفعيل الإشعارات في أي وقت."->React.string}
          </Field.Description>
        </Field.Content>
      </Field>
    </Field.Label>
  </Field.Group>
