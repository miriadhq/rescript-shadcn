module ChangeEvent = {
  type details = Types.BaseUIChangeEventDetail.t<
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
  >
}

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
    modal?: bool,
    onOpenChange?: (bool, ChangeEvent.details) => unit,
    onOpenChangeComplete?: bool => unit,
    closeParentOnEsc?: bool,
    actionsRef?: React.ref<Actions.t>,
    triggerId?: string,
    defaultTriggerId?: string,
    handle?: handle<'payload>,
  }
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<props<'payload, 'value, 'checked>> = "Root"
}

module Trigger = {
  type props<'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    ...Types.NativeButtonProps.t,
  }
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<props<'value, 'checked>> = "Trigger"
}

module Portal = {
  type props<'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    container?: Dom.element,
    keepMounted?: bool,
  }
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<props<'value, 'checked>> = "Portal"
}

module Positioner = {
  type props<'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    ...AnchorPositioning.SharedParameters.t,
  }
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<props<'value, 'checked>> = "Positioner"
}

module Popup = {
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Popup"
}

module Item = {
  type props<'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    ...Types.NonNativeButtonProps.t,
    closeOnClick?: bool,
  }
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<props<'value, 'checked>> = "Item"
}

module Group = {
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Group"
}

module GroupLabel = {
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "GroupLabel"
}

module CheckboxItem = {
  type props<'value> = {
    ...Types.BaseUIComponentProps.t<'value, bool>,
    ...Types.NonNativeButtonProps.t,
    defaultChecked?: bool,
    onCheckedChange?: (bool, ChangeEvent.details) => unit,
    closeOnClick?: bool,
  }
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<props<'value>> = "CheckboxItem"
}

module CheckboxItemIndicator = {
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> =
    "CheckboxItemIndicator"
}

module RadioGroup = {
  type props<'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    onValueChange?: ('value, ChangeEvent.details) => unit,
  }
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<props<'value, 'checked>> = "RadioGroup"
}

module RadioItem = {
  type props<'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    ...Types.NonNativeButtonProps.t,
    closeOnClick?: bool,
  }
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<props<'value, 'checked>> = "RadioItem"
}

module RadioItemIndicator = {
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> =
    "RadioItemIndicator"
}

module SubmenuRoot = {
  type props<'payload, 'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    defaultOpen?: bool,
    loopFocus?: bool,
    highlightItemOnHover?: bool,
    onOpenChange?: (bool, ChangeEvent.details) => unit,
    onOpenChangeComplete?: bool => unit,
    closeParentOnEsc?: bool,
    actionsRef?: React.ref<Root.Actions.t>,
    triggerId?: string,
    defaultTriggerId?: string,
    handle?: Root.handle<'payload>,
  }
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<props<'payload, 'value, 'checked>> = "SubmenuRoot"
}

module SubmenuTrigger = {
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "SubmenuTrigger"
}

module Arrow = {
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Arrow"
}

module Backdrop = {
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Backdrop"
}

module Separator = {
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Separator"
}
