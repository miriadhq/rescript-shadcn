/** Adds React Aria press handling to a DOM child. */
type props = {
  children: React.element,
  ref?: ReactDOM.domRef,
  isPressed?: bool,
  isDisabled?: bool,
  preventFocusOnPress?: bool,
  shouldCancelOnPointerExit?: bool,
  allowTextSelectionOnPress?: bool,
  onPress?: Common.pressEvent => unit,
  onPressStart?: Common.pressEvent => unit,
  onPressEnd?: Common.pressEvent => unit,
  onPressUp?: Common.pressEvent => unit,
  onPressChange?: bool => unit,
}

@module("react-aria-components")
external make: React.component<props> = "Pressable"
