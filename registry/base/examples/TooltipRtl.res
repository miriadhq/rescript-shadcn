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
        <Tooltip key=label>
          <Tooltip.Trigger render={<Button variant=Button.Variant.Outline />}>
            {label->React.string}
          </Tooltip.Trigger>
          <Tooltip.Content side dir="rtl">
            {"إضافة إلى المكتبة"->React.string}
          </Tooltip.Content>
        </Tooltip>
      )
      ->React.array}
    </div>
    <div className="flex flex-wrap justify-center gap-2">
      {logicalSides
      ->Array.map(((side, label)) =>
        <Tooltip key=label>
          <Tooltip.Trigger render={<Button variant=Button.Variant.Outline />}>
            {label->React.string}
          </Tooltip.Trigger>
          <Tooltip.Content side dir="rtl">
            {"إضافة إلى المكتبة"->React.string}
          </Tooltip.Content>
        </Tooltip>
      )
      ->React.array}
    </div>
  </div>
