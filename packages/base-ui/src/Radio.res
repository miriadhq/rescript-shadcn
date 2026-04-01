module Root = {
  type props<'value> = {
    ...Types.BaseUIComponentProps.t,
    ...Types.NonNativeButtonProps.t,
    value: 'value,
  }
  @module("@base-ui/react/radio") @scope("Radio")
  external make: React.component<props<'value>> = "Root"
}

module Indicator = {
  @module("@base-ui/react/radio") @scope("Radio")
  external make: React.component<Types.BaseUIComponentProps.t> = "Indicator"
}
