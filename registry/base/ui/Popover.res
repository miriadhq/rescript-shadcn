@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

open BaseUi.Types

@module("cn")
external cn: (string, option<string>) => string = "cn"

@react.componentWithProps(BaseUi.Popover.Root.props)
let make = (props: BaseUi.Popover.Root.props<'payload>) =>
  <BaseUi.Popover.Root {...props} dataSlot={props.dataSlot->Option.getOr("popover")} />

module Trigger = {
  @react.componentWithProps(BaseUi.Popover.Trigger.props)
  let make = (props: BaseUi.Popover.Trigger.props<'payload>) =>
    <BaseUi.Popover.Trigger {...props} dataSlot={props.dataSlot->Option.getOr("popover-trigger")} />
}

module Content = {
  type props = {
    align?: Align.t,
    alignOffset?: float,
    side?: Side.t,
    sideOffset?: float,
    ...BaseUi.Popover.Popup.props,
  }

  let toBaseUiProps: props => BaseUi.Popover.Popup.props = %raw(`({align, alignOffset, side, sideOffset, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) =>
    <BaseUi.Popover.Portal>
      <BaseUi.Popover.Positioner
        align={props.align->Option.getOr(Align.Center)}
        alignOffset={Const(props.alignOffset->Option.getOr(0.))}
        side={props.side->Option.getOr(Side.Bottom)}
        sideOffset={Const(props.sideOffset->Option.getOr(4.))}
        className="isolate z-50"
      >
        <BaseUi.Popover.Popup
          {...toBaseUiProps(props)}
          dataSlot={props.dataSlot->Option.getOr("popover-content")}
          className={cn(
            "cn-popover-content-logical cn-popover-content z-50 w-72 origin-(--transform-origin) outline-hidden",
            props.className,
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
