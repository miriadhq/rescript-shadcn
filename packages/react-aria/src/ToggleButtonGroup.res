type componentProps = {
  ...Common.baseProps,
  selectedKeys?: array<string>,
  defaultSelectedKeys?: array<string>,
  onSelectionChange?: Set.t<string> => unit,
  isDisabled?: bool,
  selectionMode?: Common.selectionMode,
  disallowEmptySelection?: bool,
  orientation?: Common.orientation,
}

type props = {...componentProps, children?: React.element}
external toProps: componentProps => props = "%identity"

@module("react-aria-components")
external make: React.component<props> = "ToggleButtonGroup"
