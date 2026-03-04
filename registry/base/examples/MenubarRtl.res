@@directive("'use client'")

@react.component
let make = () => {
  let (profile, setProfile) = React.useState(() => "benoit")

  <Menubar className="w-72" dir="rtl">
    <Menubar.Menu>
      <Menubar.Trigger> {"ملف"->React.string} </Menubar.Trigger>
      <Menubar.Content dir="rtl" align=BaseUi.Types.Align.End>
        <Menubar.Group>
          <Menubar.Item>
            {"علامة تبويب جديدة"->React.string}
            <Menubar.Shortcut> {"⌘T"->React.string} </Menubar.Shortcut>
          </Menubar.Item>
          <Menubar.Item>
            {"نافذة جديدة"->React.string}
            <Menubar.Shortcut> {"⌘N"->React.string} </Menubar.Shortcut>
          </Menubar.Item>
          <Menubar.Item disabled=true>
            {"نافذة التصفح المتخفي الجديدة"->React.string}
          </Menubar.Item>
        </Menubar.Group>
        <Menubar.Separator />
        <Menubar.Group>
          <Menubar.Sub>
            <Menubar.SubTrigger> {"مشاركة"->React.string} </Menubar.SubTrigger>
            <Menubar.SubContent dir="rtl" dataLang="ar">
              <Menubar.Group>
                <Menubar.Item>
                  {"رابط البريد الإلكتروني"->React.string}
                </Menubar.Item>
                <Menubar.Item> {"الرسائل"->React.string} </Menubar.Item>
                <Menubar.Item> {"الملاحظات"->React.string} </Menubar.Item>
              </Menubar.Group>
            </Menubar.SubContent>
          </Menubar.Sub>
        </Menubar.Group>
        <Menubar.Separator />
        <Menubar.Group>
          <Menubar.Item>
            {"طباعة..."->React.string}
            <Menubar.Shortcut> {"⌘P"->React.string} </Menubar.Shortcut>
          </Menubar.Item>
        </Menubar.Group>
      </Menubar.Content>
    </Menubar.Menu>
    <Menubar.Menu>
      <Menubar.Trigger> {"تعديل"->React.string} </Menubar.Trigger>
      <Menubar.Content dir="rtl" align=BaseUi.Types.Align.End dataLang="ar">
        <Menubar.Group>
          <Menubar.Item>
            {"تراجع"->React.string}
            <Menubar.Shortcut> {"⌘Z"->React.string} </Menubar.Shortcut>
          </Menubar.Item>
          <Menubar.Item>
            {"إعادة"->React.string}
            <Menubar.Shortcut> {"⇧⌘Z"->React.string} </Menubar.Shortcut>
          </Menubar.Item>
        </Menubar.Group>
        <Menubar.Separator />
        <Menubar.Group>
          <Menubar.Sub>
            <Menubar.SubTrigger> {"بحث"->React.string} </Menubar.SubTrigger>
            <Menubar.SubContent dir="rtl" dataLang="ar">
              <Menubar.Group>
                <Menubar.Item> {"البحث على الويب"->React.string} </Menubar.Item>
              </Menubar.Group>
              <Menubar.Separator />
              <Menubar.Group>
                <Menubar.Item> {"بحث..."->React.string} </Menubar.Item>
                <Menubar.Item> {"البحث التالي"->React.string} </Menubar.Item>
                <Menubar.Item> {"البحث السابق"->React.string} </Menubar.Item>
              </Menubar.Group>
            </Menubar.SubContent>
          </Menubar.Sub>
        </Menubar.Group>
        <Menubar.Separator />
        <Menubar.Group>
          <Menubar.Item> {"قص"->React.string} </Menubar.Item>
          <Menubar.Item> {"نسخ"->React.string} </Menubar.Item>
          <Menubar.Item> {"لصق"->React.string} </Menubar.Item>
        </Menubar.Group>
      </Menubar.Content>
    </Menubar.Menu>
    <Menubar.Menu>
      <Menubar.Trigger> {"عرض"->React.string} </Menubar.Trigger>
      <Menubar.Content className="w-44" dir="rtl" align=BaseUi.Types.Align.End dataLang="ar">
        <Menubar.Group>
          <Menubar.CheckboxItem>
            {"شريط الإشارات المرجعية"->React.string}
          </Menubar.CheckboxItem>
          <Menubar.CheckboxItem checked=true>
            {"عناوين URL الكاملة"->React.string}
          </Menubar.CheckboxItem>
        </Menubar.Group>
        <Menubar.Separator />
        <Menubar.Group>
          <Menubar.Item inset=true>
            {"إعادة تحميل"->React.string}
            <Menubar.Shortcut> {"⌘R"->React.string} </Menubar.Shortcut>
          </Menubar.Item>
          <Menubar.Item disabled=true inset=true>
            {"إعادة تحميل قسري"->React.string}
            <Menubar.Shortcut> {"⇧⌘R"->React.string} </Menubar.Shortcut>
          </Menubar.Item>
        </Menubar.Group>
        <Menubar.Separator />
        <Menubar.Group>
          <Menubar.Item inset=true>
            {"تبديل وضع ملء الشاشة"->React.string}
          </Menubar.Item>
        </Menubar.Group>
        <Menubar.Separator />
        <Menubar.Group>
          <Menubar.Item inset=true>
            {"إخفاء الشريط الجانبي"->React.string}
          </Menubar.Item>
        </Menubar.Group>
      </Menubar.Content>
    </Menubar.Menu>
    <Menubar.Menu>
      <Menubar.Trigger> {"الملفات الشخصية"->React.string} </Menubar.Trigger>
      <Menubar.Content dir="rtl" align=BaseUi.Types.Align.End dataLang="ar">
        <Menubar.RadioGroup value={profile} onValueChange={(v, _) => setProfile(_ => v)}>
          <Menubar.RadioItem value="andy"> {"Andy"->React.string} </Menubar.RadioItem>
          <Menubar.RadioItem value="benoit"> {"Benoit"->React.string} </Menubar.RadioItem>
          <Menubar.RadioItem value="Luis"> {"Luis"->React.string} </Menubar.RadioItem>
        </Menubar.RadioGroup>
        <Menubar.Separator />
        <Menubar.Group>
          <Menubar.Item inset=true> {"تعديل..."->React.string} </Menubar.Item>
        </Menubar.Group>
        <Menubar.Separator />
        <Menubar.Group>
          <Menubar.Item inset=true> {"إضافة ملف شخصي..."->React.string} </Menubar.Item>
        </Menubar.Group>
      </Menubar.Content>
    </Menubar.Menu>
  </Menubar>
}
