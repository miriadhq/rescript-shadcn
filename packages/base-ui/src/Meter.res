module Root = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    value?: float,
  }
  @module("@base-ui/react/meter") @scope("Meter")
  external make: React.component<props> = "Root"
}

module Track = {
  @module("@base-ui/react/meter") @scope("Meter")
  external make: React.component<Types.BaseUIComponentProps.t> = "Track"
}

module Indicator = {
  @module("@base-ui/react/meter") @scope("Meter")
  external make: React.component<Types.BaseUIComponentProps.t> = "Indicator"
}

module Value = {
  @module("@base-ui/react/meter") @scope("Meter")
  external make: React.component<Types.BaseUIComponentProps.t> = "Value"
}

module Label = {
  @module("@base-ui/react/meter") @scope("Meter")
  external make: React.component<Types.BaseUIComponentProps.t> = "Label"
}
