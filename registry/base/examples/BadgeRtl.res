@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full flex-wrap justify-center gap-2" dir="rtl">
    <RtlBadge> {"شارة"->React.string} </RtlBadge>
    <RtlBadge variant=Badge.Variant.Secondary> {"ثانوي"->React.string} </RtlBadge>
    <RtlBadge variant=Badge.Variant.Destructive> {"مدمر"->React.string} </RtlBadge>
    <RtlBadge variant=Badge.Variant.Outline> {"مخطط"->React.string} </RtlBadge>
    <RtlBadge variant=Badge.Variant.Secondary>
      <Icons.BadgeCheck dataIcon="inline-start" />
      {"متحقق"->React.string}
    </RtlBadge>
    <RtlBadge variant=Badge.Variant.Outline>
      {"إشارة مرجعية"->React.string}
      <Icons.Bookmark dataIcon="inline-end" />
    </RtlBadge>
  </div>
