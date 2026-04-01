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
    loopFocus?: bool,
    highlightItemOnHover?: bool,
    onOpenChange?: (
      bool,
      Types.BaseUIChangeEventDetail.t<
        [
          | #"trigger-hover"
          | #"trigger-focus"
          | #"trigger-press"
          | #"outside-press"
          | #"focus-out"
          | #"list-navigation"
          | #"escape-key"
          | #"item-press"
          | #"close-press"
          | #"sibling-open"
          | #"cancel-open"
          | #"imperative-action"
          | #none
        ],
        unknown,
      >,
    ) => unit,
    onOpenChangeComplete?: bool => unit,
    modal?: bool,
    closeParentOnEsc?: bool,
    actionsRef?: React.ref<Actions.t>,
    triggerId?: string,
    defaultTriggerId?: string,
    handle?: handle<'payload>,
  }
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<props<'payload>> = "Root"
}

module Trigger = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    ...Types.NativeButtonProps.t,
  }
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<props> = "Trigger"
}

module Backdrop = {
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<Types.BaseUIComponentProps.t> = "Backdrop"
}

module Portal = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    container?: Dom.element,
    keepMounted?: bool,
  }
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<props> = "Portal"
}

module Positioner = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    ...AnchorPositioning.SharedParameters.t,
  }
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<props> = "Positioner"
}

module Popup = {
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<Types.BaseUIComponentProps.t> = "Popup"
}

module Arrow = {
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<Types.BaseUIComponentProps.t> = "Arrow"
}

module Group = {
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<Types.BaseUIComponentProps.t> = "Group"
}

module GroupLabel = {
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<Types.BaseUIComponentProps.t> = "GroupLabel"
}

module Item = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    ...Types.NonNativeButtonProps.t,
    closeOnClick?: bool,
  }
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<props> = "Item"
}

module CheckboxItem = {
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<Menu.CheckboxItem.props> = "CheckboxItem"
}

module CheckboxItemIndicator = {
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<Types.BaseUIComponentProps.t> = "CheckboxItemIndicator"
}

module RadioGroup = {
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<Menu.RadioGroup.props<'value>> = "RadioGroup"
}

module RadioItem = {
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<Menu.RadioItem.props<'value>> = "RadioItem"
}

module RadioItemIndicator = {
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<Types.BaseUIComponentProps.t> = "RadioItemIndicator"
}

module SubmenuRoot = {
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<Menu.SubmenuRoot.props<'payload>> = "SubmenuRoot"
}

module SubmenuTrigger = {
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<Types.BaseUIComponentProps.t> = "SubmenuTrigger"
}

module Separator = {
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<Types.BaseUIComponentProps.t> = "Separator"
}
