type props<'value, 'checked> = {
  ...Types.props<'value, 'checked>,
  multiple?: bool,
  defaultValue?: 'value,
}

@module("@base-ui/react/toggle-group")
external make: React.component<props<'value, 'checked>> = "ToggleGroup"
