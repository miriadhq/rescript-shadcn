@@directive("'use client'")

type componentInfo = {
  title: string,
  href: string,
  description: string,
}

let components: array<componentInfo> = [
  {
    title: "حوار التنبيه",
    href: "/docs/primitives/alert-dialog",
    description: "حوار نافذة يقطع المستخدم بمحتوى مهم ويتوقع استجابة.",
  },
  {
    title: "بطاقة التحويم",
    href: "/docs/primitives/hover-card",
    description: "للمستخدمين المبصرين لمعاينة المحتوى المتاح خلف الرابط.",
  },
  {
    title: "التقدم",
    href: "/docs/primitives/progress",
    description: "يعرض مؤشرًا يوضح تقدم إتمام المهمة، عادةً يتم عرضه كشريط تقدم.",
  },
  {
    title: "منطقة التمرير",
    href: "/docs/primitives/scroll-area",
    description: "يفصل المحتوى بصريًا أو دلاليًا.",
  },
  {
    title: "التبويبات",
    href: "/docs/primitives/tabs",
    description: "مجموعة من أقسام المحتوى المتعددة الطبقات—المعروفة بألواح التبويب—التي يتم عرضها واحدة في كل مرة.",
  },
  {
    title: "تلميح",
    href: "/docs/primitives/tooltip",
    description: "نافذة منبثقة تعرض معلومات متعلقة بعنصر عندما يتلقى العنصر التركيز على لوحة المفاتيح أو عند تحويم الماوس فوقه.",
  },
]

module ListItem = RtlNavigationMenu.ListItem

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <NavigationMenu dir="rtl" align=BaseUi.Types.Align.End>
    <NavigationMenu.List>
      <NavigationMenu.Item>
        <NavigationMenu.Trigger> {"البدء"->React.string} </NavigationMenu.Trigger>
        <NavigationMenu.Content dir="rtl" dataLang="ar">
          <ul className="w-96">
            <ListItem title="مقدمة" href="/docs">
              {"مكونات قابلة لإعادة الاستخدام مبنية باستخدام Tailwind CSS."->React.string}
            </ListItem>
            <ListItem title="التثبيت" href="/docs/installation">
              {"كيفية تثبيت التبعيات وتنظيم تطبيقك."->React.string}
            </ListItem>
            <ListItem title="الطباعة" href="/docs/primitives/typography">
              {"أنماط للعناوين والفقرات والقوائم...إلخ"->React.string}
            </ListItem>
          </ul>
        </NavigationMenu.Content>
      </NavigationMenu.Item>
      <NavigationMenu.Item className="hidden md:flex">
        <NavigationMenu.Trigger> {"المكونات"->React.string} </NavigationMenu.Trigger>
        <NavigationMenu.Content dir="rtl" dataLang="ar">
          <ul className="grid w-[400px] gap-2 md:w-[500px] md:grid-cols-2 lg:w-[600px]">
            {components
            ->Array.map(component =>
              <ListItem key={component.title} title={component.title} href={component.href}>
                {component.description->React.string}
              </ListItem>
            )
            ->React.array}
          </ul>
        </NavigationMenu.Content>
      </NavigationMenu.Item>
      <NavigationMenu.Item>
        <NavigationMenu.Trigger> {"مع أيقونة"->React.string} </NavigationMenu.Trigger>
        <NavigationMenu.Content dir="rtl" dataLang="ar">
          <ul className="grid w-[200px]">
            <li>
              <NavigationMenu.Link
                render={<Next.Link href="#" className="flex-row items-center gap-2" />}
              >
                <Icons.CircleAlert />
                {"قائمة الانتظار"->React.string}
              </NavigationMenu.Link>
              <NavigationMenu.Link
                render={<Next.Link href="#" className="flex-row items-center gap-2" />}
              >
                <Icons.CircleDashed />
                {"المهام"->React.string}
              </NavigationMenu.Link>
              <NavigationMenu.Link
                render={<Next.Link href="#" className="flex-row items-center gap-2" />}
              >
                <Icons.CircleCheck />
                {"منجز"->React.string}
              </NavigationMenu.Link>
            </li>
          </ul>
        </NavigationMenu.Content>
      </NavigationMenu.Item>
      <NavigationMenu.Item>
        <NavigationMenu.Link
          render={<Next.Link href="/docs" />}
          className={NavigationMenu.navigationMenuTriggerStyle()}
          dataLang="ar"
        >
          {"الوثائق"->React.string}
        </NavigationMenu.Link>
      </NavigationMenu.Item>
    </NavigationMenu.List>
  </NavigationMenu>
