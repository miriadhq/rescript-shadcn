type props<'item> = {
  ...Common.ElementProps.t,
  items?: array<'item>,
  isDisabled?: bool,
  onAction?: string => unit,
}

@module("react-aria-components")
external make: React.component<props<'item>> = "Breadcrumbs"

module Item = {
  module RenderProps = {
    type t = {isCurrent: bool, isDisabled: bool}
  }

  module ComponentProps = {
    type t = Common.BaseProps.t
  }

  type props = {...ComponentProps.t, children?: React.element}

  @module("react-aria-components")
  external make: React.component<props> = "Breadcrumb"
}
