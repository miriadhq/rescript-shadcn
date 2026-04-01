module Item = {
  type t<'value> = {
    label: string,
    value: 'value,
  }
  type props<'value> = {
    ...Types.BaseUIComponentProps.t,
    ...Types.NonNativeButtonProps.t,
    value?: 'value,
  }
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<props<'value>> = "Item"
}

module Root = {
  module Actions = {
    type t = {
      unmount: unit => unit,
    }
  }

  type props<'value> = {
    ...Types.BaseUIComponentProps.t,
    inputRef?: ReactDOM.domRef,
    highlightItemOnHover?: bool,
    defaultOpen?: bool,
    onOpenChange?: (
      bool,
      Types.BaseUIChangeEventDetail.t<
        [
          | #"trigger-pressed"
          | #"outside-press"
          | #"escape-key"
          | #"window-resize"
          | #"item-press"
          | #"focus-out"
          | #"list-navigation"
          | #"cancel-open"
          | #none
        ],
        unknown,
      >,
    ) => unit,
    onOpenChangeComplete?: bool => unit,
    modal?: bool,
    actionsRef?: React.ref<Actions.t>,
    items?: array<Item.t<'value>>,
    itemToStringLabel?: 'value => string,
    itemToStringValue?: 'value => string,
    isItemEqualToValue?: ('value, 'value) => bool,
    onValueChange?: (
      'value,
      Types.BaseUIChangeEventDetail.t<
        [
          | #"trigger-pressed"
          | #"outside-press"
          | #"escape-key"
          | #"window-resize"
          | #"item-press"
          | #"focus-out"
          | #"list-navigation"
          | #"cancel-open"
          | #none
        ],
        unknown,
      >,
    ) => unit,
    defaultValue?: 'value,
    value?: 'value,
  }
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<props<'value>> = "Root"

  module Multiple = {
    type props<'value> = {
      ...props<array<'value>>,
      multiple?: Types.OnlyTrue.t,
    }
    @module("@base-ui/react/select") @scope("Select")
    external make: React.component<props<'value>> = "Root"
  }
}

module Trigger = {
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t> = "Trigger"
}

module Value = {
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t> = "Value"
}

module Icon = {
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t> = "Icon"
}

module Portal = {
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t> = "Portal"
}

module Backdrop = {
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t> = "Backdrop"
}

module Positioner = {
  /** See `SelectPositionerProps` in `@base-ui/react/select/positioner/SelectPositioner.d.ts`. */
  type props = {
    ...Types.BaseUIComponentProps.t,
    ...AnchorPositioning.SharedParameters.t,
    alignItemWithTrigger?: bool,
  }
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<props> = "Positioner"
}

module Popup = {
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t> = "Popup"
}

module List = {
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t> = "List"
}

module ItemIndicator = {
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t> = "ItemIndicator"
}

module ItemText = {
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t> = "ItemText"
}

module Arrow = {
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t> = "Arrow"
}

module ScrollDownArrow = {
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t> = "ScrollDownArrow"
}

module ScrollUpArrow = {
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t> = "ScrollUpArrow"
}

module Group = {
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t> = "Group"
}

module GroupLabel = {
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t> = "GroupLabel"
}

module Separator = {
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t> = "Separator"
}
