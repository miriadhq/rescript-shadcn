@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (showStatusBar, setShowStatusBar) = React.useState(() => true)
  let (showActivityBar, setShowActivityBar) = React.useState(() => false)
  let (showPanel, setShowPanel) = React.useState(() => false)
  let (position, setPosition) = React.useState(() => "bottom")

  <DropdownMenu>
    <DropdownMenu.Trigger
      render={<Button variant=Button.Variant.Outline dataSlot="dropdown-menu-trigger" />}
    >
      {"افتح القائمة"->React.string}
    </DropdownMenu.Trigger>
    <DropdownMenu.Content align=BaseUi.Types.Align.End dir="rtl" dataLang="ar" className="w-36">
      <DropdownMenu.Group>
        <DropdownMenu.Sub>
          <DropdownMenu.SubTrigger> {"الحساب"->React.string} </DropdownMenu.SubTrigger>
          <DropdownMenu.Portal>
            <DropdownMenu.SubContent dir="rtl" dataLang="ar">
              <DropdownMenu.Group>
                <DropdownMenu.Item>
                  <Icons.User />
                  {"الملف الشخصي"->React.string}
                </DropdownMenu.Item>
                <DropdownMenu.Item>
                  <Icons.CreditCard />
                  {"الفوترة"->React.string}
                </DropdownMenu.Item>
                <DropdownMenu.Item>
                  <Icons.Settings />
                  {"الإعدادات"->React.string}
                </DropdownMenu.Item>
              </DropdownMenu.Group>
            </DropdownMenu.SubContent>
          </DropdownMenu.Portal>
        </DropdownMenu.Sub>
      </DropdownMenu.Group>
      <DropdownMenu.Separator />
      <DropdownMenu.Group>
        <DropdownMenu.Label> {"الفريق"->React.string} </DropdownMenu.Label>
        <DropdownMenu.Item> {"الفريق"->React.string} </DropdownMenu.Item>
        <DropdownMenu.Sub>
          <DropdownMenu.SubTrigger>
            {"دعوة المستخدمين"->React.string}
          </DropdownMenu.SubTrigger>
          <DropdownMenu.Portal>
            <DropdownMenu.SubContent dir="rtl" dataLang="ar">
              <DropdownMenu.Item>
                {"البريد الإلكتروني"->React.string}
              </DropdownMenu.Item>
              <DropdownMenu.Item> {"رسالة"->React.string} </DropdownMenu.Item>
              <DropdownMenu.Sub>
                <DropdownMenu.SubTrigger> {"المزيد"->React.string} </DropdownMenu.SubTrigger>
                <DropdownMenu.Portal>
                  <DropdownMenu.SubContent dir="rtl" dataLang="ar">
                    <DropdownMenu.Item> {"تقويم"->React.string} </DropdownMenu.Item>
                    <DropdownMenu.Item> {"دردشة"->React.string} </DropdownMenu.Item>
                    <DropdownMenu.Separator />
                    <DropdownMenu.Item> {"خطاف ويب"->React.string} </DropdownMenu.Item>
                  </DropdownMenu.SubContent>
                </DropdownMenu.Portal>
              </DropdownMenu.Sub>
              <DropdownMenu.Separator />
              <DropdownMenu.Item> {"متقدم..."->React.string} </DropdownMenu.Item>
            </DropdownMenu.SubContent>
          </DropdownMenu.Portal>
        </DropdownMenu.Sub>
        <DropdownMenu.Item>
          {"فريق جديد"->React.string}
          <DropdownMenu.Shortcut> {"⌘+T"->React.string} </DropdownMenu.Shortcut>
        </DropdownMenu.Item>
      </DropdownMenu.Group>
      <DropdownMenu.Separator />
      <DropdownMenu.Group>
        <DropdownMenu.Label> {"عرض"->React.string} </DropdownMenu.Label>
        <DropdownMenu.CheckboxItem
          checked={showStatusBar} onCheckedChange={(v, _) => setShowStatusBar(_ => v)}
        >
          {"شريط الحالة"->React.string}
        </DropdownMenu.CheckboxItem>
        <DropdownMenu.CheckboxItem
          checked={showActivityBar} onCheckedChange={(v, _) => setShowActivityBar(_ => v)}
        >
          {"شريط النشاط"->React.string}
        </DropdownMenu.CheckboxItem>
        <DropdownMenu.CheckboxItem
          checked={showPanel} onCheckedChange={(v, _) => setShowPanel(_ => v)}
        >
          {"اللوحة"->React.string}
        </DropdownMenu.CheckboxItem>
      </DropdownMenu.Group>
      <DropdownMenu.Separator />
      <DropdownMenu.Group>
        <DropdownMenu.Label> {"الموضع"->React.string} </DropdownMenu.Label>
        <DropdownMenu.RadioGroup value={position} onValueChange={(v, _) => setPosition(_ => v)}>
          <DropdownMenu.RadioItem value="top"> {"أعلى"->React.string} </DropdownMenu.RadioItem>
          <DropdownMenu.RadioItem value="bottom">
            {"أسفل"->React.string}
          </DropdownMenu.RadioItem>
          <DropdownMenu.RadioItem value="right">
            {"يمين"->React.string}
          </DropdownMenu.RadioItem>
          <DropdownMenu.RadioItem value="left"> {"يسار"->React.string} </DropdownMenu.RadioItem>
        </DropdownMenu.RadioGroup>
      </DropdownMenu.Group>
      <DropdownMenu.Separator />
      <DropdownMenu.Group>
        <DropdownMenu.Item variant=DropdownMenu.Variant.Destructive>
          {"تسجيل الخروج"->React.string}
        </DropdownMenu.Item>
      </DropdownMenu.Group>
    </DropdownMenu.Content>
  </DropdownMenu>
}
