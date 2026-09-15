@@directive("'use client'")

open BaseUi.Types

@module("cn")
external cn: (string, option<string>) => string = "cn"

@react.componentWithProps(BaseUi.PreviewCard.Root.props)
let make = (props: BaseUi.PreviewCard.Root.props<'payload>) =>
  <BaseUi.PreviewCard.Root {...props} dataSlot={props.dataSlot->Option.getOr("hover-card")} />

module Trigger = {
  @react.componentWithProps(BaseUi.PreviewCard.Trigger.props)
  let make = (props: BaseUi.PreviewCard.Trigger.props<'payload>) =>
    <BaseUi.PreviewCard.Trigger
      {...props} dataSlot={props.dataSlot->Option.getOr("hover-card-trigger")}
    />
}

module Content = {
  type props = {
    ...BaseUi.Types.BaseUIComponentProps.t,
    align?: Align.t,
    alignOffset?: float,
    side?: Side.t,
    sideOffset?: float,
  }

  let toBaseUiProps: props => BaseUi.Types.BaseUIComponentProps.t = %raw(`({align, alignOffset, side, sideOffset, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let align = props.align->Option.getOr(Align.Center)
    let alignOffset = props.alignOffset->Option.getOr(4.)
    let side = props.side->Option.getOr(Side.Bottom)
    let sideOffset = props.sideOffset->Option.getOr(4.)
    <BaseUi.PreviewCard.Portal dataSlot="hover-card-portal">
      <BaseUi.PreviewCard.Positioner
        align
        alignOffset={Const(alignOffset)}
        side
        sideOffset={Const(sideOffset)}
        className="isolate z-50"
      >
        <BaseUi.PreviewCard.Popup
          {...props->toBaseUiProps}
          dataSlot={props.dataSlot->Option.getOr("hover-card-content")}
          className={cn(
            "cn-hover-card-content-logical cn-hover-card-content z-50 origin-(--transform-origin) outline-hidden",
            props.className,
          )}
        />
      </BaseUi.PreviewCard.Positioner>
    </BaseUi.PreviewCard.Portal>
  }
}
