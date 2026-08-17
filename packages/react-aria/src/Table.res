type props = {
  ...Common.ElementProps.t,
  selectionMode?: Common.SelectionMode.t,
  selectedKeys?: array<string>,
  defaultSelectedKeys?: array<string>,
  onSelectionChange?: Common.Selection.t => unit,
  disabledKeys?: array<string>,
  selectionBehavior?: Common.SelectionBehavior.t,
  disallowEmptySelection?: bool,
  disabledBehavior?: Common.DisabledBehavior.t,
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
    ...Common.ElementProps.t,
    items?: array<'item>,
    dependencies?: array<JSON.t>,
  }

  @module("react-aria-components")
  external make: React.component<props<'item>> = "TableHeader"
}

module Body = {
  type props<'item> = {
    ...Common.ElementProps.t,
    items?: array<'item>,
    renderEmptyState?: unit => React.element,
  }

  @module("react-aria-components")
  external make: React.component<props<'item>> = "TableBody"
}

module Footer = {
  type props<'item> = {...Common.ElementProps.t, items?: array<'item>}

  @module("react-aria-components")
  external make: React.component<props<'item>> = "TableFooter"
}

module Row = {
  type props<'item> = {
    ...Common.ElementProps.t,
    value?: 'item,
    columns?: array<'item>,
    dependencies?: array<JSON.t>,
    textValue?: string,
    isDisabled?: bool,
    disabledBehavior?: Common.DisabledBehavior.t,
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
  module Size = {
    @unboxed
    type t = Number(float) | String(string)
  }

  type props = {
    ...Common.ElementProps.t,
    textValue?: string,
    isRowHeader?: bool,
    allowsSorting?: bool,
    width?: Size.t,
    defaultWidth?: Size.t,
    minWidth?: Size.t,
    maxWidth?: Size.t,
  }

  @module("react-aria-components")
  external make: React.component<props> = "Column"
}

module Cell = {
  type props = {...Common.ElementProps.t, textValue?: string, colSpan?: int}

  @module("react-aria-components")
  external make: React.component<props> = "Cell"
}
