@@directive("'use client'")

module TablerIcons = {
  type props = {className?: string}

  module FolderCode = {
    @module("@tabler/icons-react")
    external make: React.component<props> = "IconFolderCode"
  }
}

@react.component
let make = () =>
  <Empty dir="rtl">
    <Empty.Header>
      <Empty.Media variant=Empty.Variant.Icon>
        <TablerIcons.FolderCode />
      </Empty.Media>
      <Empty.Title> {"لا توجد مشاريع بعد"->React.string} </Empty.Title>
      <Empty.Description>
        {"لم تقم بإنشاء أي مشاريع بعد. ابدأ بإنشاء مشروعك الأول."->React.string}
      </Empty.Description>
    </Empty.Header>
    <Empty.Content className="flex-row justify-center gap-2">
      <Button> {"إنشاء مشروع"->React.string} </Button>
      <Button variant=Button.Variant.Outline> {"استيراد مشروع"->React.string} </Button>
    </Empty.Content>
    <Button
      variant=Button.Variant.Link
      render={<a href="#" />}
      className="text-muted-foreground"
      size=Button.Size.Sm
      nativeButton={false}
    >
      {"تعرف على المزيد "->React.string}
      <Icons.ArrowUpRight />
    </Button>
  </Empty>
