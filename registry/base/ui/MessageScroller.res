@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Direction = {
  @unboxed
  type t = ShadcnReact.MessageScroller.Direction.t =
    | @as("start") Start
    | @as("end") End
}

module DefaultScrollPosition = {
  @unboxed
  type t = ShadcnReact.MessageScroller.DefaultScrollPosition.t =
    | @as("start") Start
    | @as("end") End
    | @as("last-anchor") LastAnchor
}

module ScrollBehavior = {
  @unboxed
  type t = ShadcnReact.MessageScroller.ScrollBehavior.t =
    | @as("auto") Auto
    | @as("instant") Instant
    | @as("smooth") Smooth
}

module UiButton = Button

module Provider = {
  @react.component
  let make = (
    ~autoScroll=?,
    ~defaultScrollPosition=?,
    ~scrollEdgeThreshold=?,
    ~scrollPreviousItemPeek=?,
    ~scrollMargin=?,
    ~children=React.null,
  ) =>
    <ShadcnReact.MessageScroller.Provider
      ?autoScroll
      ?defaultScrollPosition
      ?scrollEdgeThreshold
      ?scrollPreviousItemPeek
      ?scrollMargin
      children
    />
}

@react.component
let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
  <ShadcnReact.MessageScroller.Root
    ?id
    ?style
    ?onClick
    ?onKeyDown
    dataSlot="message-scroller"
    className={cn(
      "cn-message-scroller group/message-scroller relative flex size-full min-h-0 flex-col overflow-hidden",
      className,
    )}
  >
    {children->Option.getOr(React.null)}
  </ShadcnReact.MessageScroller.Root>

module Viewport = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~preserveScrollOnPrepend=?,
    ~ariaLabel=?,
    ~role=?,
    ~tabIndex=?,
  ) =>
    <ShadcnReact.MessageScroller.Viewport
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?preserveScrollOnPrepend
      ?ariaLabel
      ?role
      ?tabIndex
      dataSlot="message-scroller-viewport"
      className={cn(
        "cn-message-scroller-viewport size-full min-h-0 min-w-0 scroll-fade-b scrollbar-thin scrollbar-gutter-stable overflow-y-auto overscroll-contain contain-content data-autoscrolling:scrollbar-thumb-transparent data-autoscrolling:scrollbar-track-transparent",
        className,
      )}
    >
      {children->Option.getOr(React.null)}
    </ShadcnReact.MessageScroller.Viewport>
}

module Content = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~spacerClassName=?,
    ~ariaRelevant=?,
    ~ariaBusy=?,
    ~role=?,
  ) =>
    <ShadcnReact.MessageScroller.Content
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?spacerClassName
      ?ariaRelevant
      ?ariaBusy
      ?role
      dataSlot="message-scroller-content"
      className={cn("cn-message-scroller-content flex h-max min-h-full flex-col", className)}
    >
      {children->Option.getOr(React.null)}
    </ShadcnReact.MessageScroller.Content>
}

module Item = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~scrollAnchor=false,
    ~messageId=?,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
  ) =>
    <ShadcnReact.MessageScroller.Item
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?messageId
      scrollAnchor
      dataSlot="message-scroller-item"
      className={cn(
        "cn-message-scroller-item min-w-0 shrink-0 [contain-intrinsic-size:auto_10rem] [content-visibility:auto]",
        className,
      )}
    >
      {children->Option.getOr(React.null)}
    </ShadcnReact.MessageScroller.Item>
}

module Button = {
  @react.component
  let make = (
    ~className=?,
    ~direction=Direction.End,
    ~variant=UiButton.Variant.Secondary,
    ~size=UiButton.Size.IconSm,
    ~behavior=?,
    ~children=?,
    ~ariaLabel=?,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
  ) =>
    <ShadcnReact.MessageScroller.Button
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?ariaLabel
      ?behavior
      render={<UiButton variant size />}
      dataDirection=direction
      dataVariant={(variant :> string)}
      dataSize={(size :> string)}
      direction
      type_="button"
      dataSlot="message-scroller-button"
      className={cn(
        "cn-message-scroller-button absolute inset-s-1/2 -translate-x-1/2 border-border bg-background text-foreground transition-[translate,scale,opacity] duration-200 hover:bg-muted hover:text-foreground data-[active=false]:pointer-events-none data-[active=false]:scale-95 data-[active=false]:opacity-0 data-[active=false]:duration-400 data-[active=false]:ease-[cubic-bezier(0.7,0,0.84,0)] data-[active=true]:translate-y-0 data-[active=true]:scale-100 data-[active=true]:opacity-100 data-[active=true]:ease-[cubic-bezier(0.23,1,0.32,1)] data-[direction=end]:bottom-4 data-[direction=end]:data-[active=false]:translate-y-full data-[direction=start]:top-4 data-[direction=start]:data-[active=false]:-translate-y-full rtl:translate-x-1/2 data-[direction=start]:[&_svg]:rotate-180",
        className,
      )}
    >
      {children->Option.getOr(
        React.array([
          <Icons.ArrowDown key="icon" />,
          <span key="label" className="sr-only">
            {(
              switch direction {
              | End => "Scroll to end"
              | Start => "Scroll to start"
              }
            )->React.string}
          </span>,
        ]),
      )}
    </ShadcnReact.MessageScroller.Button>
}
