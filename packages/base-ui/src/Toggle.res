type props<'value, 'checked> = {
  ...Types.BaseUIComponentProps.t<'value, 'checked>,
  ...Types.NativeButtonProps.t,
  pressed?: bool,
  defaultPressed?: bool,
  onPressedChange?: (bool, Types.BaseUIChangeEventDetail.t<[#none], unknown>) => unit,
}
@module("@base-ui/react/toggle")
external make: React.component<props<'value, 'checked>> = "Toggle"
