@unboxed
type selectionMode =
  | @as("single") Single
  | @as("multiple") Multiple

type props<'item, 'key> = {
  ...Common.elementProps,
  items?: array<'item>,
  value?: 'key,
  defaultValue?: 'key,
  onChange?: 'key => unit,
  selectionMode?: selectionMode,
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

type state<'value> = {
  inputValue: string,
  value: 'value,
  setValue: nullable<'value> => unit,
}

@module("react-aria-components")
external stateContext: React.Context.t<nullable<state<'value>>> = "ComboBoxStateContext"

module Value = {
  type renderState<'item, 'value> = {
    selectedItems: array<null<'item>>,
    selectedText: string,
    isPlaceholder: bool,
    state: state<'value>,
  }

  type props<'item, 'value> = {
    className?: string,
    id?: string,
    style?: ReactDOM.Style.t,
    @as("data-slot") dataSlot?: string,
    children?: renderState<'item, 'value> => React.element,
    placeholder?: React.element,
  }

  @module("react-aria-components")
  external make: React.component<props<'item, 'value>> = "ComboBoxValue"
}

module List = {
  type renderState = {
    isEmpty: bool,
    isFocused: bool,
    isFocusVisible: bool,
  }

  type props<'item> = {
    ...Common.baseProps,
    items?: array<'item>,
    renderEmptyState?: renderState => React.element,
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
  external make: React.component<Common.elementProps> = "Header"
}
