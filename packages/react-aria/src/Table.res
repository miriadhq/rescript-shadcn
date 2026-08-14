type props = {
  ...Common.elementProps,
  selectionMode?: Common.selectionMode,
  selectedKeys?: array<string>,
  defaultSelectedKeys?: array<string>,
  onSelectionChange?: Common.selection => unit,
  disabledKeys?: array<string>,
  selectionBehavior?: Common.selectionBehavior,
  disallowEmptySelection?: bool,
  disabledBehavior?: Common.disabledBehavior,
  onRowAction?: string => unit,
  sortDescriptor?: JSON.t,
  onSortChange?: JSON.t => unit,
  expandedKeys?: array<string>,
  defaultExpandedKeys?: array<string>,
  onExpandedChange?: Set.t<string> => unit,
}

@module("react-aria-components")
external make: React.component<props> = "Table"

module Header = {
  type props<'item> = {
    ...Common.elementProps,
    items?: array<'item>,
    dependencies?: array<JSON.t>,
  }

  @module("react-aria-components")
  external make: React.component<props<'item>> = "TableHeader"
}

module Body = {
  type props<'item> = {
    ...Common.elementProps,
    items?: array<'item>,
    renderEmptyState?: unit => React.element,
  }

  @module("react-aria-components")
  external make: React.component<props<'item>> = "TableBody"
}

module Footer = {
  type props<'item> = {...Common.elementProps, items?: array<'item>}

  @module("react-aria-components")
  external make: React.component<props<'item>> = "TableFooter"
}

module Row = {
  type props<'item> = {
    ...Common.elementProps,
    value?: 'item,
    columns?: array<'item>,
    dependencies?: array<JSON.t>,
    textValue?: string,
    isDisabled?: bool,
    disabledBehavior?: Common.disabledBehavior,
    hasChildItems?: bool,
    href?: string,
    target?: string,
    rel?: string,
    download?: string,
    onAction?: unit => unit,
  }

  @module("react-aria-components")
  external make: React.component<props<'item>> = "Row"
}

module Column = {
  @unboxed
  type size = Number(float) | String(string)

  type props = {
    ...Common.elementProps,
    textValue?: string,
    isRowHeader?: bool,
    allowsSorting?: bool,
    width?: size,
    defaultWidth?: size,
    minWidth?: size,
    maxWidth?: size,
  }

  @module("react-aria-components")
  external make: React.component<props> = "Column"
}

module Cell = {
  type props = {...Common.elementProps, textValue?: string, colSpan?: int}

  @module("react-aria-components")
  external make: React.component<props> = "Cell"
}
