type props = {
  ...Common.elementProps,
  value?: string,
  defaultValue?: string,
  onChange?: string => unit,
  autoFocus?: bool,
  isDisabled?: bool,
  isReadOnly?: bool,
  isRequired?: bool,
}

@module("react-aria-components")
external make: React.component<props> = "SearchField"
