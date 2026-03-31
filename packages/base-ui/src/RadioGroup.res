type props<'value, 'checked> = {
  ...Types.BaseUIComponentProps.t<'value, 'checked>,
  onValueChange?: ('value, Types.BaseUIChangeEventDetail.t<[#none], unknown>) => unit,
  inputRef?: ReactDOM.domRef,
  defaultValue?: 'value,
}
@module("@base-ui/react/radio-group")
external make: React.component<props<'value, 'checked>> = "RadioGroup"
