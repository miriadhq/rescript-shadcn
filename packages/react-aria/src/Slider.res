type state = {
  values: array<float>,
}

type renderProps = {
  orientation: Types.Orientation.t,
  isDisabled: bool,
  state: state,
}

type componentProps<'value> = {
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

type props<'value> = {...componentProps<'value>, children: renderProps => React.element}
external toProps: componentProps<'value> => props<'value> = "%identity"

@module("react-aria-components")
external make: React.component<props<'value>> = "Slider"

module Track = {
  type props = Common.elementProps
  @module("react-aria-components")
  external make: React.component<props> = "SliderTrack"
}

module Fill = {
  type props = Common.elementProps
  @module("react-aria-components")
  external make: React.component<props> = "SliderFill"
}

module Thumb = {
  type props = {...Common.elementProps, index?: int, isDisabled?: bool}

  @module("react-aria-components")
  external make: React.component<props> = "SliderThumb"
}

module Output = {
  @module("react-aria-components")
  external make: React.component<Common.elementProps> = "SliderOutput"
}
