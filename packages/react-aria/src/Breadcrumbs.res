type props<'item> = {
  ...Common.elementProps,
  items?: array<'item>,
  isDisabled?: bool,
  onAction?: string => unit,
}

@module("react-aria-components")
external make: React.component<props<'item>> = "Breadcrumbs"

module Item = {
  type renderProps = {isCurrent: bool, isDisabled: bool}

  type componentProps = Common.baseProps
  type props = {...componentProps, children: renderProps => React.element}
  external toProps: componentProps => props = "%identity"

  @module("react-aria-components")
  external make: React.component<props> = "Breadcrumb"
}
