type props = {
  ...Common.buttonProps,
  isDisabled?: bool,
  preventFocusOnPress?: bool,
  allowFocusWhenDisabled?: bool,
  excludeFromTabOrder?: bool,
  name?: string,
  value?: string,
  form?: string,
  formAction?: string,
  formMethod?: string,
  formNoValidate?: bool,
  formTarget?: string,
  @as("type") type_?: string,
}

@module("react-aria-components")
external make: React.component<props> = "Button"

module Link = {
  type renderProps = {
    children?: React.element,
    className?: string,
    href?: string,
    target?: string,
    rel?: string,
    @as("aria-current") ariaCurrent?: string,
    @as("data-slot") dataSlot?: string,
  }

  type props = {
    ...Common.elementProps,
    isDisabled?: bool,
    href?: string,
    target?: string,
    rel?: string,
    download?: string,
    render?: renderProps => React.element,
  }

  @module("react-aria-components")
  external make: React.component<props> = "Link"
}
