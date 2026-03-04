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
        <Popover key=label>
          <Popover.Trigger render={<Button variant=Button.Variant.Outline />}>
            {label->React.string}
          </Popover.Trigger>
          <Popover.Content side dir="rtl">
            <Popover.Header>
              <Popover.Title> {"الأبعاد"->React.string} </Popover.Title>
              <Popover.Description>
                {"تعيين الأبعاد للطبقة."->React.string}
              </Popover.Description>
            </Popover.Header>
          </Popover.Content>
        </Popover>
      )
      ->React.array}
    </div>
    <div className="flex flex-wrap justify-center gap-2">
      {logicalSides
      ->Array.map(((side, label)) =>
        <Popover key=label>
          <Popover.Trigger render={<Button variant=Button.Variant.Outline />}>
            {label->React.string}
          </Popover.Trigger>
          <Popover.Content side dir="rtl">
            <Popover.Header>
              <Popover.Title> {"الأبعاد"->React.string} </Popover.Title>
              <Popover.Description>
                {"تعيين الأبعاد للطبقة."->React.string}
              </Popover.Description>
            </Popover.Header>
          </Popover.Content>
        </Popover>
      )
      ->React.array}
    </div>
  </div>
