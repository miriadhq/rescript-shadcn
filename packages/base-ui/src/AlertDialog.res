module Root = {
  type changeEventDetails = Dialog.Root.changeEventDetails
  type props<'payload, 'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    defaultOpen?: bool,
    onOpenChange?: (bool, changeEventDetails) => unit,
    onOpenChangeComplete?: bool => unit,
    actionsRef?: React.ref<Dialog.Root.Actions.t>,
    handle?: Dialog.Root.handle<'payload>,
    triggerId?: string,
    defaultTriggerId?: string,
  }
  @module("@base-ui/react/alert-dialog") @scope("AlertDialog")
  external make: React.component<props<'payload, 'value, 'checked>> = "Root"
}

module Backdrop = {
  @module("@base-ui/react/alert-dialog") @scope("AlertDialog")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Backdrop"
}

module Close = {
  @module("@base-ui/react/alert-dialog") @scope("AlertDialog")
  external make: React.component<Dialog.Close.props<'value, 'checked>> = "Close"
}

module Description = {
  @module("@base-ui/react/alert-dialog") @scope("AlertDialog")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Description"
}

module Popup = {
  @module("@base-ui/react/alert-dialog") @scope("AlertDialog")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Popup"
}

module Portal = {
  @module("@base-ui/react/alert-dialog") @scope("AlertDialog")
  external make: React.component<Dialog.Portal.props<'value, 'checked>> = "Portal"
}

module Title = {
  @module("@base-ui/react/alert-dialog") @scope("AlertDialog")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Title"
}

module Trigger = {
  @module("@base-ui/react/alert-dialog") @scope("AlertDialog")
  external make: React.component<Dialog.Trigger.props<'payload, 'value, 'checked>> = "Trigger"
}

module Viewport = {
  @module("@base-ui/react/alert-dialog") @scope("AlertDialog")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Viewport"
}
