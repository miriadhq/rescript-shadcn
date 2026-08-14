/** Direct binding for React Aria's DisclosureGroup export. */
type props = {
  ...Common.elementProps,
  expandedKeys?: array<string>,
  defaultExpandedKeys?: array<string>,
  onExpandedChange?: Set.t<string> => unit,
  isDisabled?: bool,
  allowsMultipleExpanded?: bool,
}

@module("react-aria-components")
external make: React.component<props> = "DisclosureGroup"
