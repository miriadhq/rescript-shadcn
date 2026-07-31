type props = {
  ...Common.baseProps,
  value: string,
  isDisabled?: bool,
}

@module("react-aria-components")
external make: React.component<props> = "Radio"

module Field = {
  @module("react-aria-components")
  external make: React.component<props> = "RadioField"
}

module Button = {
  @module("react-aria-components")
  external make: React.component<Common.baseProps> = "RadioButton"
}
