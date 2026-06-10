module Root = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    value?: float,
    defaultValue?: float,
    onValueChange?: (float, Types.BaseUIChangeEventDetail.t<[#none], unknown>) => unit,
    onValueCommitted?: (float, Types.BaseUIChangeEventDetail.t<[#none], unknown>) => unit,
    largeStep?: float,
    smallStep?: float,
  }
  @module("@base-ui/react/number-field") @scope("NumberField")
  external make: React.component<props> = "Root"
}

module Group = {
  @module("@base-ui/react/number-field") @scope("NumberField")
  external make: React.component<Types.BaseUIComponentProps.t> = "Group"
}

module Increment = {
  @module("@base-ui/react/number-field") @scope("NumberField")
  external make: React.component<Types.BaseUIComponentProps.t> = "Increment"
}

module Decrement = {
  @module("@base-ui/react/number-field") @scope("NumberField")
  external make: React.component<Types.BaseUIComponentProps.t> = "Decrement"
}

module Input = {
  @module("@base-ui/react/number-field") @scope("NumberField")
  external make: React.component<Types.BaseUIComponentProps.t> = "Input"
}

module ScrubArea = {
  @module("@base-ui/react/number-field") @scope("NumberField")
  external make: React.component<Types.BaseUIComponentProps.t> = "ScrubArea"
}

module ScrubAreaCursor = {
  @module("@base-ui/react/number-field") @scope("NumberField")
  external make: React.component<Types.BaseUIComponentProps.t> = "ScrubAreaCursor"
}
