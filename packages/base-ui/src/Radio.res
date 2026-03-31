module Root = {
  type props<'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    ...Types.NonNativeButtonProps.t,
  }
  @module("@base-ui/react/radio") @scope("Radio")
  external make: React.component<props<'value, 'checked>> = "Root"
}

module Indicator = {
  @module("@base-ui/react/radio") @scope("Radio")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Indicator"
}
