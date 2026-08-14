type renderProps = {
  percentage: nullable<float>,
  valueText: nullable<string>,
  isIndeterminate: bool,
}

type componentProps = {
  ...Common.baseProps,
  value?: float,
  minValue?: float,
  maxValue?: float,
  valueLabel?: string,
  formatOptions?: JSON.t,
  isIndeterminate?: bool,
}

type props = {...componentProps, children: renderProps => React.element}
external toProps: componentProps => props = "%identity"

@module("react-aria-components")
external make: React.component<props> = "ProgressBar"
