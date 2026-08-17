type props = {
  ...Common.ButtonProps.t,
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
  module RenderProps = {
    type t = Types.DomProps.t
  }

  type props = {
    ...Common.ElementProps.t,
    isDisabled?: bool,
    href?: string,
    target?: string,
    rel?: string,
    download?: string,
    render?: RenderProps.t => React.element,
  }

  @module("react-aria-components")
  external make: React.component<props> = "Link"
}
