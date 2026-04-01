module Root = {
  type props<'item, 'value> = {
    ...Types.BaseUIComponentProps.t,
    items?: array<'item>,
    autoHighlight?: bool,
    itemToStringLabel?: 'item => string,
    itemToStringValue?: 'item => string,
    isItemEqualToValue?: ('item, 'item) => bool,
    defaultValue?: 'value,
    value?: 'value,
  }
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<props<'item, 'value>> = "Root"

  module Multiple = {
    type props<'item> = {
      ...props<'item, array<'item>>,
      multiple?: Types.OnlyTrue.t,
    }
    @module("@base-ui/react/combobox") @scope("Combobox")
    external make: React.component<props<'item>> = "Root"
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
  type props = {
    ...Types.BaseUIComponentProps.t,
    value?: string,
    onValueChange?: (string, Types.BaseUIChangeEventDetail.t<[#none], unknown>) => unit,
    defaultValue?: string,
  }
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<props> = "Input"
}

module Trigger = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    ...Types.NativeButtonProps.t,
  }
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<props> = "Trigger"
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
  external make: React.component<Types.BaseUIComponentProps.t> = "Status"
}

module Portal = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t> = "Portal"
}

module Backdrop = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t> = "Backdrop"
}

module Positioner = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    ...AnchorPositioning.SharedParameters.t,
  }
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<props> = "Positioner"
}

module Popup = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t> = "Popup"
}

module Arrow = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t> = "Arrow"
}

module Icon = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t> = "Icon"
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
  external make: React.component<Types.BaseUIComponentProps.t> = "GroupLabel"
}

module Item = {
  type props<'value> = {
    ...Types.BaseUIComponentProps.t,
    ...Types.NonNativeButtonProps.t,
    value?: 'value,
    index?: int,
  }
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<props<'value>> = "Item"
}

module ItemIndicator = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t> = "ItemIndicator"
}

module Chips = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t> = "Chips"
}

module Chip = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t> = "Chip"
}

module ChipRemove = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t> = "ChipRemove"
}

module Row = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t> = "Row"
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
  external make: React.component<Types.BaseUIComponentProps.t> = "Empty"
}

module Clear = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t> = "Clear"
}

module Separator = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t> = "Separator"
}
