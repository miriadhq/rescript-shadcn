@@directive("'use client'")

open BaseUi.Types

@module("cn")
external cn: (string, option<string>) => string = "cn"

@react.component
let make = (
  ~className=?,
  ~children=?,
  ~id=?,
  ~open_=?,
  ~defaultOpen=?,
  ~onOpenChange=?,
  ~delay=?,
  ~closeDelay=?,
  ~style=?,
) =>
  <BaseUi.Tooltip.Root
    ?className
    ?children
    ?id
    ?open_
    ?defaultOpen
    ?onOpenChange
    ?delay
    ?closeDelay
    ?style
    dataSlot="tooltip"
  />

module Provider = {
  @react.component
  let make = (~children=?, ~delay=0., ~closeDelay=?, ~timeout=?) =>
    <BaseUi.Tooltip.Provider ?children ?closeDelay ?timeout delay />
}

module Trigger = {
  @react.componentWithProps(BaseUi.Tooltip.Trigger.props)
  let make = (props: BaseUi.Tooltip.Trigger.props) =>
    <BaseUi.Tooltip.Trigger {...props} dataSlot={props.dataSlot->Option.getOr("tooltip-trigger")} />
}

module Content = {
  type props = {
    ...BaseUi.Types.BaseUIComponentWithoutChildrenProps.t,
    children: React.element,
    align?: Align.t,
    alignOffset?: float,
    side?: Side.t,
    sideOffset?: float,
  }

  let toBaseUiProps: props => BaseUi.Types.BaseUIComponentProps.t = %raw(`({align, alignOffset, side, sideOffset, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) =>
    <BaseUi.Tooltip.Portal>
      <BaseUi.Tooltip.Positioner
        align={props.align->Option.getOr(Align.Center)}
        alignOffset={Const(props.alignOffset->Option.getOr(0.))}
        side={props.side->Option.getOr(Side.Top)}
        sideOffset={Const(props.sideOffset->Option.getOr(4.))}
        className="isolate z-50"
      >
        <BaseUi.Tooltip.Popup
          {...toBaseUiProps(props)}
          dataSlot={props.dataSlot->Option.getOr("tooltip-content")}
          className={cn(
            "cn-tooltip-content cn-tooltip-content-logical data-open:animate-in data-open:fade-in-0 data-open:zoom-in-95 data-[state=delayed-open]:animate-in data-[state=delayed-open]:fade-in-0 data-[state=delayed-open]:zoom-in-95 data-closed:animate-out data-closed:fade-out-0 data-closed:zoom-out-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 bg-foreground text-background z-50 w-fit max-w-xs origin-(--transform-origin) rounded-md px-3 py-1.5 text-xs",
            props.className,
          )}
        >
          {props.children}
          <BaseUi.Tooltip.Arrow
            className="cn-tooltip-arrow cn-tooltip-arrow-logical bg-foreground fill-foreground z-50 data-[side=bottom]:top-1 data-[side=left]:top-1/2! data-[side=left]:-right-1 data-[side=left]:-translate-y-1/2 data-[side=right]:top-1/2! data-[side=right]:-left-1 data-[side=right]:-translate-y-1/2 data-[side=top]:-bottom-2.5"
          />
        </BaseUi.Tooltip.Popup>
      </BaseUi.Tooltip.Positioner>
    </BaseUi.Tooltip.Portal>
}
