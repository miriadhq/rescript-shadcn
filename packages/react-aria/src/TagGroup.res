type props = {
  ...Common.elementProps,
  onRemove?: Set.t<string> => unit,
}

@module("react-aria-components")
external make: React.component<props> = "TagGroup"

module List = {
  type props<'item> = {
    ...Common.baseProps,
    items?: array<'item>,
    children?: 'item => React.element,
    renderEmptyState?: Common.renderState => React.element,
  }

  @module("react-aria-components")
  external make: React.component<props<'item>> = "TagList"
}

module Item = {
  type props = {
    ...Common.elementProps,
    textValue?: string,
    isDisabled?: bool,
    onAction?: unit => unit,
    href?: string,
    target?: string,
    rel?: string,
    download?: string,
  }

  @module("react-aria-components")
  external make: React.component<props> = "Tag"
}
