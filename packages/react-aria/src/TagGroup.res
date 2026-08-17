type props = {
  ...Common.ElementProps.t,
  onRemove?: Set.t<string> => unit,
}

@module("react-aria-components")
external make: React.component<props> = "TagGroup"

module List = {
  type props<'item> = {
    ...Common.BaseProps.t,
    items?: array<'item>,
    children?: 'item => React.element,
    renderEmptyState?: Common.RenderState.t => React.element,
  }

  @module("react-aria-components")
  external make: React.component<props<'item>> = "TagList"
}

module Item = {
  type props = {
    ...Common.ElementProps.t,
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
