@@directive("'use client'")

@react.component
let make = () => {
  let (people, setPeople) = React.useState(() => "pedro")

  <ContextMenu>
    <ContextMenu.Trigger
      className="flex aspect-video w-full max-w-xs items-center justify-center rounded-xl border border-dashed text-sm"
    >
      <span className="hidden pointer-fine:inline-block">
        {"انقر بزر الماوس الأيمن هنا"->React.string}
      </span>
      <span className="hidden pointer-coarse:inline-block">
        {"اضغط مطولاً هنا"->React.string}
      </span>
    </ContextMenu.Trigger>
    <ContextMenu.Content className="w-48" dir="rtl" dataLang="ar">
      <ContextMenu.Group>
        <ContextMenu.Sub>
          <ContextMenu.SubTrigger> {"التنقل"->React.string} </ContextMenu.SubTrigger>
          <ContextMenu.SubContent className="w-44" dir="rtl" dataLang="ar">
            <ContextMenu.Group>
              <ContextMenu.Item>
                <Icons.ArrowLeft />
                {"رجوع"->React.string}
                <ContextMenu.Shortcut> {"\u2318["->React.string} </ContextMenu.Shortcut>
              </ContextMenu.Item>
              <ContextMenu.Item disabled={true}>
                <Icons.ArrowRight />
                {"تقدم"->React.string}
                <ContextMenu.Shortcut> {"\u2318]"->React.string} </ContextMenu.Shortcut>
              </ContextMenu.Item>
              <ContextMenu.Item>
                <Icons.RotateCw />
                {"إعادة تحميل"->React.string}
                <ContextMenu.Shortcut> {"\u2318R"->React.string} </ContextMenu.Shortcut>
              </ContextMenu.Item>
            </ContextMenu.Group>
          </ContextMenu.SubContent>
        </ContextMenu.Sub>
        <ContextMenu.Sub>
          <ContextMenu.SubTrigger>
            {"المزيد من الأدوات"->React.string}
          </ContextMenu.SubTrigger>
          <ContextMenu.SubContent className="w-44" dir="rtl" dataLang="ar">
            <ContextMenu.Group>
              <ContextMenu.Item> {"حفظ الصفحة..."->React.string} </ContextMenu.Item>
              <ContextMenu.Item> {"إنشاء اختصار..."->React.string} </ContextMenu.Item>
              <ContextMenu.Item> {"تسمية النافذة..."->React.string} </ContextMenu.Item>
            </ContextMenu.Group>
            <ContextMenu.Separator />
            <ContextMenu.Group>
              <ContextMenu.Item> {"أدوات المطور"->React.string} </ContextMenu.Item>
            </ContextMenu.Group>
            <ContextMenu.Separator />
            <ContextMenu.Group>
              <ContextMenu.Item variant=ContextMenu.Variant.Destructive>
                {"حذف"->React.string}
              </ContextMenu.Item>
            </ContextMenu.Group>
          </ContextMenu.SubContent>
        </ContextMenu.Sub>
      </ContextMenu.Group>
      <ContextMenu.Separator />
      <ContextMenu.Group>
        <ContextMenu.CheckboxItem checked={BaseUi.Types.CheckedState.Checked(true)}>
          {"إظهار الإشارات المرجعية"->React.string}
        </ContextMenu.CheckboxItem>
        <ContextMenu.CheckboxItem>
          {"إظهار عناوين URL الكاملة"->React.string}
        </ContextMenu.CheckboxItem>
      </ContextMenu.Group>
      <ContextMenu.Separator />
      <ContextMenu.Group>
        <ContextMenu.RadioGroup value={people} onValueChange={(v, _) => setPeople(_ => v)}>
          <ContextMenu.Label> {"الأشخاص"->React.string} </ContextMenu.Label>
          <ContextMenu.RadioItem value="pedro">
            {"Pedro Duarte"->React.string}
          </ContextMenu.RadioItem>
          <ContextMenu.RadioItem value="colm"> {"Colm Tuite"->React.string} </ContextMenu.RadioItem>
        </ContextMenu.RadioGroup>
      </ContextMenu.Group>
    </ContextMenu.Content>
  </ContextMenu>
}
