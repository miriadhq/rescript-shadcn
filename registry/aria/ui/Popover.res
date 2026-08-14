@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

open ReactAria.Types

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Trigger = {
  @react.componentWithProps(ReactAria.Dialog.Trigger.props)
  let make = (props: ReactAria.Dialog.Trigger.props) =>
    <ReactAria.Dialog.Trigger {...props} dataSlot="popover-trigger" />
}

@react.componentWithProps(ReactAria.Popover.props)
let make = (props: ReactAria.Popover.props) =>
  <ReactAria.Popover
    {...props}
    placement={props.placement->Option.getOr(ReactAria.Common.Bottom)}
    offset={props.offset->Option.getOr(4.)}
    crossOffset={props.crossOffset->Option.getOr(0.)}
    dataSlot="popover-content"
    className={cn(
      "cn-popover-content-aria z-50 w-72 origin-(--trigger-anchor-point) outline-hidden",
      props.className,
    )}
  />

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
  @react.componentWithProps(ReactAria.Heading.props)
  let make = (props: ReactAria.Heading.props) =>
    <ReactAria.Heading
      {...props}
      dataSlot="popover-title"
      className={cn("cn-popover-title", props.className)}
    />
}

module Description = {
  @react.componentWithProps(DomProps.t)
  let make = (props: DomProps.t) =>
    <div
      {...props}
      dataSlot="popover-description"
      className={cn("cn-popover-description", props.className)}
    />
}
