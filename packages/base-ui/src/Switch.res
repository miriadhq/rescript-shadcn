module Root = {
  type props<'value> = {
    ...Types.BaseUIComponentProps.t<'value, bool>,
    ...Types.NonNativeButtonProps.t,
    inputRef?: ReactDOM.domRef,
    onCheckedChange?: (bool, Types.BaseUIChangeEventDetail.t<[#none], unknown>) => unit,
    uncheckedValue?: string,
    defaultChecked?: bool,
  }
  @module("@base-ui/react/switch") @scope("Switch")
  external make: React.component<props<'value>> = "Root"
}

module Thumb = {
  @module("@base-ui/react/switch") @scope("Switch")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Thumb"
}
