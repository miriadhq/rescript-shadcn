@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Align = {
  @unboxed
  type t =
    | @as("start") Start
    | @as("end") End
}

@react.component
let make = (
  ~className=?,
  ~align=Align.Start,
  ~children=?,
  ~id=?,
  ~style=?,
  ~onClick=?,
  ~onKeyDown=?,
) =>
  <div
    ?id
    ?style
    ?onClick
    ?onKeyDown
    ?children
    dataSlot="message"
    dataAlign={(align :> string)}
    className={cn(
      "cn-message group/message relative flex w-full min-w-0 data-[align=end]:flex-row-reverse",
      className,
    )}
  />

module Group = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <div
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?children
      dataSlot="message-group"
      className={cn("cn-message-group flex min-w-0 flex-col", className)}
    />
}

module Avatar = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <div
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?children
      dataSlot="message-avatar"
      className={cn(
        "cn-message-avatar flex w-fit shrink-0 items-center justify-center self-end overflow-hidden rounded-full bg-muted",
        className,
      )}
    />
}

module Content = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <div
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?children
      dataSlot="message-content"
      className={cn("cn-message-content flex w-full min-w-0 flex-col wrap-break-word", className)}
    />
}

module Header = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <div
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?children
      dataSlot="message-header"
      className={cn("cn-message-header flex max-w-full min-w-0 items-center", className)}
    />
}

module Footer = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <div
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?children
      dataSlot="message-footer"
      className={cn(
        "cn-message-footer flex max-w-full min-w-0 items-center group-data-[align=end]/message:justify-end",
        className,
      )}
    />
}
