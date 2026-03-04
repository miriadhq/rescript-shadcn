@@directive("'use client'")

let physicalSides = [
  (BaseUi.Types.Side.Left, "يسار"),
  (BaseUi.Types.Side.Top, "أعلى"),
  (BaseUi.Types.Side.Bottom, "أسفل"),
  (BaseUi.Types.Side.Right, "يمين"),
]

let logicalSides = [
  (BaseUi.Types.Side.InlineStart, "بداية السطر"),
  (BaseUi.Types.Side.InlineEnd, "نهاية السطر"),
]

@react.component
let make = () =>
  <div className="grid gap-4">
    <div className="flex flex-wrap justify-center gap-2">
      {physicalSides
      ->Array.map(((side, label)) =>
        <HoverCard key=label>
          <HoverCard.Trigger
            delay={10.} closeDelay={100.} render={<Button variant=Button.Variant.Outline />}
          >
            {label->React.string}
          </HoverCard.Trigger>
          <HoverCard.Content side className="flex w-64 flex-col gap-1" dir="rtl">
            <div className="font-semibold"> {"سماعات لاسلكية"->React.string} </div>
            <div className="text-muted-foreground text-sm"> {"٩٩.٩٩ $"->React.string} </div>
          </HoverCard.Content>
        </HoverCard>
      )
      ->React.array}
    </div>
    <div className="flex flex-wrap justify-center gap-2">
      {logicalSides
      ->Array.map(((side, label)) =>
        <HoverCard key=label>
          <HoverCard.Trigger
            delay={10.} closeDelay={100.} render={<Button variant=Button.Variant.Outline />}
          >
            {label->React.string}
          </HoverCard.Trigger>
          <HoverCard.Content side className="flex w-64 flex-col gap-1" dir="rtl">
            <div className="font-semibold"> {"سماعات لاسلكية"->React.string} </div>
            <div className="text-muted-foreground text-sm"> {"٩٩.٩٩ $"->React.string} </div>
          </HoverCard.Content>
        </HoverCard>
      )
      ->React.array}
    </div>
  </div>
