type props<'item> = {
  ...Common.elementProps,
  items?: array<'item>,
  selectionMode?: Common.selectionMode,
  selectedKeys?: array<string>,
  defaultSelectedKeys?: array<string>,
  onSelectionChange?: Common.selection => unit,
  disabledKeys?: array<string>,
  selectionBehavior?: Common.selectionBehavior,
  disallowEmptySelection?: bool,
  disabledBehavior?: Common.disabledBehavior,
  autoFocus?: Common.autoFocus,
  shouldFocusWrap?: bool,
  onAction?: (string, 'item) => unit,
  onClose?: unit => unit,
  escapeKeyBehavior?: Common.escapeKeyBehavior,
  renderEmptyState?: unit => React.element,
  dependencies?: array<JSON.t>,
  shouldCloseOnSelect?: bool,
}

@module("react-aria-components")
external make: React.component<props<'item>> = "Menu"

module Trigger = {
  type props = {
    ...Common.elementProps,
    isOpen?: bool,
    defaultOpen?: bool,
    onOpenChange?: bool => unit,
    isDisabled?: bool,
    trigger?: string,
  }

  @module("react-aria-components")
  external make: React.component<props> = "MenuTrigger"
}

module Item = {
  type props<'item> = {
    ...Common.elementProps,
    value?: 'item,
    textValue?: string,
    isDisabled?: bool,
    onAction?: unit => unit,
    shouldCloseOnSelect?: bool,
    href?: string,
    target?: string,
    rel?: string,
    download?: string,
  }

  @module("react-aria-components")
  external make: React.component<props<'item>> = "MenuItem"
}

module Section = {
  type componentProps<'item> = {
    ...Common.baseProps,
    items?: array<'item>,
    selectionMode?: Common.selectionMode,
    selectedKeys?: array<string>,
    defaultSelectedKeys?: array<string>,
    onSelectionChange?: Common.selection => unit,
    disabledKeys?: array<string>,
    selectionBehavior?: Common.selectionBehavior,
    disallowEmptySelection?: bool,
    disabledBehavior?: Common.disabledBehavior,
    shouldCloseOnSelect?: bool,
  }

  type props<'item> = {...componentProps<'item>, children?: React.element}
  external toProps: componentProps<'item> => props<'item> = "%identity"

  @module("react-aria-components")
  external make: React.component<props<'item>> = "MenuSection"
}

module SubmenuTrigger = {
  type props = {...Common.elementProps, delay?: float}

  @module("react-aria-components")
  external make: React.component<props> = "SubmenuTrigger"
}
