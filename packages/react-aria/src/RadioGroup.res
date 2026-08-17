type props = {
  ...Common.ElementProps.t,
  name?: string,
  value?: string,
  defaultValue?: string,
  onChange?: string => unit,
  isDisabled?: bool,
  isRequired?: bool,
  isReadOnly?: bool,
  isInvalid?: bool,
}

@module("react-aria-components")
external make: React.component<props> = "RadioGroup"
