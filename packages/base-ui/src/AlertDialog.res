module Root = {
  type changeEventDetails = Dialog.Root.changeEventDetails
  type props<'payload> = {
    ...Types.BaseUIComponentProps.t,
    defaultOpen?: bool,
    onOpenChange?: (bool, changeEventDetails) => unit,
    onOpenChangeComplete?: bool => unit,
    actionsRef?: React.ref<Dialog.Root.Actions.t>,
    handle?: Dialog.Root.handle<'payload>,
    triggerId?: string,
    defaultTriggerId?: string,
  }
  @module("@base-ui/react/alert-dialog") @scope("AlertDialog")
  external make: React.component<props<'payload>> = "Root"
}

module Backdrop = {
  @module("@base-ui/react/alert-dialog") @scope("AlertDialog")
  external make: React.component<Types.BaseUIComponentProps.t> = "Backdrop"
}

module Close = {
  @module("@base-ui/react/alert-dialog") @scope("AlertDialog")
  external make: React.component<Dialog.Close.props> = "Close"
}

module Description = {
  @module("@base-ui/react/alert-dialog") @scope("AlertDialog")
  external make: React.component<Types.BaseUIComponentProps.t> = "Description"
}

module Popup = {
  @module("@base-ui/react/alert-dialog") @scope("AlertDialog")
  external make: React.component<Types.BaseUIComponentProps.t> = "Popup"
}

module Portal = {
  @module("@base-ui/react/alert-dialog") @scope("AlertDialog")
  external make: React.component<Dialog.Portal.props> = "Portal"
}

module Title = {
  @module("@base-ui/react/alert-dialog") @scope("AlertDialog")
  external make: React.component<Types.BaseUIComponentProps.t> = "Title"
}

module Trigger = {
  @module("@base-ui/react/alert-dialog") @scope("AlertDialog")
  external make: React.component<Dialog.Trigger.props<'payload>> = "Trigger"
}

module Viewport = {
  @module("@base-ui/react/alert-dialog") @scope("AlertDialog")
  external make: React.component<Types.BaseUIComponentProps.t> = "Viewport"
}
