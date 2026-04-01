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

  type props<'payload> = {
    ...Types.BaseUIComponentProps.t,
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
  external make: React.component<props<'payload>> = "Root"
}

module Trigger = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    ...Types.NativeButtonProps.t,
  }
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<props> = "Trigger"
}

module Portal = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    container?: Dom.element,
    keepMounted?: bool,
  }
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<props> = "Portal"
}

module Positioner = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    ...AnchorPositioning.SharedParameters.t,
  }
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<props> = "Positioner"
}

module Popup = {
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<Types.BaseUIComponentProps.t> = "Popup"
}

module Item = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    ...Types.NonNativeButtonProps.t,
    closeOnClick?: bool,
  }
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<props> = "Item"
}

module Group = {
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<Types.BaseUIComponentProps.t> = "Group"
}

module GroupLabel = {
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<Types.BaseUIComponentProps.t> = "GroupLabel"
}

module CheckboxItem = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    ...Types.NonNativeButtonProps.t,
    checked?: bool,
    defaultChecked?: bool,
    onCheckedChange?: (bool, ChangeEvent.details) => unit,
    closeOnClick?: bool,
  }
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<props> = "CheckboxItem"
}

module CheckboxItemIndicator = {
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<Types.BaseUIComponentProps.t> = "CheckboxItemIndicator"
}

module RadioGroup = {
  type props<'value> = {
    ...Types.BaseUIComponentProps.t,
    value?: 'value,
    defaultValue?: 'value,
    onValueChange?: ('value, ChangeEvent.details) => unit,
  }
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<props<'value>> = "RadioGroup"
}

module RadioItem = {
  type props<'value> = {
    ...Types.BaseUIComponentProps.t,
    ...Types.NonNativeButtonProps.t,
    value: 'value,
    closeOnClick?: bool,
  }
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<props<'value>> = "RadioItem"
}

module RadioItemIndicator = {
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<Types.BaseUIComponentProps.t> = "RadioItemIndicator"
}

module SubmenuRoot = {
  type props<'payload> = {
    ...Types.BaseUIComponentProps.t,
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
  external make: React.component<props<'payload>> = "SubmenuRoot"
}

module SubmenuTrigger = {
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<Types.BaseUIComponentProps.t> = "SubmenuTrigger"
}

module Arrow = {
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<Types.BaseUIComponentProps.t> = "Arrow"
}

module Backdrop = {
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<Types.BaseUIComponentProps.t> = "Backdrop"
}

module Separator = {
  @module("@base-ui/react/menu") @scope("Menu")
  external make: React.component<Types.BaseUIComponentProps.t> = "Separator"
}
