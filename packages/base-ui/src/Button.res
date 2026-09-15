type props = {
  ...Types.NativeButtonProps.t,
  focusableWhenDisabled?: bool,
}
@module("@base-ui/react/button")
external make: React.component<props> = "Button"
