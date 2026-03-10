@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="grid w-full max-w-sm gap-6">
    <InputGroup className="max-w-xs">
      <InputGroup.Input placeholder="بحث..." />
      <InputGroup.Addon>
        <Icons.Search />
      </InputGroup.Addon>
      <InputGroup.Addon align=InlineEnd> {"١٢ نتيجة"->React.string} </InputGroup.Addon>
    </InputGroup>
    <InputGroup>
      <InputGroup.Input placeholder="جاري البحث..." />
      <InputGroup.Addon align=InlineEnd>
        <Spinner />
      </InputGroup.Addon>
    </InputGroup>
    <InputGroup>
      <InputGroup.Input placeholder="جاري حفظ التغييرات..." />
      <InputGroup.Addon align=InlineEnd>
        <InputGroup.Text> {"جاري الحفظ..."->React.string} </InputGroup.Text>
        <Spinner />
      </InputGroup.Addon>
    </InputGroup>
    <Field.Group className="max-w-sm">
      <Field>
        <Field.Label htmlFor="rtl-textarea"> {"منطقة النص"->React.string} </Field.Label>
        <InputGroup>
          <InputGroup.Textarea id="rtl-textarea" placeholder="اكتب تعليقًا..." />
          <InputGroup.Addon align=BlockEnd>
            <InputGroup.Text> {"٠/٢٨٠"->React.string} </InputGroup.Text>
            <InputGroup.Button variant=Default size=Sm className="ms-auto">
              {"نشر"->React.string}
            </InputGroup.Button>
          </InputGroup.Addon>
        </InputGroup>
        <Field.Description>
          {"تذييل موضع أسفل منطقة النص."->React.string}
        </Field.Description>
      </Field>
    </Field.Group>
  </div>
