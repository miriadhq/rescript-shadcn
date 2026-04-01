type props<'value> = {
  ...Types.BaseUIComponentProps.t,
  value?: 'value,
  onValueChange?: ('value, Types.BaseUIChangeEventDetail.t<[#none], unknown>) => unit,
  inputRef?: ReactDOM.domRef,
  defaultValue?: 'value,
}
@module("@base-ui/react/radio-group")
external make: React.component<props<'value>> = "RadioGroup"
