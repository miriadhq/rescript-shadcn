@@directive("'use client'")

open BaseUi.Types

@module("cn")
external cn: (string, option<string>) => string = "cn"

@react.componentWithComponents(BaseUIComponentProps.t)
let make = (props: BaseUIComponentProps.t) =>
  <BaseUi.Separator
    {...props}
    dataSlot={props.dataSlot->Option.getOr("separator")}
    orientation={props.orientation->Option.getOr(Horizontal)}
    className={cn(
      "shrink-0 bg-border data-horizontal:h-px data-horizontal:w-full data-vertical:w-px data-vertical:self-stretch",
      props.className,
    )}
  />
