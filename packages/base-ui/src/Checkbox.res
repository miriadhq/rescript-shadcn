module Root = {
  type props<'value> = {
    ...Types.BaseUIComponentProps.t<'value, bool>,
    ...Types.NonNativeButtonProps.t,
    onCheckedChange?: (bool, Types.BaseUIChangeEventDetail.t<[#none], unknown>) => unit,
    indeterminate?: bool,
    inputRef?: ReactDOM.domRef,
    parent?: bool,
    uncheckedValue?: string,
    defaultChecked?: bool,
  }
  @module("@base-ui/react/checkbox") @scope("Checkbox")
  external make: React.component<props<'value>> = "Root"
}

module Indicator = {
  @module("@base-ui/react/checkbox") @scope("Checkbox")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Indicator"
}
