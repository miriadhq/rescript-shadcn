module Root = {
  module Actions = {
    type t = {
      unmount: unit => unit,
      close: unit => unit,
    }
  }

  type handle<'payload>

  type changeEventDetails = Types.BaseUIChangeEventDetail.t<
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

  type props<'payload, 'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    defaultOpen?: bool,
    modal?: Types.Modal.t,
    onOpenChange?: (bool, changeEventDetails) => unit,
    onOpenChangeComplete?: bool => unit,
    disablePointerDismissal?: bool,
    actionsRef?: React.ref<Actions.t>,
    handle?: handle<'payload>,
    triggerId?: string,
    defaultTriggerId?: string,
  }
  @module("@base-ui/react/dialog") @scope("Dialog")
  external make: React.component<props<'payload, 'value, 'checked>> = "Root"
}

module Trigger = {
  type props<'payload, 'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    ...Types.NativeButtonProps.t,
    handle?: Root.handle<'payload>,
    payload?: 'payload,
  }
  @module("@base-ui/react/dialog") @scope("Dialog")
  external make: React.component<props<'payload, 'value, 'checked>> = "Trigger"
}

module Portal = {
  type props<'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    container?: Dom.element,
    keepMounted?: bool,
  }
  @module("@base-ui/react/dialog") @scope("Dialog")
  external make: React.component<props<'value, 'checked>> = "Portal"
}

module Popup = {
  @module("@base-ui/react/dialog") @scope("Dialog")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Popup"
}

module Backdrop = {
  @module("@base-ui/react/dialog") @scope("Dialog")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Backdrop"
}

module Title = {
  @module("@base-ui/react/dialog") @scope("Dialog")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Title"
}

module Description = {
  @module("@base-ui/react/dialog") @scope("Dialog")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Description"
}

module Close = {
  type props<'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    ...Types.NativeButtonProps.t,
  }
  @module("@base-ui/react/dialog") @scope("Dialog")
  external make: React.component<props<'value, 'checked>> = "Close"
}

module Viewport = {
  @module("@base-ui/react/dialog") @scope("Dialog")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Viewport"
}
