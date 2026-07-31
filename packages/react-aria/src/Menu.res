type props<'item> = {
  ...Common.baseProps,
  items?: array<'item>,
  selectionMode?: Common.selectionMode,
  selectedKeys?: array<string>,
  defaultSelectedKeys?: array<string>,
  onSelectionChange?: Common.selection => unit,
  disabledKeys?: array<string>,
  shouldCloseOnSelect?: bool,
}

@module("react-aria-components")
external make: React.component<props<'item>> = "Menu"

module Trigger = {
  type props = {
    children?: React.element,
    isOpen?: bool,
    defaultOpen?: bool,
    onOpenChange?: bool => unit,
  }

  @module("react-aria-components")
  external make: React.component<props> = "MenuTrigger"
}

module Item = {
  type props<'item> = {
    ...Common.baseProps,
    value?: 'item,
    textValue?: string,
    isDisabled?: bool,
    onAction?: unit => unit,
    shouldCloseOnSelect?: bool,
  }

  @module("react-aria-components")
  external make: React.component<props<'item>> = "MenuItem"
}

module Section = {
  @module("react-aria-components")
  external make: React.component<Common.baseProps> = "MenuSection"
}

module SubmenuTrigger = {
  type props = {children?: React.element, delay?: float}

  @module("react-aria-components")
  external make: React.component<props> = "SubmenuTrigger"
}
