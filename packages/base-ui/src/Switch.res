module Root = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    ...Types.NonNativeButtonProps.t,
    checked?: bool,
    inputRef?: ReactDOM.domRef,
    onCheckedChange?: (bool, Types.BaseUIChangeEventDetail.t<[#none], unknown>) => unit,
    uncheckedValue?: string,
    defaultChecked?: bool,
  }
  @module("@base-ui/react/switch") @scope("Switch")
  external make: React.component<props> = "Root"
}

module Thumb = {
  @module("@base-ui/react/switch") @scope("Switch")
  external make: React.component<Types.BaseUIComponentProps.t> = "Thumb"
}
