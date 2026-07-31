type props = Common.inputProps

@module("react-aria-components")
external make: React.component<props> = "Input"

module TextArea = {
  @module("react-aria-components")
  external make: React.component<Common.inputProps> = "TextArea"
}
