module Root = {
  @module("@base-ui/react/progress") @scope("Progress")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Root"
}

module Track = {
  @module("@base-ui/react/progress") @scope("Progress")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Track"
}

module Indicator = {
  @module("@base-ui/react/progress") @scope("Progress")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Indicator"
}

module Value = {
  @module("@base-ui/react/progress") @scope("Progress")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Value"
}

module Label = {
  @module("@base-ui/react/progress") @scope("Progress")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Label"
}
