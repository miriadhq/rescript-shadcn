type props<'item> = {
  ...Common.ElementProps.t,
  items?: array<'item>,
  selectionMode?: Common.SelectionMode.t,
  selectedKeys?: array<string>,
  defaultSelectedKeys?: array<string>,
  onSelectionChange?: Common.Selection.t => unit,
  disabledKeys?: array<string>,
  selectionBehavior?: Common.SelectionBehavior.t,
  disallowEmptySelection?: bool,
  disabledBehavior?: Common.DisabledBehavior.t,
  autoFocus?: Common.AutoFocus.t,
  shouldFocusWrap?: bool,
  onAction?: (string, 'item) => unit,
  onClose?: unit => unit,
  escapeKeyBehavior?: Common.EscapeKeyBehavior.t,
  renderEmptyState?: unit => React.element,
  dependencies?: array<JSON.t>,
  shouldCloseOnSelect?: bool,
}

@module("react-aria-components")
external make: React.component<props<'item>> = "Menu"

module Trigger = {
  type props = {
    ...Common.ElementProps.t,
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
    ...Common.ElementProps.t,
    @as("className") renderClassName?: Common.ItemRenderProps.t => string,
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
  module ComponentProps = {
    type t<'item> = {
      ...Common.BaseProps.t,
      items?: array<'item>,
      selectionMode?: Common.SelectionMode.t,
      selectedKeys?: array<string>,
      defaultSelectedKeys?: array<string>,
      onSelectionChange?: Common.Selection.t => unit,
      disabledKeys?: array<string>,
      selectionBehavior?: Common.SelectionBehavior.t,
      disallowEmptySelection?: bool,
      disabledBehavior?: Common.DisabledBehavior.t,
      shouldCloseOnSelect?: bool,
    }
  }

  type props<'item> = {...ComponentProps.t<'item>, children?: React.element}

  @module("react-aria-components")
  external make: React.component<props<'item>> = "MenuSection"
}

module SubmenuTrigger = {
  type props = {...Common.ElementProps.t, delay?: float}

  @module("react-aria-components")
  external make: React.component<props> = "SubmenuTrigger"
}
