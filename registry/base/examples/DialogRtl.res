@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Dialog>
    <form>
      <Dialog.Trigger render={<Button variant=Button.Variant.Outline dataSlot="dialog-trigger" />}>
        {"فتح الحوار"->React.string}
      </Dialog.Trigger>
      <Dialog.Content className="sm:max-w-sm" dir="rtl" dataLang="ar">
        <Dialog.Header>
          <Dialog.Title> {"تعديل الملف الشخصي"->React.string} </Dialog.Title>
          <Dialog.Description>
            {"قم بإجراء تغييرات على ملفك الشخصي هنا. انقر فوق حفظ عند الانتهاء."->React.string}
          </Dialog.Description>
        </Dialog.Header>
        <Field.Group>
          <Field>
            <Label htmlFor="name-1"> {"الاسم"->React.string} </Label>
            <Input id="name-1" name="name" defaultValue="Pedro Duarte" />
          </Field>
          <Field>
            <Label htmlFor="username-1"> {"اسم المستخدم"->React.string} </Label>
            <Input id="username-1" name="username" defaultValue="@peduarte" />
          </Field>
        </Field.Group>
        <Dialog.Footer>
          <Dialog.Close render={<Button variant=Button.Variant.Outline dataSlot="dialog-close" />}>
            {"إلغاء"->React.string}
          </Dialog.Close>
          <Button type_="submit"> {"حفظ التغييرات"->React.string} </Button>
        </Dialog.Footer>
      </Dialog.Content>
    </form>
  </Dialog>
