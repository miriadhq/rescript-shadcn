module Item = {
  type t<'value> = {
    label: string,
    value: 'value,
  }
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Item"
}

module Root = {
  module Actions = {
    type t = {
      unmount: unit => unit,
    }
  }

  type props<'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
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
  }
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<props<'value, 'checked>> = "Root"

  module Multiple = {
    type props<'value, 'checked> = {
      ...props<array<'value>, 'checked>,
      multiple?: Types.OnlyTrue.t,
    }
    @module("@base-ui/react/select") @scope("Select")
    external make: React.component<props<'value, 'checked>> = "Root"
  }
}

module Trigger = {
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Trigger"
}

module Value = {
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Value"
}

module Icon = {
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Icon"
}

module Portal = {
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Portal"
}

module Backdrop = {
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Backdrop"
}

module Positioner = {
  /** See `SelectPositionerProps` in `@base-ui/react/select/positioner/SelectPositioner.d.ts`. */
  type props<'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    ...AnchorPositioning.SharedParameters.t,
    alignItemWithTrigger?: bool,
  }
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<props<'value, 'checked>> = "Positioner"
}

module Popup = {
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Popup"
}

module List = {
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "List"
}

module ItemIndicator = {
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "ItemIndicator"
}

module ItemText = {
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "ItemText"
}

module Arrow = {
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Arrow"
}

module ScrollDownArrow = {
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "ScrollDownArrow"
}

module ScrollUpArrow = {
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "ScrollUpArrow"
}

module Group = {
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Group"
}

module GroupLabel = {
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "GroupLabel"
}

module Separator = {
  @module("@base-ui/react/select") @scope("Select")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Separator"
}
