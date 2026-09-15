@@directive("'use client'")

@module("cn") external cn: (string, option<string>) => string = "cn"

module Trigger = {
  @react.componentWithProps(ReactAria.PreviewTrigger.props)
  let make = (props: ReactAria.PreviewTrigger.props) =>
    <ReactAria.PreviewTrigger
      {...props} dataSlot={props.dataSlot->Option.getOr("hover-card-trigger")}
    />
}

type props = ReactAria.Popover.props
let toPrimitiveProps: props => props = %raw(`({className, placement, offset, crossOffset, ...props}) => props`)
@react.componentWithProps(props)
let make = (props: props) =>
  <ReactAria.Popover
    {...toPrimitiveProps(props)}
    placement={props.placement->Option.getOr(ReactAria.Common.Bottom)}
    offset={props.offset->Option.getOr(4.)}
    crossOffset={props.crossOffset->Option.getOr(0.)}
    dataSlot={props.dataSlot->Option.getOr("hover-card-content")}
    className={cn(
      "cn-hover-card-content-aria z-50 origin-(--trigger-anchor-point) outline-hidden",
      props.className,
    )}
  />
