@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Command className="max-w-sm rounded-lg border" dir="rtl">
    <Command.Input placeholder="اكتب أمرًا أو ابحث..." dir="rtl" />
    <Command.List>
      <Command.Empty> {"لم يتم العثور على نتائج."->React.string} </Command.Empty>
      <Command.Group heading="اقتراحات">
        <Command.Item>
          <Icons.Calendar />
          <span> {"التقويم"->React.string} </span>
        </Command.Item>
        <Command.Item>
          <Icons.Smile />
          <span> {"البحث عن الرموز التعبيرية"->React.string} </span>
        </Command.Item>
        <Command.Item disabled={true}>
          <Icons.Calculator />
          <span> {"الآلة الحاسبة"->React.string} </span>
        </Command.Item>
      </Command.Group>
      <Command.Separator />
      <Command.Group heading="الإعدادات">
        <Command.Item>
          <Icons.User />
          <span> {"الملف الشخصي"->React.string} </span>
          <Command.Shortcut> {"⌘P"->React.string} </Command.Shortcut>
        </Command.Item>
        <Command.Item>
          <Icons.CreditCard />
          <span> {"الفوترة"->React.string} </span>
          <Command.Shortcut> {"⌘B"->React.string} </Command.Shortcut>
        </Command.Item>
        <Command.Item>
          <Icons.Settings />
          <span> {"الإعدادات"->React.string} </span>
          <Command.Shortcut> {"⌘S"->React.string} </Command.Shortcut>
        </Command.Item>
      </Command.Group>
    </Command.List>
  </Command>
