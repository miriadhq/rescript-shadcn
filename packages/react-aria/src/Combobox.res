@unboxed
type selectionMode =
  | @as("single") Single
  | @as("multiple") Multiple

type props<'item, 'key> = {
  ...Common.baseProps,
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
}

@module("react-aria-components")
external make: React.component<props<'item, 'key>> = "ComboBox"

module Value = {
  type renderState<'item> = {
    selectedItems: array<null<'item>>,
    selectedText: string,
    isPlaceholder: bool,
  }

  type props<'item> = {
    className?: string,
    id?: string,
    style?: ReactDOM.Style.t,
    @as("data-slot") dataSlot?: string,
    children?: renderState<'item> => React.element,
    placeholder?: React.element,
  }

  @module("react-aria-components")
  external make: React.component<props<'item>> = "ComboBoxValue"
}

module List = {
  type renderState = {
    isEmpty: bool,
    isFocused: bool,
    isFocusVisible: bool,
  }

  type props<'item> = {
    children: ('item, int) => React.element,
    items?: array<'item>,
    renderEmptyState?: renderState => React.element,
    className?: string,
    style?: ReactDOM.Style.t,
    @as("data-slot") dataSlot?: string,
  }

  @module("react-aria-components")
  external make: React.component<props<'item>> = "ListBox"
}

module Collection = {
  type props<'item> = {children: ('item, int) => React.element}

  @module("react-aria-components")
  external make: React.component<props<'item>> = "Collection"
}

module Item = {
  type props<'item> = Select.Item.props<'item>

  @module("react-aria-components")
  external make: React.component<props<'item>> = "ListBoxItem"
}

module Group = {
  type props<'item> = Select.Group.props<'item>

  @module("react-aria-components")
  external make: React.component<props<'item>> = "ListBoxSection"
}

module GroupLabel = {
  @module("react-aria-components")
  external make: React.component<Types.BaseUIComponentProps.t> = "Header"
}

module Chips = {
  @module("react-aria-components")
  external make: React.component<Types.BaseUIComponentProps.t> = "TagGroup"
}

module Chip = {
  @module("react-aria-components")
  external make: React.component<Types.BaseUIComponentProps.t> = "Tag"
}
