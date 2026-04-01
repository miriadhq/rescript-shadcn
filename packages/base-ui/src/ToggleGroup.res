type props<'value> = {
  ...Types.BaseUIComponentProps.t,
  value?: array<'value>,
  onValueChange?: (array<'value>, Types.BaseUIChangeEventDetail.t<[#none], unknown>) => unit,
  loopFocus?: bool,
  defaultValue?: array<'value>,
  multiple?: bool,
}
@module("@base-ui/react/toggle-group")
external make: React.component<props<'value>> = "ToggleGroup"
