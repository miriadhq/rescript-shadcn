module Root = {
  module Actions = {
    type t = {
      @as("open") open_: unit => unit,
      close: unit => unit,
    }
  }

  module Handle = {
    type t<'payload> = private {
      @as("open") open_: (~triggerId: string) => unit,
      @as("close") close_: unit => unit,
      isOpen: unit => unit,
    }

    @module("@base-ui/react/preview-card") @scope("PreviewCard")
    external make: unit => t<'payload> = "createHandle"
  }

  type props<'payload> = {
    ...Types.BaseUIComponentProps.t,
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
          | #"imperative-action"
          | #none
        ],
        unknown,
      >,
    ) => unit,
    onOpenChangeComplete?: bool => unit,
    actionsRef?: React.ref<Actions.t>,
    handle?: Handle.t<'payload>,
    triggerId?: string,
    defaultTriggerId?: string,
  }
  @module("@base-ui/react/preview-card") @scope("PreviewCard")
  external make: React.component<props<'payload>> = "Root"
}

module Trigger = {
  type props<'payload> = {
    ...Types.BaseUIComponentProps.t,
    handle?: Root.Handle.t<'payload>,
    payload?: 'payload,
    delay?: float,
    closeDelay?: float,
  }
  @module("@base-ui/react/preview-card") @scope("PreviewCard")
  external make: React.component<props<'payload>> = "Trigger"
}

module Portal = {
  @module("@base-ui/react/preview-card") @scope("PreviewCard")
  external make: React.component<Types.BaseUIComponentProps.t> = "Portal"
}

module Positioner = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    ...AnchorPositioning.SharedParameters.t,
  }
  @module("@base-ui/react/preview-card") @scope("PreviewCard")
  external make: React.component<props> = "Positioner"
}

module Popup = {
  @module("@base-ui/react/preview-card") @scope("PreviewCard")
  external make: React.component<Types.BaseUIComponentProps.t> = "Popup"
}

module Arrow = {
  @module("@base-ui/react/preview-card") @scope("PreviewCard")
  external make: React.component<Types.BaseUIComponentProps.t> = "Arrow"
}

module Backdrop = {
  @module("@base-ui/react/preview-card") @scope("PreviewCard")
  external make: React.component<Types.BaseUIComponentProps.t> = "Backdrop"
}

module Viewport = {
  @module("@base-ui/react/preview-card") @scope("PreviewCard")
  external make: React.component<Types.BaseUIComponentProps.t> = "Viewport"
}
