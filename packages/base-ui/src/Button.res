type props<'value, 'checked> = {
  ...Types.BaseUIComponentProps.t<'value, 'checked>,
  ...Types.NativeButtonProps.t,
  focusableWhenDisabled?: bool,
}
@module("@base-ui/react/button")
external make: React.component<props<'value, 'checked>> = "Button"
