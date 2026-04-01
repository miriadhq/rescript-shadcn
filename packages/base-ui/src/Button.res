type props = {
  ...Types.BaseUIComponentProps.t,
  ...Types.NativeButtonProps.t,
  focusableWhenDisabled?: bool,
}
@module("@base-ui/react/button")
external make: React.component<props> = "Button"
