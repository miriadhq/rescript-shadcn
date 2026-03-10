@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Sheet>
    <Sheet.Trigger render={<Button variant=Button.Variant.Outline />}>
      {"فتح"->React.string}
    </Sheet.Trigger>
    <Sheet.Content dir="rtl" side=BaseUi.Types.Side.Left>
      <Sheet.Header>
        <Sheet.Title> {"تعديل الملف الشخصي"->React.string} </Sheet.Title>
        <Sheet.Description>
          {"قم بإجراء تغييرات على ملفك الشخصي هنا. انقر حفظ عند الانتهاء."->React.string}
        </Sheet.Description>
      </Sheet.Header>
      <Field.Group className="px-4">
        <Field>
          <Field.Label htmlFor="sheet-rtl-name"> {"الاسم"->React.string} </Field.Label>
          <Input id="sheet-rtl-name" defaultValue="Pedro Duarte" />
        </Field>
        <Field>
          <Field.Label htmlFor="sheet-rtl-username">
            {"اسم المستخدم"->React.string}
          </Field.Label>
          <Input id="sheet-rtl-username" defaultValue="peduarte" />
        </Field>
      </Field.Group>
      <Sheet.Footer>
        <Button type_="submit"> {"حفظ التغييرات"->React.string} </Button>
        <Sheet.Close render={<Button variant=Button.Variant.Outline />}>
          {"إغلاق"->React.string}
        </Sheet.Close>
      </Sheet.Footer>
    </Sheet.Content>
  </Sheet>
