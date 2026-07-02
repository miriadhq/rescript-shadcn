module Root = {
  module AutoHighlight = {
    @unboxed
    type t =
      | @as(true) True
      | @as(false) False
      | @as("always") Always
  }

  type props<'item> = {
    ...Types.BaseUIComponentProps.t,
    items?: array<'item>,
    autoHighlight?: AutoHighlight.t,
    keepHighlight?: bool,
    highlightItemOnHover?: bool,
    grid?: bool,
    filteredItems?: array<'item>,
    virtualized?: bool,
    inline?: bool,
    limit?: float,
    locale?: string,
    itemToStringLabel?: 'item => string,
    itemToStringValue?: 'item => string,
    defaultValue?: string,
    value?: string,
    inputRef?: ReactDOM.domRef,
    onValueChange?: (string, Types.BaseUIChangeEventDetail.t<[#none], unknown>) => unit,
    submitOnItemClick?: bool,
    onOpenChange?: (bool, Types.BaseUIChangeEventDetail.t<[#none], unknown>) => unit,
    onItemHighlighted?: (
      'item,
      Types.BaseUIChangeEventDetail.t<[#keyboard | #pointer | #none], unknown>,
    ) => unit,
    openOnInputClick?: bool,
  }
  @module("@base-ui/react/autocomplete") @scope("Autocomplete")
  external make: React.component<props<'item>> = "Root"
}

module Value = {
  type props = {
    children?: string => React.element,
    ...Types.DataProps.t,
    ...Types.AriaProps.t,
  }
  @module("@base-ui/react/autocomplete") @scope("Autocomplete")
  external make: React.component<props> = "Value"
}

module Input = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    value?: string,
    onValueChange?: (string, Types.BaseUIChangeEventDetail.t<[#none], unknown>) => unit,
    defaultValue?: string,
  }
  @module("@base-ui/react/autocomplete") @scope("Autocomplete")
  external make: React.component<props> = "Input"
}

module InputGroup = {
  @module("@base-ui/react/autocomplete") @scope("Autocomplete")
  external make: React.component<Types.BaseUIComponentProps.t> = "InputGroup"
}

module Trigger = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    ...Types.NativeButtonProps.t,
  }
  @module("@base-ui/react/autocomplete") @scope("Autocomplete")
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
  @module("@base-ui/react/autocomplete") @scope("Autocomplete")
  external make: React.component<props<'item>> = "List"
}

module Status = {
  @module("@base-ui/react/autocomplete") @scope("Autocomplete")
  external make: React.component<Types.BaseUIComponentProps.t> = "Status"
}

module Portal = {
  @module("@base-ui/react/autocomplete") @scope("Autocomplete")
  external make: React.component<Types.BaseUIComponentProps.t> = "Portal"
}

module Backdrop = {
  @module("@base-ui/react/autocomplete") @scope("Autocomplete")
  external make: React.component<Types.BaseUIComponentProps.t> = "Backdrop"
}

module Positioner = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    ...AnchorPositioning.SharedParameters.t,
  }
  @module("@base-ui/react/autocomplete") @scope("Autocomplete")
  external make: React.component<props> = "Positioner"
}

module Popup = {
  @module("@base-ui/react/autocomplete") @scope("Autocomplete")
  external make: React.component<Types.BaseUIComponentProps.t> = "Popup"
}

module Arrow = {
  @module("@base-ui/react/autocomplete") @scope("Autocomplete")
  external make: React.component<Types.BaseUIComponentProps.t> = "Arrow"
}

module Icon = {
  @module("@base-ui/react/autocomplete") @scope("Autocomplete")
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
  @module("@base-ui/react/autocomplete") @scope("Autocomplete")
  external make: React.component<props<'value>> = "Group"
}

module GroupLabel = {
  @module("@base-ui/react/autocomplete") @scope("Autocomplete")
  external make: React.component<Types.BaseUIComponentProps.t> = "GroupLabel"
}

module Item = {
  type props<'value> = {
    ...Types.BaseUIComponentProps.t,
    ...Types.NonNativeButtonProps.t,
    value?: 'value,
    index?: int,
  }
  @module("@base-ui/react/autocomplete") @scope("Autocomplete")
  external make: React.component<props<'value>> = "Item"
}

module Collection = {
  type props<'item> = {
    children: ('item, int) => React.element,
    ...Types.DataProps.t,
    ...Types.AriaProps.t,
  }
  @module("@base-ui/react/autocomplete") @scope("Autocomplete")
  external make: React.component<props<'item>> = "Collection"
}

module Row = {
  @module("@base-ui/react/autocomplete") @scope("Autocomplete")
  external make: React.component<Types.BaseUIComponentProps.t> = "Row"
}

module Empty = {
  @module("@base-ui/react/autocomplete") @scope("Autocomplete")
  external make: React.component<Types.BaseUIComponentProps.t> = "Empty"
}

module Clear = {
  @module("@base-ui/react/autocomplete") @scope("Autocomplete")
  external make: React.component<Types.BaseUIComponentProps.t> = "Clear"
}

module Separator = {
  @module("@base-ui/react/autocomplete") @scope("Autocomplete")
  external make: React.component<Types.BaseUIComponentProps.t> = "Separator"
}
