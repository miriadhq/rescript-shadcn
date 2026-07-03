module DefaultScrollPosition = {
  @unboxed
  type t =
    | @as("start") Start
    | @as("end") End
    | @as("last-anchor") LastAnchor
}

module Direction = {
  @unboxed
  type t =
    | @as("start") Start
    | @as("end") End
}

module ScrollAlign = {
  @unboxed
  type t =
    | @as("start") Start
    | @as("center") Center
    | @as("end") End
    | @as("nearest") Nearest
}

module ScrollBehavior = {
  @unboxed
  type t =
    | @as("auto") Auto
    | @as("instant") Instant
    | @as("smooth") Smooth
}

type scrollOptions = {
  align?: ScrollAlign.t,
  behavior?: ScrollBehavior.t,
  scrollMargin?: float,
}

type scrollable = {
  start: bool,
  end: bool,
}

type visibilityState = {
  currentAnchorId: Nullable.t<string>,
  visibleMessageIds: array<string>,
}

type controller = {
  scrollToEnd: option<scrollOptions> => bool,
  scrollToMessage: (string, option<scrollOptions>) => bool,
  scrollToStart: option<scrollOptions> => bool,
}

@module("@shadcn/react/message-scroller")
external useMessageScroller: unit => controller = "useMessageScroller"

@module("@shadcn/react/message-scroller")
external useMessageScrollerScrollable: unit => scrollable = "useMessageScrollerScrollable"

@module("@shadcn/react/message-scroller")
external useMessageScrollerVisibility: unit => visibilityState = "useMessageScrollerVisibility"

type divProps = {
  children?: React.element,
  className?: string,
  id?: string,
  style?: ReactDOM.Style.t,
  onClick?: JsxEvent.Mouse.t => unit,
  onKeyDown?: JsxEvent.Keyboard.t => unit,
  @as("data-slot") dataSlot?: string,
}

type providerProps = {
  children?: React.element,
  autoScroll?: bool,
  defaultScrollPosition?: DefaultScrollPosition.t,
  scrollEdgeThreshold?: float,
  scrollPreviousItemPeek?: float,
  scrollMargin?: float,
}

module Provider = {
  @module("@shadcn/react/message-scroller") @scope("MessageScroller")
  external make: React.component<providerProps> = "Provider"
}

module Root = {
  @module("@shadcn/react/message-scroller") @scope("MessageScroller")
  external make: React.component<divProps> = "Root"
}

module Viewport = {
  type props = {
    ...divProps,
    preserveScrollOnPrepend?: bool,
    @as("aria-label") ariaLabel?: string,
    role?: string,
    tabIndex?: int,
  }

  @module("@shadcn/react/message-scroller") @scope("MessageScroller")
  external make: React.component<props> = "Viewport"
}

module Content = {
  type props = {
    ...divProps,
    spacerClassName?: string,
    @as("aria-relevant") ariaRelevant?: string,
    @as("aria-busy") ariaBusy?: bool,
    role?: string,
  }

  @module("@shadcn/react/message-scroller") @scope("MessageScroller")
  external make: React.component<props> = "Content"
}

module Item = {
  type props = {
    ...divProps,
    messageId?: string,
    scrollAnchor?: bool,
  }

  @module("@shadcn/react/message-scroller") @scope("MessageScroller")
  external make: React.component<props> = "Item"
}

module Button = {
  type props = {
    ...divProps,
    @as("aria-label") ariaLabel?: string,
    @as("type") type_?: string,
    @as("data-direction") dataDirection?: Direction.t,
    @as("data-variant") dataVariant?: string,
    @as("data-size") dataSize?: string,
    behavior?: ScrollBehavior.t,
    direction?: Direction.t,
    render?: React.element,
  }

  @module("@shadcn/react/message-scroller") @scope("MessageScroller")
  external make: React.component<props> = "Button"
}
