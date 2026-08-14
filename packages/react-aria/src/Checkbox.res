/** Bindings for Checkbox, CheckboxField, CheckboxButton, and CheckboxGroup. */
type renderProps = {
  isSelected: bool,
  isIndeterminate: bool,
}

type componentProps = {
  ...Common.baseProps,
  name?: string,
  value?: string,
  isSelected?: bool,
  defaultSelected?: bool,
  onChange?: bool => unit,
  isIndeterminate?: bool,
  isDisabled?: bool,
  isRequired?: bool,
  isReadOnly?: bool,
  isInvalid?: bool,
  inputRef?: ReactDOM.domRef,
}

type props = {...componentProps, children: renderProps => React.element}
external toProps: componentProps => props = "%identity"

@module("react-aria-components")
external make: React.component<props> = "Checkbox"

module Field = {
  type props = {
    ...Common.elementProps,
    name?: string,
    value?: string,
    isSelected?: bool,
    defaultSelected?: bool,
    onChange?: bool => unit,
    isIndeterminate?: bool,
    isDisabled?: bool,
    isRequired?: bool,
    isReadOnly?: bool,
    isInvalid?: bool,
    inputRef?: ReactDOM.domRef,
  }

  @module("react-aria-components")
  external make: React.component<props> = "CheckboxField"
}

module Button = {
  @module("react-aria-components")
  external make: React.component<Common.elementProps> = "CheckboxButton"
}

module Group = {
  type props = {
    ...Common.elementProps,
    name?: string,
    value?: array<string>,
    defaultValue?: array<string>,
    onChange?: array<string> => unit,
    isDisabled?: bool,
    isRequired?: bool,
    isReadOnly?: bool,
    isInvalid?: bool,
  }

  @module("react-aria-components")
  external make: React.component<props> = "CheckboxGroup"
}
