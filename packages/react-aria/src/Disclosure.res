/** Direct bindings for React Aria's Disclosure and DisclosurePanel exports. */
type props = {
  ...Common.ElementProps.t,
  isExpanded?: bool,
  defaultExpanded?: bool,
  onExpandedChange?: bool => unit,
  isDisabled?: bool,
}

@module("react-aria-components")
external make: React.component<props> = "Disclosure"

module Panel = {
  type props = {
    ...Common.ElementProps.t,
    isHidden?: bool,
  }

  @module("react-aria-components")
  external make: React.component<props> = "DisclosurePanel"
}
