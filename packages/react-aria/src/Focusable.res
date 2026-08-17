/** Direct binding for React Aria's Focusable export. */
type props = {
  ...Common.BaseProps.t,
  children: React.element,
  isDisabled?: bool,
  excludeFromTabOrder?: bool,
  autoFocus?: bool,
}

@module("react-aria-components")
external make: React.component<props> = "Focusable"
