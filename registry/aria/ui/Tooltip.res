@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module ContentProps = {
  type t = ReactAria.Tooltip.props
}

module Trigger = {
  @react.componentWithProps(ReactAria.Tooltip.Trigger.props)
  let make = (props: ReactAria.Tooltip.Trigger.props) => {
    let children = props.children->Option.getOr(React.null)->React.Children.toArray
    let triggerElement = children->Array.get(0)->Option.getOr(React.null)
    let tooltip = children->Array.get(1)->Option.getOr(React.null)
    <ReactAria.Tooltip.Trigger
      {...props} dataSlot="tooltip-trigger" delay={props.delay->Option.getOr(0.)}
    >
      <ReactAria.Focusable> {triggerElement} </ReactAria.Focusable>
      {tooltip}
    </ReactAria.Tooltip.Trigger>
  }
}

@react.componentWithProps(ReactAria.Tooltip.props)
let make = (props: ReactAria.Tooltip.props) => {
  <ReactAria.Tooltip
    {...props}
    placement={props.placement->Option.getOr(ReactAria.Common.Placement.Top)}
    offset={props.offset->Option.getOr(4.)}
    crossOffset={props.crossOffset->Option.getOr(0.)}
    dataSlot="tooltip-content"
    className={cn(
      "cn-tooltip-content-aria z-50 w-fit max-w-xs origin-(--trigger-anchor-point) bg-foreground text-background",
      props.className,
    )}
  >
    {props.children->Option.getOr(React.null)}
    <ReactAria.Tooltip.Arrow
      className="cn-tooltip-arrow z-50 bg-foreground fill-foreground"
      style={({placement, defaultStyle}) => {
        let transform = switch placement {
        | "bottom" => "translate(-50%, calc(50% + 2px)) rotate(45deg)"
        | "top" => "translate(-50%, calc(-50% - 2px)) rotate(45deg)"
        | "left" => "translate(calc(-50% - 2px), -50%) rotate(45deg)"
        | _ => "translate(calc(50% + 2px), -50%) rotate(45deg)"
        }
        defaultStyle
        ->ReactDOM.Style.unsafeAddProp("rotate", "0deg")
        ->ReactDOM.Style.unsafeAddProp("translate", "0 0")
        ->ReactDOM.Style.unsafeAddProp("transform", transform)
      }}
    />
  </ReactAria.Tooltip>
}
