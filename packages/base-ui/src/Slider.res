module Root = {
  type props<'value> = {
    ...Types.BaseUIComponentProps.t,
    min?: float,
    max?: float,
    minStepsBetweenValues?: float,
    largeStep?: float,
    locale?: string,
    thumbAlignment?: Types.ThumbAlignment.t,
    thumbCollisionBehavior?: Types.ThumbCollisionBehavior.t,
    onValueChange?: (
      'value,
      Types.BaseUIChangeEventDetail.t<
        [#"input-change" | #"track-press" | #drag | #keyboard | #none],
        unknown,
      >,
    ) => unit,
    onValueCommitted?: (
      'value,
      Types.BaseUIChangeEventDetail.t<
        [#"input-change" | #"track-press" | #drag | #keyboard | #none],
        unknown,
      >,
    ) => unit,
    defaultValue?: 'value,
    value?: 'value,
  }
  @module("@base-ui/react/slider") @scope("Slider")
  external make: React.component<props<'value>> = "Root"
}

module Root1 = {
  @module("@base-ui/react/slider") @scope("Slider")
  external make: React.component<Root.props<float>> = "Root"
}

module Root2 = {
  @module("@base-ui/react/slider") @scope("Slider")
  external make: React.component<Root.props<(float, float)>> = "Root"
}

module Root3 = {
  @module("@base-ui/react/slider") @scope("Slider")
  external make: React.component<Root.props<(float, float, float)>> = "Root"
}

module Root4 = {
  @module("@base-ui/react/slider") @scope("Slider")
  external make: React.component<Root.props<(float, float, float, float)>> = "Root"
}

module RootMultiple = {
  @module("@base-ui/react/slider") @scope("Slider")
  external make: React.component<Root.props<array<float>>> = "Root"
}

module Label = {
  @module("@base-ui/react/slider") @scope("Slider")
  external make: React.component<Types.BaseUIComponentProps.t> = "Label"
}

module Value = {
  @module("@base-ui/react/slider") @scope("Slider")
  external make: React.component<Types.BaseUIComponentProps.t> = "Value"
}

module Control = {
  @module("@base-ui/react/slider") @scope("Slider")
  external make: React.component<Types.BaseUIComponentProps.t> = "Control"
}

module Track = {
  @module("@base-ui/react/slider") @scope("Slider")
  external make: React.component<Types.BaseUIComponentProps.t> = "Track"
}

module Thumb = {
  @module("@base-ui/react/slider") @scope("Slider")
  external make: React.component<Types.BaseUIComponentProps.t> = "Thumb"
}

module Indicator = {
  @module("@base-ui/react/slider") @scope("Slider")
  external make: React.component<Types.BaseUIComponentProps.t> = "Indicator"
}
