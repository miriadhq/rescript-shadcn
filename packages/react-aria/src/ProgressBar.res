module RenderProps = {
  type t = {
    percentage: nullable<float>,
    valueText: nullable<string>,
    isIndeterminate: bool,
  }
}

module ComponentProps = {
  type t = {
    ...Common.BaseProps.t,
    value?: float,
    minValue?: float,
    maxValue?: float,
    valueLabel?: string,
    formatOptions?: JSON.t,
    isIndeterminate?: bool,
  }
}

type props = {...ComponentProps.t, children?: React.element}

@module("react-aria-components")
external make: React.component<props> = "ProgressBar"
