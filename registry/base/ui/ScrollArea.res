@@directive("'use client'")

open BaseUi.Types

@module("cn")
external cn: (string, option<string>) => string = "cn"

@react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
let make = (props: BaseUi.Types.BaseUIComponentProps.t) => {
  let children = props.children
  <BaseUi.ScrollArea.Root
    {...props}
    dataSlot={props.dataSlot->Option.getOr("scroll-area")}
    className={cn("cn-scroll-area relative", props.className)}
  >
    <BaseUi.ScrollArea.Viewport
      dataSlot="scroll-area-viewport"
      className="cn-scroll-area-viewport focus-visible:ring-ring/50 size-full rounded-[inherit] transition-[color,box-shadow] outline-none focus-visible:ring-[3px] focus-visible:outline-1"
    >
      <BaseUi.ScrollArea.Content ?children />
    </BaseUi.ScrollArea.Viewport>
    <BaseUi.ScrollArea.Scrollbar
      dataSlot="scroll-area-scrollbar"
      orientation={Orientation.Vertical}
      className="cn-scroll-area-scrollbar flex touch-none p-px transition-colors select-none"
    >
      <BaseUi.ScrollArea.Thumb
        dataSlot="scroll-area-thumb" className="cn-scroll-area-thumb bg-border relative flex-1"
      />
    </BaseUi.ScrollArea.Scrollbar>
    <BaseUi.ScrollArea.Corner />
  </BaseUi.ScrollArea.Root>
}

module ScrollBar = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) => {
    let children = props.children->Option.getOr(React.null)
    let orientation = props.orientation->Option.getOr(Orientation.Vertical)
    <BaseUi.ScrollArea.Scrollbar
      {...props}
      dataSlot={props.dataSlot->Option.getOr("scroll-area-scrollbar")}
      orientation
      className={cn(
        "cn-scroll-area-scrollbar flex touch-none p-px transition-colors select-none",
        props.className,
      )}
    >
      <BaseUi.ScrollArea.Thumb
        dataSlot="scroll-area-thumb" className="cn-scroll-area-thumb bg-border relative flex-1"
      />
      {children}
    </BaseUi.ScrollArea.Scrollbar>
  }
}
