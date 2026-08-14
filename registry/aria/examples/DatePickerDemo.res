@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Popover.Trigger>
    <Button variant=Outline className="px-2.5 font-normal">
      <Icons.Calendar dataIcon="inline-start" />
      {"Open Calendar"->React.string}
    </Button>
    <Popover className="w-auto p-0" placement=ReactAria.Common.BottomStart>
      <Calendar />
    </Popover>
  </Popover.Trigger>
