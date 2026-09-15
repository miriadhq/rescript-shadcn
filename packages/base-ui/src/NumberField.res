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
  type props = {...Types.BaseUIComponentProps.t, ...Types.NativeButtonProps.t}
  @module("@base-ui/react/number-field") @scope("NumberField")
  external make: React.component<props> = "Increment"
}

module Decrement = {
  type props = {...Types.BaseUIComponentProps.t, ...Types.NativeButtonProps.t}
  @module("@base-ui/react/number-field") @scope("NumberField")
  external make: React.component<props> = "Decrement"
}

module Input = {
  type props = {...Types.BaseUIComponentProps.t, @as("type") type_?: string}
  @module("@base-ui/react/number-field") @scope("NumberField")
  external make: React.component<props> = "Input"
}

module ScrubArea = {
  @module("@base-ui/react/number-field") @scope("NumberField")
  external make: React.component<Types.BaseUIComponentProps.t> = "ScrubArea"
}

module ScrubAreaCursor = {
  @module("@base-ui/react/number-field") @scope("NumberField")
  external make: React.component<Types.BaseUIComponentProps.t> = "ScrubAreaCursor"
}
