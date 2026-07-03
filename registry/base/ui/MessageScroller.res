@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Direction = {
  @unboxed
  type t =
    | @as("start") Start
    | @as("end") End
}

module Provider = {
  @react.component
  let make = (~children=React.null) => children
}

@react.component
let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
  <div
    ?id
    ?style
    ?onClick
    ?onKeyDown
    ?children
    dataSlot="message-scroller"
    className={cn(
      "cn-message-scroller group/message-scroller relative flex size-full min-h-0 flex-col overflow-hidden",
      className,
    )}
  />

module Viewport = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <div
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?children
      dataSlot="message-scroller-viewport"
      className={cn(
        "cn-message-scroller-viewport size-full min-h-0 min-w-0 scroll-fade-b scrollbar-thin scrollbar-gutter-stable overflow-y-auto overscroll-contain contain-content data-autoscrolling:scrollbar-thumb-transparent data-autoscrolling:scrollbar-track-transparent",
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
      dataSlot="message-scroller-content"
      className={cn("cn-message-scroller-content flex h-max min-h-full flex-col", className)}
    />
}

module Item = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~scrollAnchor=false,
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
      dataSlot="message-scroller-item"
      className={cn(
        "cn-message-scroller-item min-w-0 shrink-0 [contain-intrinsic-size:auto_10rem] [content-visibility:auto]",
        className,
      )}
    />
}

module Button = {
  @react.component
  let make = (
    ~className=?,
    ~direction=Direction.End,
    ~children=?,
    ~ariaLabel=?,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
  ) =>
    <button
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?ariaLabel
      type_="button"
      dataSlot="message-scroller-button"
      className={cn(
        "cn-message-scroller-button absolute inset-s-1/2 -translate-x-1/2 border-border bg-background text-foreground transition-[translate,scale,opacity] duration-200 hover:bg-muted hover:text-foreground data-[active=false]:pointer-events-none data-[active=false]:scale-95 data-[active=false]:opacity-0 data-[active=false]:duration-400 data-[active=false]:ease-[cubic-bezier(0.7,0,0.84,0)] data-[active=true]:translate-y-0 data-[active=true]:scale-100 data-[active=true]:opacity-100 data-[active=true]:ease-[cubic-bezier(0.23,1,0.32,1)] data-[direction=end]:bottom-4 data-[direction=end]:data-[active=false]:translate-y-full data-[direction=start]:top-4 data-[direction=start]:data-[active=false]:-translate-y-full rtl:translate-x-1/2 data-[direction=start]:[&_svg]:rotate-180",
        className,
      )}
    >
      {children->Option.getOr(React.null)}
    </button>
}
