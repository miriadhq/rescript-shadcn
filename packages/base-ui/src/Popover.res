module Root = {
  module Actions = {
    type t = {
      unmount: unit => unit,
      close: unit => unit,
    }
  }

  type handle<'payload>

  type props<'payload> = {
    ...Types.BaseUIComponentProps.t,
    defaultOpen?: bool,
    onOpenChange?: (
      bool,
      Types.BaseUIChangeEventDetail.t<
        [
          | #"trigger-hover"
          | #"trigger-focus"
          | #"trigger-press"
          | #"outside-press"
          | #"escape-key"
          | #"close-press"
          | #"focus-out"
          | #"imperative-action"
          | #none
        ],
        unknown,
      >,
    ) => unit,
    onOpenChangeComplete?: bool => unit,
    actionsRef?: React.ref<Actions.t>,
    modal?: Types.Modal.t,
    triggerId?: string,
    defaultTriggerId?: string,
    handle?: handle<'payload>,
  }
  @module("@base-ui/react/popover") @scope("Popover")
  external make: React.component<props<'payload>> = "Root"
}

module Trigger = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    ...Types.NativeButtonProps.t,
  }
  @module("@base-ui/react/popover") @scope("Popover")
  external make: React.component<props> = "Trigger"
}

module Portal = {
  @module("@base-ui/react/popover") @scope("Popover")
  external make: React.component<Types.BaseUIComponentProps.t> = "Portal"
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
  @module("@base-ui/react/popover") @scope("Popover")
  external make: React.component<Types.BaseUIComponentProps.t> = "Popup"
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
  @module("@base-ui/react/popover") @scope("Popover")
  external make: React.component<Types.BaseUIComponentProps.t> = "Close"
}

module Viewport = {
  @module("@base-ui/react/popover") @scope("Popover")
  external make: React.component<Types.BaseUIComponentProps.t> = "Viewport"
}
