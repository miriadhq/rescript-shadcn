type props = Common.inputProps

@module("react-aria-components")
external make: React.component<props> = "Input"

module TextArea = {
  type props = Common.inputProps

  @module("react-aria-components")
  external make: React.component<props> = "TextArea"
}
