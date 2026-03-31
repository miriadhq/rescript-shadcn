module Root = {
  type props<'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
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
  }
  @module("@base-ui/react/slider") @scope("Slider")
  external make: React.component<props<'value, 'checked>> = "Root"
}

module Value = {
  @module("@base-ui/react/slider") @scope("Slider")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Value"
}

module Control = {
  @module("@base-ui/react/slider") @scope("Slider")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Control"
}

module Track = {
  @module("@base-ui/react/slider") @scope("Slider")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Track"
}

module Thumb = {
  @module("@base-ui/react/slider") @scope("Slider")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Thumb"
}

module Indicator = {
  @module("@base-ui/react/slider") @scope("Slider")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Indicator"
}
