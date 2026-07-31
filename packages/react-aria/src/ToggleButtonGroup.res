type props = {
  ...Common.baseProps,
  selectedKeys?: array<string>,
  defaultSelectedKeys?: array<string>,
  onSelectionChange?: array<string> => unit,
  isDisabled?: bool,
  selectionMode?: Common.selectionMode,
  disallowEmptySelection?: bool,
  orientation?: Common.orientation,
}

@module("react-aria-components")
external make: React.component<props> = "ToggleButtonGroup"
