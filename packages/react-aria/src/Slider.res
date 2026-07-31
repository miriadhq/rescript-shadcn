type props<'value> = {
  ...Common.baseProps,
  name?: string,
  value?: 'value,
  defaultValue?: 'value,
  onChange?: 'value => unit,
  onChangeEnd?: 'value => unit,
  minValue?: float,
  maxValue?: float,
  step?: float,
  isDisabled?: bool,
  orientation?: Types.Orientation.t,
}

@module("react-aria-components")
external make: React.component<props<'value>> = "Slider"

module Track = {
  @module("react-aria-components")
  external make: React.component<Common.baseProps> = "SliderTrack"
}

module Fill = {
  @module("react-aria-components")
  external make: React.component<Common.baseProps> = "SliderFill"
}

module Thumb = {
  type props = {...Common.baseProps, index?: int, isDisabled?: bool}

  @module("react-aria-components")
  external make: React.component<props> = "SliderThumb"
}

module Output = {
  @module("react-aria-components")
  external make: React.component<Common.baseProps> = "SliderOutput"
}
