module Root = {
  type props<'value> = {
    ...Types.BaseUIComponentProps.t,
    minStepsBetweenValues?: float,
    largeStep?: float,
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
