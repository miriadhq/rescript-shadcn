module Root = {
  module Actions = {
    type t = {
      unmount: unit => unit,
      close: unit => unit,
    }
  }

  module Handle = {
    type t<'payload>
  }

  module ChangeEventDetails = {
    type t = Types.BaseUIChangeEventDetail.t<
      [
        | #"trigger-press"
        | #"outside-press"
        | #"escape-key"
        | #"close-press"
        | #"focus-out"
        | #"imperative-action"
        | #none
      ],
      unknown,
    >
  }

  type props<'payload> = {
    ...Types.BaseUIComponentProps.t,
    defaultOpen?: bool,
    modal?: Types.Modal.t,
    onOpenChange?: (bool, ChangeEventDetails.t) => unit,
    onOpenChangeComplete?: bool => unit,
    disablePointerDismissal?: bool,
    actionsRef?: React.ref<Actions.t>,
    handle?: Handle.t<'payload>,
    triggerId?: string,
    defaultTriggerId?: string,
  }
  @module("@base-ui/react/dialog") @scope("Dialog")
  external make: React.component<props<'payload>> = "Root"
}

module Trigger = {
  type props<'payload> = {
    ...Types.BaseUIComponentProps.t,
    ...Types.NativeButtonProps.t,
    handle?: Root.Handle.t<'payload>,
    payload?: 'payload,
  }
  @module("@base-ui/react/dialog") @scope("Dialog")
  external make: React.component<props<'payload>> = "Trigger"
}

module Portal = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    container?: Dom.element,
    keepMounted?: bool,
  }
  @module("@base-ui/react/dialog") @scope("Dialog")
  external make: React.component<props> = "Portal"
}

module Popup = {
  @module("@base-ui/react/dialog") @scope("Dialog")
  external make: React.component<Types.BaseUIComponentProps.t> = "Popup"
}

module Backdrop = {
  @module("@base-ui/react/dialog") @scope("Dialog")
  external make: React.component<Types.BaseUIComponentProps.t> = "Backdrop"
}

module Title = {
  @module("@base-ui/react/dialog") @scope("Dialog")
  external make: React.component<Types.BaseUIComponentProps.t> = "Title"
}

module Description = {
  @module("@base-ui/react/dialog") @scope("Dialog")
  external make: React.component<Types.BaseUIComponentProps.t> = "Description"
}

module Close = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    ...Types.NativeButtonProps.t,
  }
  @module("@base-ui/react/dialog") @scope("Dialog")
  external make: React.component<props> = "Close"
}

module Viewport = {
  @module("@base-ui/react/dialog") @scope("Dialog")
  external make: React.component<Types.BaseUIComponentProps.t> = "Viewport"
}
