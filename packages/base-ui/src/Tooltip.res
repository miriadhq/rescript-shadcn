module Root = {
  module Actions = {
    type t = {
      unmount: unit => unit,
      close: unit => unit,
    }
  }

  module Handle = {
    type t<'payload> = private {
      @as("open") open_: (~triggerId: string) => unit,
      @as("close") close_: unit => unit,
      isOpen: unit => unit,
    }

    @module("@base-ui/react/tooltip") @scope("Tooltip")
    external make: unit => t<'payload> = "createHandle"
  }

  type props<'payload> = {
    ...Types.BaseUIComponentProps.t<string, bool>,
    defaultOpen?: bool,
    delay?: float,
    closeDelay?: float,
    onOpenChange?: (
      bool,
      Types.BaseUIChangeEventDetail.t<
        [
          | #"trigger-hover"
          | #"trigger-focus"
          | #"trigger-press"
          | #"outside-press"
          | #"escape-key"
          | #disabled
          | #"imperative-action"
          | #none
        ],
        unknown,
      >,
    ) => unit,
    onOpenChangeComplete?: bool => unit,
    disableHoverablePopup?: bool,
    trackCursorAxis?: [#none | #x | #y | #both],
    actionsRef?: React.ref<Actions.t>,
    handle?: Handle.t<'payload>,
    triggerId?: string,
    defaultTriggerId?: string,
  }
  @module("@base-ui/react/tooltip") @scope("Tooltip")
  external make: React.component<props<'payload>> = "Root"
}

module Trigger = {
  @module("@base-ui/react/tooltip") @scope("Tooltip")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Trigger"
}

module Portal = {
  @module("@base-ui/react/tooltip") @scope("Tooltip")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Portal"
}

module Positioner = {
  type props<'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    ...AnchorPositioning.SharedParameters.t,
  }
  @module("@base-ui/react/tooltip") @scope("Tooltip")
  external make: React.component<props<'value, 'checked>> = "Positioner"
}

module Popup = {
  @module("@base-ui/react/tooltip") @scope("Tooltip")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Popup"
}

module Arrow = {
  @module("@base-ui/react/tooltip") @scope("Tooltip")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Arrow"
}

module Provider = {
  type props = {
    children?: React.element,
    delay?: float,
    closeDelay?: float,
    timeout?: float,
  }
  @module("@base-ui/react/tooltip") @scope("Tooltip")
  external make: React.component<props> = "Provider"
}

module Viewport = {
  @module("@base-ui/react/tooltip") @scope("Tooltip")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Viewport"
}
