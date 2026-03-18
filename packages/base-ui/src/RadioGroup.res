type props<'value, 'checked> = {
  ...Types.props<'value, 'checked>,
  defaultValue?: 'value,
}
@module("@base-ui/react/radio-group")
external make: React.component<props<'value, 'checked>> = "RadioGroup"
