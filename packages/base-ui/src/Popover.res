/** Imperative link between [Root] and [Trigger] (see `createPopoverHandle` in Base UI). */
module Handle = {
  type t<'payload>

  @module("@base-ui/react/popover") @scope("Popover")
  external make: unit => t<'payload> = "createHandle"

  @send
  external open_: (t<'payload>, string) => unit = "open"

  @send
  external close: t<'payload> => unit = "close"

  @get
  external isOpen: t<'payload> => bool = "isOpen"
}

module Root = {
  module Actions = {
    type t = {
      unmount: unit => unit,
      close: unit => unit,
    }
  }

  type changeEventReason = [
    | #"trigger-hover"
    | #"trigger-focus"
    | #"trigger-press"
    | #"outside-press"
    | #"escape-key"
    | #"close-press"
    | #"focus-out"
    | #"imperative-action"
    | #none
  ]

  /** Base UI extends [Types.BaseUIChangeEventDetail] with [preventUnmountOnClose]. */
  type changeEventDetails = {
    ...Types.BaseUIChangeEventDetail.t<changeEventReason, unknown>,
    preventUnmountOnClose: unit => unit,
  }

  type props<'payload> = {
    children?: React.element,
    defaultOpen?: bool,
    @as("open")
    open_?: bool,
    onOpenChange?: (bool, changeEventDetails) => unit,
    onOpenChangeComplete?: bool => unit,
    actionsRef?: React.ref<Actions.t>,
    modal?: Types.Modal.t,
    triggerId?: string,
    defaultTriggerId?: string,
    handle?: Handle.t<'payload>,
  }

  @module("@base-ui/react/popover") @scope("Popover")
  external make: React.component<props<'payload>> = "Root"
}

module Trigger = {
  type props<'payload> = {
    ...Types.BaseUIComponentProps.t,
    ...Types.NativeButtonProps.t,
    handle?: Handle.t<'payload>,
    payload?: 'payload,
    openOnHover?: bool,
    delay?: float,
    closeDelay?: float,
  }

  @module("@base-ui/react/popover") @scope("Popover")
  external make: React.component<props<'payload>> = "Trigger"
}

module Portal = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    container?: Dom.element,
    keepMounted?: bool,
  }

  @module("@base-ui/react/popover") @scope("Popover")
  external make: React.component<props> = "Portal"
}

module Positioner = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    ...AnchorPositioning.SharedParameters.t,
  }

  @module("@base-ui/react/popover") @scope("Popover")
  external make: React.component<props> = "Positioner"
}

module Popup = {
  module InitialFocus = {
    @unboxed
    type t =
      | @as(true) True
      | @as(false) False
      | Ref(ReactDOM.domRef)
  }
  type props = {
    ...Types.BaseUIComponentProps.t,
    /** `true` / `false` cover the boolean cases; ref and callback shapes need an escape hatch at the call site. */
    initialFocus?: InitialFocus.t,
    finalFocus?: bool,
  }

  @module("@base-ui/react/popover") @scope("Popover")
  external make: React.component<props> = "Popup"
}

module Arrow = {
  @module("@base-ui/react/popover") @scope("Popover")
  external make: React.component<Types.BaseUIComponentProps.t> = "Arrow"
}

module Backdrop = {
  @module("@base-ui/react/popover") @scope("Popover")
  external make: React.component<Types.BaseUIComponentProps.t> = "Backdrop"
}

module Title = {
  @module("@base-ui/react/popover") @scope("Popover")
  external make: React.component<Types.BaseUIComponentProps.t> = "Title"
}

module Description = {
  @module("@base-ui/react/popover") @scope("Popover")
  external make: React.component<Types.BaseUIComponentProps.t> = "Description"
}

module Close = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    ...Types.NativeButtonProps.t,
  }

  @module("@base-ui/react/popover") @scope("Popover")
  external make: React.component<props> = "Close"
}

module Viewport = {
  @module("@base-ui/react/popover") @scope("Popover")
  external make: React.component<Types.BaseUIComponentProps.t> = "Viewport"
}
