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
  isDisabled?: bool,
  isInvalid?: bool,
  isRequired?: bool,
  name?: string,
  placeholder?: string,
}

@module("react-aria-components")
external make: React.component<props<'item, 'key>> = "Select"

module Value = {
  module RenderProps = {
    type t<'item> = {
      defaultChildren: React.element,
      isPlaceholder: bool,
      selectedItems: array<'item>,
      selectedText: string,
    }
  }

  type props<'item> = {
    ...Common.ElementProps.t,
    placeholder?: string,
  }

  @module("react-aria-components")
  external make: React.component<props<'item>> = "SelectValue"
}

module Item = {
  type t<'value> = {
    label: string,
    value: 'value,
  }
  type props<'value, 'key> = {
    key?: string,
    ref?: ReactDOM.domRef,
    className?: string,
    id?: 'key,
    style?: ReactDOM.Style.t,
    children?: React.element,
    @as("aria-label") ariaLabel?: string,
    @as("aria-labelledby") ariaLabelledby?: string,
    @as("aria-describedby") ariaDescribedby?: string,
    @as("data-slot") dataSlot?: string,
    onClick?: JsxEvent.Mouse.t => unit,
    onKeyDown?: JsxEvent.Keyboard.t => unit,
    onBlur?: JsxEvent.Focus.t => unit,
    onFocus?: JsxEvent.Focus.t => unit,
    onMouseEnter?: JsxEvent.Mouse.t => unit,
    onMouseLeave?: JsxEvent.Mouse.t => unit,
    onPress?: Common.PressEvent.t => unit,
    value?: 'value,
    textValue?: string,
    isDisabled?: bool,
    onAction?: unit => unit,
    href?: string,
    target?: string,
    rel?: string,
    download?: string,
  }

  @module("react-aria-components")
  external make: React.component<props<'value, 'key>> = "ListBoxItem"
}

module List = {
  type props<'item> = {
    ...Common.ElementProps.t,
    items?: array<'item>,
    selectionMode?: Common.SelectionMode.t,
    selectedKeys?: array<string>,
    defaultSelectedKeys?: array<string>,
    onSelectionChange?: Common.Selection.t => unit,
    disabledKeys?: array<string>,
    renderEmptyState?: unit => React.element,
  }

  @module("react-aria-components")
  external make: React.component<props<'item>> = "ListBox"
}

module Group = {
  type props<'item, 'children> = {
    ...Common.BaseProps.t,
    children?: 'children,
    items?: array<'item>,
    value?: 'item,
  }

  @module("react-aria-components")
  external make: React.component<props<'item, 'children>> = "ListBoxSection"
}

module GroupLabel = {
  @module("react-aria-components")
  external make: React.component<Common.ElementProps.t> = "Header"
}
