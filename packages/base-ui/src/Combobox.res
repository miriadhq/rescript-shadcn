module Root = {
  type props<'item, 'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    items?: array<'item>,
    autoHighlight?: bool,
    itemToStringLabel?: 'item => string,
    itemToStringValue?: 'item => string,
    isItemEqualToValue?: ('item, 'item) => bool,
    defaultValue?: 'value,
  }
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<props<'value, 'value, 'checked>> = "Root"

  module Multiple = {
    type props<'item, 'checked> = {
      ...props<'item, array<'item>, 'checked>,
      multiple?: Types.OnlyTrue.t,
    }
    @module("@base-ui/react/combobox") @scope("Combobox")
    external make: React.component<props<'value, 'checked>> = "Root"
  }
}

module Value = {
  type props<'value> = {
    children?: 'value => React.element,
    placeholder?: React.element,
    ...Types.DataProps.t,
    ...Types.AriaProps.t,
  }
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<props<'value>> = "Value"
}

module Input = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Input"
}

module Trigger = {
  type props<'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    ...Types.NativeButtonProps.t,
  }
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<props<'value, 'checked>> = "Trigger"
}

module List = {
  type props<'item> = {
    children: ('item, int) => React.element,
    render?: React.element,
    style?: ReactDOM.Style.t,
    className?: string,
    ...Types.DataProps.t,
    ...Types.AriaProps.t,
  }
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<props<'item>> = "List"
}

module Status = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Status"
}

module Portal = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Portal"
}

module Backdrop = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Backdrop"
}

module Positioner = {
  type props<'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    ...AnchorPositioning.SharedParameters.t,
  }
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<props<'value, 'checked>> = "Positioner"
}

module Popup = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Popup"
}

module Arrow = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Arrow"
}

module Icon = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Icon"
}

module Group = {
  type props<'value> = {
    children?: React.element,
    items?: array<'value>,
    className?: string,
    style?: ReactDOM.Style.t,
    render?: React.element,
    ...Types.DataProps.t,
    ...Types.AriaProps.t,
  }
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<props<'value>> = "Group"
}

module GroupLabel = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "GroupLabel"
}

module Item = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Item"
}

module ItemIndicator = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "ItemIndicator"
}

module Chips = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Chips"
}

module Chip = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Chip"
}

module ChipRemove = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "ChipRemove"
}

module Row = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Row"
}

module Collection = {
  type props<'item> = {
    children: ('item, int) => React.element,
    ...Types.DataProps.t,
    ...Types.AriaProps.t,
  }
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<props<'item>> = "Collection"
}

module Empty = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Empty"
}

module Clear = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Clear"
}

module Separator = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Separator"
}
