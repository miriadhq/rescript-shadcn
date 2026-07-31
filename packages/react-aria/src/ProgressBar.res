type props = {
  ...Common.baseProps,
  value?: float,
  minValue?: float,
  maxValue?: float,
  valueLabel?: string,
  formatOptions?: JSON.t,
  isIndeterminate?: bool,
}

@module("react-aria-components")
external make: React.component<props> = "ProgressBar"
