/** Bindings for Switch, SwitchField, and SwitchButton. */
type renderProps = {
  isSelected: bool,
}

type componentProps = {
  ...Common.baseProps,
  name?: string,
  value?: string,
  isSelected?: bool,
  defaultSelected?: bool,
  onChange?: bool => unit,
  isDisabled?: bool,
  isReadOnly?: bool,
  inputRef?: ReactDOM.domRef,
}

type props = {...componentProps, children: renderProps => React.element}
external toProps: componentProps => props = "%identity"

@module("react-aria-components")
external make: React.component<props> = "Switch"

module Field = {
  type props = {
    ...Common.elementProps,
    name?: string,
    value?: string,
    isSelected?: bool,
    defaultSelected?: bool,
    onChange?: bool => unit,
    isDisabled?: bool,
    isRequired?: bool,
    isReadOnly?: bool,
    isInvalid?: bool,
    inputRef?: ReactDOM.domRef,
  }

  @module("react-aria-components")
  external make: React.component<props> = "SwitchField"
}

module Button = {
  @module("react-aria-components")
  external make: React.component<Common.elementProps> = "SwitchButton"
}
