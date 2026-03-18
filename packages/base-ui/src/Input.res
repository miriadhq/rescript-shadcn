type props<'value, 'checked> = {
  ...Types.props<'value, 'checked>,
  onChange?: ReactEvent.Form.t => unit,
  defaultValue?: 'value,
}

@module("@base-ui/react/input")
external make: React.component<props<'value, 'checked>> = "Input"
