module Items = {
  @unboxed
  type value = String(string) | Number(float) | BigInt(bigint) | Bool(bool)
  type t<'item>
  type options<'item> = {getValue: 'item => value, getLabel: 'item => string}
  type group<'item> = {items: array<'item>}

  /** Items must have unique primitive values and must not have an `items` array field. */
  @module("@base-ui/react/combobox") @scope("Combobox")
  external create: (option<array<'item>>, options<'item>) => t<'item> = "createItems"

  @module("@base-ui/react/combobox") @scope("Combobox")
  external createGrouped: (option<array<group<'item>>>, options<'item>) => t<'item> = "createItems"
}

module Root = {
  module Actions = {
    type t = {
      unmount: unit => unit,
    }
  }

  type sharedProps<'item, 'value, 'selection, 'items> = {
    ...Types.BaseUIComponentProps.t,
    items?: 'items,
    inputValue?: string,
    defaultInputValue?: string,
    openOnInputClick?: bool,
    grid?: bool,
    filteredItems?: array<'item>,
    virtualized?: bool,
    inline?: bool,
    limit?: float,
    locale?: string,
    autoHighlight?: bool,
    highlightItemOnHover?: bool,
    itemToStringLabel?: 'value => string,
    itemToStringValue?: 'value => string,
    isItemEqualToValue?: ('value, 'value) => bool,
    defaultValue?: 'selection,
    value?: 'selection,
    actionsRef?: React.ref<Actions.t>,
    onOpenChange?: (bool, Types.BaseUIChangeEventDetail.t<[#none], unknown>) => unit,
    onInputValueChange?: (string, Types.BaseUIChangeEventDetail.t<[#none], unknown>) => unit,
    onItemHighlighted?: (
      option<'value>,
      Types.BaseUIChangeEventDetail.t<[#keyboard | #pointer | #none], unknown>,
    ) => unit,
    onValueChange?: ('selection, Types.BaseUIChangeEventDetail.t<[#none], unknown>) => unit,
  }
  type props<'item, 'value> = {...sharedProps<'item, 'item, 'value, array<'item>>}

  module WithItems = {
    type props<'item> = {...sharedProps<'item, Items.value, nullable<Items.value>, Items.t<'item>>}
    @module("@base-ui/react/combobox") @scope("Combobox")
    external make: React.component<props<'item>> = "Root"

    module Multiple = {
      type props<'item> = {
        ...sharedProps<'item, Items.value, array<Items.value>, Items.t<'item>>,
        multiple?: Types.OnlyTrue.t,
      }
      @module("@base-ui/react/combobox") @scope("Combobox")
      external make: React.component<props<'item>> = "Root"
    }
  }

  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<props<'item, 'value>> = "Root"

  module Multiple = {
    type props<'item> = {
      ...sharedProps<'item, 'item, array<'item>, array<'item>>,
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
    @as("type") type_?: string,
    ...Types.BaseUIComponentProps.t,
    value?: string,
    onValueChange?: (string, Types.BaseUIChangeEventDetail.t<[#none], unknown>) => unit,
    defaultValue?: string,
  }
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<props> = "Input"
}

module Label = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t> = "Label"
}

module InputGroup = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t> = "InputGroup"
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
  type props = {...Types.BaseUIComponentProps.t, ...Types.NativeButtonProps.t}
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<props> = "ChipRemove"
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
  type props = {...Types.BaseUIComponentProps.t, ...Types.NativeButtonProps.t}
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<props> = "Clear"
}

module Separator = {
  @module("@base-ui/react/combobox") @scope("Combobox")
  external make: React.component<Types.BaseUIComponentProps.t> = "Separator"
}
