type item<'value> = {
  label: string,
  value: 'value,
}

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
  isDisabled?: bool,
  isInvalid?: bool,
  isRequired?: bool,
  name?: string,
  placeholder?: string,
}

@module("react-aria-components")
external make: React.component<props<'item, 'key>> = "Select"

module Value = {
  type renderProps<'item> = {
    defaultChildren: React.element,
    isPlaceholder: bool,
    selectedItems: array<'item>,
    selectedText: string,
  }

  external renderChildren: (renderProps<'item> => React.element) => React.element = "%identity"

  type props<'item> = {
    ...Common.elementProps,
    placeholder?: string,
  }

  @module("react-aria-components")
  external make: React.component<props<'item>> = "SelectValue"
}

module Item = {
  type t<'value> = item<'value>
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
    onPress?: Common.pressEvent => unit,
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
    ...Common.elementProps,
    items?: array<'item>,
    selectionMode?: Common.selectionMode,
    selectedKeys?: array<string>,
    defaultSelectedKeys?: array<string>,
    onSelectionChange?: Common.selection => unit,
    disabledKeys?: array<string>,
    renderEmptyState?: unit => React.element,
  }

  @module("react-aria-components")
  external make: React.component<props<'item>> = "ListBox"
}

module Group = {
  type props<'item, 'children> = {
    ...Common.baseProps,
    children?: 'children,
    items?: array<'item>,
    value?: 'item,
  }

  @module("react-aria-components")
  external make: React.component<props<'item, 'children>> = "ListBoxSection"
}

module GroupLabel = {
  @module("react-aria-components")
  external make: React.component<Common.elementProps> = "Header"
}
