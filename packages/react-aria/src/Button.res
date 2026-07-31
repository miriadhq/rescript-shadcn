type props = {
  ...Common.buttonProps,
  isDisabled?: bool,
  preventFocusOnPress?: bool,
  allowFocusWhenDisabled?: bool,
  excludeFromTabOrder?: bool,
  href?: string,
  target?: string,
  rel?: string,
  @as("type") type_?: string,
}

@module("react-aria-components")
external make: React.component<props> = "Button"

module Link = {
  @module("react-aria-components")
  external make: React.component<Common.buttonProps> = "Link"
}
