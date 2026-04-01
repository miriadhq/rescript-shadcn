module Root = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    ...Types.NonNativeButtonProps.t,
    checked?: bool,
    onCheckedChange?: (bool, Types.BaseUIChangeEventDetail.t<[#none], unknown>) => unit,
    indeterminate?: bool,
    inputRef?: ReactDOM.domRef,
    parent?: bool,
    uncheckedValue?: string,
    defaultChecked?: bool,
    value?: string,
  }
  @module("@base-ui/react/checkbox") @scope("Checkbox")
  external make: React.component<props> = "Root"
}

module Indicator = {
  @module("@base-ui/react/checkbox") @scope("Checkbox")
  external make: React.component<Types.BaseUIComponentProps.t> = "Indicator"
}
