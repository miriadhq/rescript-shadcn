type valueChangeDetails = Types.BaseUIChangeEventDetail.t<[#none], unknown>

type props<'value, 'checked> = {
  ...Types.BaseUIComponentProps.t<'value, 'checked>,
  onValueChange?: (string, valueChangeDetails) => unit,
  defaultValue?: 'value,
}
@module("@base-ui/react/input")
external make: React.component<props<'value, 'checked>> = "Input"
