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
  external make: React.component<props<'payload, 'value, 'checked>> = "Root"
}

module Trigger = {
  type props<'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    ...Types.NativeButtonProps.t,
  }
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<props<'value, 'checked>> = "Trigger"
}

module Backdrop = {
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Backdrop"
}

module Portal = {
  type props<'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    container?: Dom.element,
    keepMounted?: bool,
  }
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<props<'value, 'checked>> = "Portal"
}

module Positioner = {
  type props<'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    ...AnchorPositioning.SharedParameters.t,
  }
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<props<'value, 'checked>> = "Positioner"
}

module Popup = {
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Popup"
}

module Arrow = {
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Arrow"
}

module Group = {
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Group"
}

module GroupLabel = {
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "GroupLabel"
}

module Item = {
  type props<'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    ...Types.NonNativeButtonProps.t,
    closeOnClick?: bool,
  }
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<props<'value, 'checked>> = "Item"
}

module CheckboxItem = {
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<Menu.CheckboxItem.props<'value>> = "CheckboxItem"
}

module CheckboxItemIndicator = {
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> =
    "CheckboxItemIndicator"
}

module RadioGroup = {
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<Menu.RadioGroup.props<'value, 'checked>> = "RadioGroup"
}

module RadioItem = {
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<Menu.RadioItem.props<'value, 'checked>> = "RadioItem"
}

module RadioItemIndicator = {
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> =
    "RadioItemIndicator"
}

module SubmenuRoot = {
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<Menu.SubmenuRoot.props<'payload, 'value, 'checked>> = "SubmenuRoot"
}

module SubmenuTrigger = {
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "SubmenuTrigger"
}

module Separator = {
  @module("@base-ui/react/context-menu") @scope("ContextMenu")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Separator"
}
