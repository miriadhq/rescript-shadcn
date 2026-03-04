@@directive("'use client'")

@react.component
let make = () =>
  <div className="flex w-full max-w-md flex-col gap-6" dir="rtl">
    <Item variant=Item.Variant.Outline dir="rtl">
      <Item.Content>
        <Item.Title> {"عنصر أساسي"->React.string} </Item.Title>
        <Item.Description>
          {"عنصر بسيط يحتوي على عنوان ووصف."->React.string}
        </Item.Description>
      </Item.Content>
      <Item.Actions>
        <Button variant=Button.Variant.Outline size=Button.Size.Sm>
          {"إجراء"->React.string}
        </Button>
      </Item.Actions>
    </Item>
    <Item variant=Item.Variant.Outline size=Item.Size.Sm render={<a href="#" />} dir="rtl">
      <Item.Media>
        <Icons.BadgeCheck className="size-5" />
      </Item.Media>
      <Item.Content>
        <Item.Title> {"تم التحقق من ملفك الشخصي."->React.string} </Item.Title>
      </Item.Content>
      <Item.Actions>
        <Icons.ChevronRight className="size-4" />
      </Item.Actions>
    </Item>
  </div>
