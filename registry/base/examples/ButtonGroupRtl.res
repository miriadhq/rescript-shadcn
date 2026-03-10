@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (label, setLabel) = React.useState(() => "personal")

  <div dir="rtl">
    <ButtonGroup>
      <ButtonGroup className="hidden sm:flex">
        <Button variant=Button.Variant.Outline size=Button.Size.Icon ariaLabel="Go Back">
          <Icons.ArrowLeft className="rtl:rotate-180" />
        </Button>
      </ButtonGroup>
      <ButtonGroup>
        <Button variant=Button.Variant.Outline> {"أرشفة"->React.string} </Button>
        <Button variant=Button.Variant.Outline> {"تقرير"->React.string} </Button>
      </ButtonGroup>
      <ButtonGroup>
        <Button variant=Button.Variant.Outline> {"تأجيل"->React.string} </Button>
        <DropdownMenu>
          <DropdownMenu.Trigger
            render={<Button
              variant=Button.Variant.Outline
              dataSlot="dropdown-menu-trigger"
              size=Button.Size.Icon
              ariaLabel="More Options"
            />}
          >
            <Icons.MoreHorizontal />
          </DropdownMenu.Trigger>
          <DropdownMenu.Content
            align=BaseUi.Types.Align.Start dir="rtl" dataLang="ar" className="w-40"
          >
            <DropdownMenu.Group>
              <DropdownMenu.Item>
                <Icons.MailCheck />
                {"وضع علامة كمقروء"->React.string}
              </DropdownMenu.Item>
              <DropdownMenu.Item>
                <Icons.Archive />
                {"أرشفة"->React.string}
              </DropdownMenu.Item>
            </DropdownMenu.Group>
            <DropdownMenu.Separator />
            <DropdownMenu.Group>
              <DropdownMenu.Item>
                <Icons.Clock />
                {"تأجيل"->React.string}
              </DropdownMenu.Item>
              <DropdownMenu.Item>
                <Icons.CalendarPlus />
                {"إضافة إلى التقويم"->React.string}
              </DropdownMenu.Item>
              <DropdownMenu.Item>
                <Icons.ListFilter />
                {"إضافة إلى القائمة"->React.string}
              </DropdownMenu.Item>
              <DropdownMenu.Sub>
                <DropdownMenu.SubTrigger>
                  <Icons.Tag />
                  {"تصنيف كـ..."->React.string}
                </DropdownMenu.SubTrigger>
                <DropdownMenu.SubContent dir="rtl" dataLang="ar">
                  <DropdownMenu.RadioGroup value=label onValueChange={(v, _) => setLabel(_ => v)}>
                    <DropdownMenu.RadioItem value="personal">
                      {"شخصي"->React.string}
                    </DropdownMenu.RadioItem>
                    <DropdownMenu.RadioItem value="work">
                      {"عمل"->React.string}
                    </DropdownMenu.RadioItem>
                    <DropdownMenu.RadioItem value="other">
                      {"آخر"->React.string}
                    </DropdownMenu.RadioItem>
                  </DropdownMenu.RadioGroup>
                </DropdownMenu.SubContent>
              </DropdownMenu.Sub>
            </DropdownMenu.Group>
            <DropdownMenu.Separator />
            <DropdownMenu.Group>
              <DropdownMenu.Item variant=DropdownMenu.Variant.Destructive>
                <Icons.Trash2 />
                {"سلة المهملات"->React.string}
              </DropdownMenu.Item>
            </DropdownMenu.Group>
          </DropdownMenu.Content>
        </DropdownMenu>
      </ButtonGroup>
    </ButtonGroup>
  </div>
}
