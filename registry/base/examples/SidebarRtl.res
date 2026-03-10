@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@@directive("'use client'")

type navSubItem = {
  title: string,
  url: string,
}

type navMainItem = {
  title: string,
  url: string,
  icon: SidebarDemo.icon,
  isActive: bool,
  items: array<navSubItem>,
}

type project = {
  name: string,
  url: string,
  icon: SidebarDemo.icon,
}

type user = {
  name: string,
  email: string,
  avatar: string,
}

let navMain: array<navMainItem> = [
  {
    title: "ملعب",
    url: "#",
    icon: SidebarDemo.IconSquareTerminal,
    isActive: true,
    items: [
      {title: "السجل", url: "#"},
      {title: "المميز", url: "#"},
      {title: "الإعدادات", url: "#"},
    ],
  },
  {
    title: "النماذج",
    url: "#",
    icon: SidebarDemo.IconBot,
    isActive: false,
    items: [
      {title: "جينيسيس", url: "#"},
      {title: "إكسبلورر", url: "#"},
      {title: "كوانتوم", url: "#"},
    ],
  },
  {
    title: "التوثيق",
    url: "#",
    icon: SidebarDemo.IconBookOpen,
    isActive: false,
    items: [
      {title: "مقدمة", url: "#"},
      {title: "ابدأ", url: "#"},
      {title: "الدروس", url: "#"},
      {title: "سجل التغييرات", url: "#"},
    ],
  },
  {
    title: "الإعدادات",
    url: "#",
    icon: SidebarDemo.IconSettings2,
    isActive: false,
    items: [
      {title: "عام", url: "#"},
      {title: "الفريق", url: "#"},
      {title: "الفوترة", url: "#"},
      {title: "الحدود", url: "#"},
    ],
  },
]

let projects: array<project> = [
  {name: "هندسة التصميم", url: "#", icon: SidebarDemo.IconFrame},
  {name: "المبيعات والتسويق", url: "#", icon: SidebarDemo.IconPieChart},
  {name: "السفر", url: "#", icon: SidebarDemo.IconMap},
]

let userData: user = {
  name: "shadcn",
  email: "m@example.com",
  avatar: "/avatars/shadcn.jpg",
}

