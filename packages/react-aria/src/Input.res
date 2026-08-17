type props = Common.InputProps.t

@module("react-aria-components")
external make: React.component<props> = "Input"

module TextArea = {
  type props = Common.InputProps.t

  @module("react-aria-components")
  external make: React.component<props> = "TextArea"
}
