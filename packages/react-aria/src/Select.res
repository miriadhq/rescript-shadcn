type item<'value> = {
  label: string,
  value: 'value,
}

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
  isDisabled?: bool,
  isRequired?: bool,
  name?: string,
  placeholder?: string,
}

@module("react-aria-components")
external make: React.component<props<'item, 'key>> = "Select"

module Value = {
  type props<'item> = {
    ...Common.baseProps,
    placeholder?: string,
  }

  @module("react-aria-components")
  external make: React.component<props<'item>> = "SelectValue"
}

module Item = {
  type t<'value> = item<'value>
  type props<'value> = {
    ...Common.baseProps,
    value?: 'value,
    textValue?: string,
    isDisabled?: bool,
  }

  @module("react-aria-components")
  external make: React.component<props<'value>> = "ListBoxItem"
}

module List = {
  @module("react-aria-components")
  external make: React.component<Common.baseProps> = "ListBox"
}

module Group = {
  type props<'item> = {
    ...Common.baseProps,
    items?: array<'item>,
    value?: 'item,
  }

  @module("react-aria-components")
  external make: React.component<props<'item>> = "ListBoxSection"
}

module GroupLabel = {
  @module("react-aria-components")
  external make: React.component<Types.BaseUIComponentProps.t> = "Header"
}
