/** Direct binding for React Aria's DisclosureGroup export. */
type props = {
  ...Common.baseProps,
  expandedKeys?: Set.t<string>,
  defaultExpandedKeys?: Set.t<string>,
  onExpandedChange?: Set.t<string> => unit,
  isDisabled?: bool,
  allowsMultipleExpanded?: bool,
}

@module("react-aria-components")
external make: React.component<props> = "DisclosureGroup"
