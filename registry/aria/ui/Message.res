@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Align = {
  @unboxed
  type t =
    | @as("start") Start
    | @as("end") End
}

type props = {align?: Align.t, ...ReactAria.Types.DomProps.t}

@react.componentWithProps(props)
let make = ({?align, ...ReactAria.Types.DomProps.t as props}) => {
  let align = align->Option.getOr(Start)
  <div
    {...props}
    dataSlot={props.dataSlot->Option.getOr("message")}
    dataAlign={(align :> string)}
    className={cn(
      "cn-message group/message relative flex w-full min-w-0 data-[align=end]:flex-row-reverse",
      props.className,
    )}
  />
}

module Group = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("message-group")}
      className={cn("cn-message-group flex min-w-0 flex-col", props.className)}
    />
}

module Avatar = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("message-avatar")}
      className={cn(
        "cn-message-avatar flex w-fit shrink-0 items-center justify-center self-end overflow-hidden rounded-full bg-muted",
        props.className,
      )}
    />
}

module Content = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("message-content")}
      className={cn(
        "cn-message-content flex w-full min-w-0 flex-col wrap-break-word",
        props.className,
      )}
    />
}

module Header = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("message-header")}
      className={cn("cn-message-header flex max-w-full min-w-0 items-center", props.className)}
    />
}

module Footer = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("message-footer")}
      className={cn(
        "cn-message-footer flex max-w-full min-w-0 items-center group-data-[align=end]/message:justify-end",
        props.className,
      )}
    />
}
