module State = {
  type t = {
    values: array<float>,
  }
}

module RenderProps = {
  type t = {
    orientation: Types.Orientation.t,
    isDisabled: bool,
    state: State.t,
  }
}

module ComponentProps = {
  type t<'value> = {
    ...Common.BaseProps.t,
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
}

type props<'value> = {...ComponentProps.t<'value>, children?: RenderProps.t => React.element}

@module("react-aria-components")
external make: React.component<props<'value>> = "Slider"

module Track = {
  type props = Common.ElementProps.t
  @module("react-aria-components")
  external make: React.component<props> = "SliderTrack"
}

module Fill = {
  type props = Common.ElementProps.t
  @module("react-aria-components")
  external make: React.component<props> = "SliderFill"
}

module Thumb = {
  type props = {...Common.ElementProps.t, index?: int, isDisabled?: bool}

  @module("react-aria-components")
  external make: React.component<props> = "SliderThumb"
}

module Output = {
  @module("react-aria-components")
  external make: React.component<Common.ElementProps.t> = "SliderOutput"
}
