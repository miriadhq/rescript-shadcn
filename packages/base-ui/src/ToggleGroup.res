type props<'value, 'checked> = {
  ...Types.BaseUIComponentProps.t<'value, 'checked>,
  onValueChange?: ('value, Types.BaseUIChangeEventDetail.t<[#none], unknown>) => unit,
  loopFocus?: bool,
  defaultValue?: 'value,
  multiple?: bool,
}
@module("@base-ui/react/toggle-group")
external make: React.component<props<array<'value>, 'checked>> = "ToggleGroup"
