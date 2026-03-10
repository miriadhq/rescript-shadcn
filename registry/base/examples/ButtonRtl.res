@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex flex-wrap items-center gap-2 md:flex-row" dir="rtl">
    <RtlButton variant=Button.Variant.Outline> {"زر"->React.string} </RtlButton>
    <RtlButton variant=Button.Variant.Destructive> {"حذف"->React.string} </RtlButton>
    <RtlButton variant=Button.Variant.Outline>
      {"إرسال"->React.string}
      <Icons.ArrowRight className="rtl:rotate-180" dataIcon="inline-end" />
    </RtlButton>
    <RtlButton variant=Button.Variant.Outline size=Button.Size.Icon ariaLabel="Add">
      <Icons.Plus />
    </RtlButton>
    <RtlButton variant=Button.Variant.Secondary disabled=true>
      <Spinner dataIcon="inline-start" />
      {"جاري التحميل"->React.string}
    </RtlButton>
  </div>
