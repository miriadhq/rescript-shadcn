@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

open BaseUi.Types

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@react.component
let make = (
  ~children=?,
  ~open_=?,
  ~defaultOpen=?,
  ~onOpenChange=?,
  ~onOpenChangeComplete=?,
  ~modal=?,
) =>
  <BaseUi.Popover.Root ?children ?open_ ?defaultOpen ?onOpenChange ?onOpenChangeComplete ?modal />

module Trigger = {
  type props<'payload> = {...BaseUi.Popover.Trigger.props<'payload>}

  @react.componentWithProps(props)
  let make = ({...BaseUi.Popover.Trigger.props as props}) =>
    <BaseUi.Popover.Trigger {...props} dataSlot={props.dataSlot->Option.getOr("popover-trigger")} />
}

module Content = {
  @react.component
  let make = (
    ~className=?,
    ~align=Align.Center,
    ~alignOffset=0.,
    ~side=Side.Bottom,
    ~sideOffset=4.,
    ~children=?,
    ~id=?,
    ~dir=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
  ) =>
    <BaseUi.Popover.Portal>
      <BaseUi.Popover.Positioner
        align
        alignOffset={Const(alignOffset)}
        side
        sideOffset={Const(sideOffset)}
        className="isolate z-50"
      >
        <BaseUi.Popover.Popup
          ?id
          ?dir
          ?style
          ?onClick
          ?onKeyDown
          ?children
          dataSlot="popover-content"
          className={cn(
            "cn-popover-content-logical cn-popover-content z-50 w-72 origin-(--transform-origin) outline-hidden",
            className,
          )}
        />
      </BaseUi.Popover.Positioner>
    </BaseUi.Popover.Portal>
}

module Header = {
  @react.componentWithProps(DomProps.t)
  let make = (props: DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("popover-header")}
      className={cn("cn-popover-header", props.className)}
    />
}

module Title = {
  @react.componentWithProps(BaseUIComponentProps.t)
  let make = (props: BaseUIComponentProps.t) =>
    <BaseUi.Popover.Title
      {...props}
      dataSlot={props.dataSlot->Option.getOr("popover-title")}
      className={cn("cn-popover-title", props.className)}
    />
}

module Description = {
  @react.componentWithProps(BaseUIComponentProps.t)
  let make = (props: BaseUIComponentProps.t) =>
    <BaseUi.Popover.Description
      {...props}
      dataSlot={props.dataSlot->Option.getOr("popover-description")}
      className={cn("cn-popover-description", props.className)}
    />
}
