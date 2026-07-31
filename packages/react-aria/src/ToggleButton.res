type props = {
  ...Common.buttonProps,
  isDisabled?: bool,
  isSelected?: bool,
  defaultSelected?: bool,
  onChange?: bool => unit,
  @as("type") type_?: string,
}

@module("react-aria-components")
external make: React.component<props> = "ToggleButton"
