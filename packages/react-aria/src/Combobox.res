module SelectionMode = {
  @unboxed
  type t =
    | @as("single") Single
    | @as("multiple") Multiple
}

type props<'item, 'key> = {
  ...Common.ElementProps.t,
  items?: array<'item>,
  value?: 'key,
  defaultValue?: 'key,
  onChange?: 'key => unit,
  selectionMode?: SelectionMode.t,
  selectedKey?: 'key,
  defaultSelectedKey?: 'key,
  onSelectionChange?: 'key => unit,
  inputValue?: string,
  defaultInputValue?: string,
  onInputChange?: string => unit,
  isDisabled?: bool,
  isRequired?: bool,
  isReadOnly?: bool,
  name?: string,
  allowsCustomValue?: bool,
  allowsEmptyCollection?: bool,
  isInvalid?: bool,
}

@module("react-aria-components")
external make: React.component<props<'item, 'key>> = "ComboBox"

module State = {
  type t<'value> = {
    inputValue: string,
    value: 'value,
    setValue: nullable<'value> => unit,
  }
}

@module("react-aria-components")
external stateContext: React.Context.t<nullable<State.t<'value>>> = "ComboBoxStateContext"

module Value = {
  module RenderState = {
    type t<'item, 'value> = {
      selectedItems: array<null<'item>>,
      selectedText: string,
      isPlaceholder: bool,
      state: State.t<'value>,
    }
  }

  type props<'item, 'value> = {
    className?: string,
    id?: string,
    style?: ReactDOM.Style.t,
    @as("data-slot") dataSlot?: string,
    children?: RenderState.t<'item, 'value> => React.element,
    placeholder?: React.element,
  }

  @module("react-aria-components")
  external make: React.component<props<'item, 'value>> = "ComboBoxValue"
}

module List = {
  module RenderState = {
    type t = {
      isEmpty: bool,
      isFocused: bool,
      isFocusVisible: bool,
    }
  }

  type props<'item> = {
    ...Common.BaseProps.t,
    items?: array<'item>,
    renderEmptyState?: RenderState.t => React.element,
    children?: 'item => React.element,
  }

  @module("react-aria-components")
  external make: React.component<props<'item>> = "ListBox"
}

module Collection = {
  type props<'item> = {children?: 'item => React.element, items?: array<'item>}

  @module("react-aria-components")
  external make: React.component<props<'item>> = "Collection"

  module Static = {
    type props = {children?: React.element}

    @module("react-aria-components")
    external make: React.component<props> = "Collection"
  }

  module Flexible = {
    type props<'item, 'children> = {children?: 'children, items?: array<'item>}

    @module("react-aria-components")
    external make: React.component<props<'item, 'children>> = "Collection"
  }
}

module Item = {
  type props<'item, 'key> = Select.Item.props<'item, 'key>

  @module("react-aria-components")
  external make: React.component<props<'item, 'key>> = "ListBoxItem"
}

module Group = {
  type props<'item, 'children> = Select.Group.props<'item, 'children>

  @module("react-aria-components")
  external make: React.component<props<'item, 'children>> = "ListBoxSection"
}

module GroupLabel = {
  @module("react-aria-components")
  external make: React.component<Common.ElementProps.t> = "Header"
}
