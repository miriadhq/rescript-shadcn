@@directive("'use client'")

@react.component
let make = () =>
  <div className="flex max-w-sm flex-col gap-4 text-sm" dir="rtl">
    <div className="flex flex-col gap-1.5">
      <div className="leading-none font-medium"> {"shadcn/ui"->React.string} </div>
      <div className="text-muted-foreground">
        {"الأساس لنظام التصميم الخاص بك"->React.string}
      </div>
    </div>
    <Separator />
    <div>
      {"مجموعة من المكونات المصممة بشكل جميل يمكنك تخصيصها وتوسيعها والبناء عليها."->React.string}
    </div>
  </div>