module SidebarContentInner = {
  @react.component
  let make = () => {
    let {isMobile} = Sidebar.useSidebar()

    <>
      <Sidebar collapsible=Sidebar.Icon side=Sidebar.Right variant=Sidebar.Floating dir="rtl">
        <Sidebar.Header>
          <Sidebar.Menu>
            <Sidebar.MenuItem>
              <Sidebar.MenuButton size=Sidebar.MenuButton.Size.Lg render={<a href="#" />}>
                <div
                  className="bg-sidebar-primary text-sidebar-primary-foreground flex aspect-square size-8 items-center justify-center rounded-lg"
                >
                  <Icons.GalleryVerticalEnd className="size-4" />
                </div>
                <div className="flex flex-col gap-0.5 leading-none">
                  <span className="font-medium"> {"شركة أكمي"->React.string} </span>
                  <span> {"المؤسسة"->React.string} </span>
                </div>
              </Sidebar.MenuButton>
            </Sidebar.MenuItem>
          </Sidebar.Menu>
        </Sidebar.Header>
        <Sidebar.Content>
          <Sidebar.Group>
            <Sidebar.GroupLabel> {"المنصة"->React.string} </Sidebar.GroupLabel>
            <Sidebar.Menu>
              {navMain
              ->Array.map(item =>
                <Collapsible
                  key={item.title} defaultOpen={item.isActive} className="group/collapsible"
                >
                  <Sidebar.MenuItem>
                    <Collapsible.Trigger
                      render={<Sidebar.MenuButton
                        tooltip=?{Some(Sidebar.TooltipText(item.title))}
                        ariaDisabled={false}
                        dataSlot="collapsible-trigger"
                      />}
                    >
                      {SidebarDemo.renderIcon(~icon=item.icon)}
                      <span> {item.title->React.string} </span>
                      <Icons.ChevronRight
                        className="ms-auto transition-transform duration-200 group-data-[state=open]/collapsible:rotate-90 rtl:rotate-180 rtl:group-data-[state=open]/collapsible:rotate-90"
                      />
                    </Collapsible.Trigger>
                    <Collapsible.Content>
                      <Sidebar.MenuSub>
                        {item.items
                        ->Array.map(subItem =>
                          <Sidebar.MenuSubItem key={subItem.title}>
                            <Sidebar.MenuSubButton render={<a href={subItem.url} />}>
                              <span> {subItem.title->React.string} </span>
                            </Sidebar.MenuSubButton>
                          </Sidebar.MenuSubItem>
                        )
                        ->React.array}
                      </Sidebar.MenuSub>
                    </Collapsible.Content>
                  </Sidebar.MenuItem>
                </Collapsible>
              )
              ->React.array}
            </Sidebar.Menu>
          </Sidebar.Group>
          <Sidebar.Group className="group-data-[collapsible=icon]:hidden">
            <Sidebar.GroupLabel> {"المشاريع"->React.string} </Sidebar.GroupLabel>
            <Sidebar.Menu>
              {projects
              ->Array.map(item =>
                <Sidebar.MenuItem key={item.name}>
                  <Sidebar.MenuButton render={<a href={item.url} />}>
                    {SidebarDemo.renderIcon(~icon=item.icon)}
                    <span> {item.name->React.string} </span>
                  </Sidebar.MenuButton>
                  <DropdownMenu>
                    <DropdownMenu.Trigger
                      render={<Sidebar.MenuAction
                        showOnHover=true dataSlot="dropdown-menu-trigger"
                      />}
                    >
                      <Icons.MoreHorizontal />
                      <span className="sr-only"> {"المزيد"->React.string} </span>
                    </DropdownMenu.Trigger>
                    <DropdownMenu.Content
                      className="w-48 rounded-lg"
                      side={isMobile ? BaseUi.Types.Side.Bottom : BaseUi.Types.Side.InlineEnd}
                      align={isMobile ? BaseUi.Types.Align.End : BaseUi.Types.Align.Start}
                    >
                      <DropdownMenu.Group>
                        <DropdownMenu.Item>
                          <Icons.Folder className="text-muted-foreground" />
                          <span> {"عرض المشروع"->React.string} </span>
                        </DropdownMenu.Item>
                        <DropdownMenu.Item>
                          <Icons.Forward className="text-muted-foreground" />
                          <span> {"مشاركة المشروع"->React.string} </span>
                        </DropdownMenu.Item>
                      </DropdownMenu.Group>
                      <DropdownMenu.Separator />
                      <DropdownMenu.Group>
                        <DropdownMenu.Item>
                          <Icons.Trash2 className="text-muted-foreground" />
                          <span> {"حذف المشروع"->React.string} </span>
                        </DropdownMenu.Item>
                      </DropdownMenu.Group>
                    </DropdownMenu.Content>
                  </DropdownMenu>
                </Sidebar.MenuItem>
              )
              ->React.array}
              <Sidebar.MenuItem>
                <Sidebar.MenuButton className="text-sidebar-foreground/70">
                  <Icons.MoreHorizontal className="text-sidebar-foreground/70" />
                  <span> {"المزيد"->React.string} </span>
                </Sidebar.MenuButton>
              </Sidebar.MenuItem>
            </Sidebar.Menu>
          </Sidebar.Group>
        </Sidebar.Content>
        <Sidebar.Footer>
          <Sidebar.Menu>
            <Sidebar.MenuItem>
              <DropdownMenu>
                <DropdownMenu.Trigger
                  render={<Sidebar.MenuButton
                    size=Sidebar.MenuButton.Size.Lg
                    className="data-open:bg-sidebar-accent data-open:text-sidebar-accent-foreground"
                    dataSlot="dropdown-menu-trigger"
                  />}
                >
                  <Avatar className="rounded-lg">
                    <Avatar.Image src={userData.avatar} alt={userData.name} />
                    <Avatar.Fallback className="rounded-lg"> {"CN"->React.string} </Avatar.Fallback>
                  </Avatar>
                  <div className="grid flex-1 text-start text-sm leading-tight">
                    <span className="truncate font-medium"> {userData.name->React.string} </span>
                    <span className="truncate text-xs"> {userData.email->React.string} </span>
                  </div>
                  <Icons.ChevronsUpDown className="ms-auto size-4" />
                </DropdownMenu.Trigger>
                <DropdownMenu.Content
                  className="w-(--radix-dropdown-menu-trigger-width) min-w-56 rounded-lg"
                  side={isMobile ? BaseUi.Types.Side.Bottom : BaseUi.Types.Side.InlineEnd}
                  align=BaseUi.Types.Align.End
                  sideOffset={4.}
                >
                  <DropdownMenu.Group>
                    <DropdownMenu.Label className="p-0 font-normal">
                      <div className="flex items-center gap-2 px-1 py-1.5 text-left text-sm">
                        <Avatar>
                          <Avatar.Image src={userData.avatar} alt={userData.name} />
                          <Avatar.Fallback className="rounded-lg">
                            {"CN"->React.string}
                          </Avatar.Fallback>
                        </Avatar>
                        <div className="grid flex-1 text-start text-sm leading-tight">
                          <span className="truncate font-medium">
                            {userData.name->React.string}
                          </span>
                          <span className="truncate text-xs"> {userData.email->React.string} </span>
                        </div>
                      </div>
                    </DropdownMenu.Label>
                  </DropdownMenu.Group>
                  <DropdownMenu.Separator />
                  <DropdownMenu.Group>
                    <DropdownMenu.Item>
                      <Icons.Sparkles />
                      {"ترقية إلى Pro"->React.string}
                    </DropdownMenu.Item>
                  </DropdownMenu.Group>
                  <DropdownMenu.Separator />
                  <DropdownMenu.Group>
                    <DropdownMenu.Item>
                      <Icons.BadgeCheck />
                      {"الحساب"->React.string}
                    </DropdownMenu.Item>
                    <DropdownMenu.Item>
                      <Icons.CreditCard />
                      {"الفوترة"->React.string}
                    </DropdownMenu.Item>
                    <DropdownMenu.Item>
                      <Icons.Bell />
                      {"الإشعارات"->React.string}
                    </DropdownMenu.Item>
                  </DropdownMenu.Group>
                  <DropdownMenu.Separator />
                  <DropdownMenu.Group>
                    <DropdownMenu.Item>
                      <Icons.LogOut />
                      {"تسجيل الخروج"->React.string}
                    </DropdownMenu.Item>
                  </DropdownMenu.Group>
                </DropdownMenu.Content>
              </DropdownMenu>
            </Sidebar.MenuItem>
          </Sidebar.Menu>
        </Sidebar.Footer>
        <Sidebar.Rail />
      </Sidebar>
      <Sidebar.Inset>
        <header
          className="flex h-16 shrink-0 items-center gap-2 transition-[width,height] ease-linear group-has-data-[collapsible=icon]/sidebar-wrapper:h-12"
          dir="rtl"
        >
          <div className="flex items-center gap-2 px-4">
            <Sidebar.Trigger className="-ml-1" />
          </div>
        </header>
      </Sidebar.Inset>
    </>
  }
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="relative" dir="rtl">
    <Sidebar.Provider>
      <SidebarContentInner />
    </Sidebar.Provider>
  </div>
