type props<'value> = {
  ...Types.BaseUIComponentProps.t,
  ...Types.NativeButtonProps.t,
  pressed?: bool,
  defaultPressed?: bool,
  onPressedChange?: (bool, Types.BaseUIChangeEventDetail.t<[#none], unknown>) => unit,
  value?: 'value,
}
@module("@base-ui/react/toggle")
external make: React.component<props<'value>> = "Toggle"
