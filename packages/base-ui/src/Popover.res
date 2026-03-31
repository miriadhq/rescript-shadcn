module Root = {
  module Actions = {
    type t = {
      unmount: unit => unit,
      close: unit => unit,
    }
  }

  type handle<'payload>

  type props<'payload, 'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
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
  external make: React.component<props<'payload, 'value, 'checked>> = "Root"
}

module Trigger = {
  type props<'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    ...Types.NativeButtonProps.t,
  }
  @module("@base-ui/react/popover") @scope("Popover")
  external make: React.component<props<'value, 'checked>> = "Trigger"
}

module Portal = {
  @module("@base-ui/react/popover") @scope("Popover")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Portal"
}

module Positioner = {
  type props<'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    ...AnchorPositioning.SharedParameters.t,
  }
  @module("@base-ui/react/popover") @scope("Popover")
  external make: React.component<props<'value, 'checked>> = "Positioner"
}

module Popup = {
  @module("@base-ui/react/popover") @scope("Popover")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Popup"
}

module Arrow = {
  @module("@base-ui/react/popover") @scope("Popover")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Arrow"
}

module Backdrop = {
  @module("@base-ui/react/popover") @scope("Popover")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Backdrop"
}

module Title = {
  @module("@base-ui/react/popover") @scope("Popover")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Title"
}

module Description = {
  @module("@base-ui/react/popover") @scope("Popover")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Description"
}

module Close = {
  @module("@base-ui/react/popover") @scope("Popover")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Close"
}

module Viewport = {
  @module("@base-ui/react/popover") @scope("Popover")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Viewport"
}
