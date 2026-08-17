/** Bindings for Switch, SwitchField, and SwitchButton. */
module RenderProps = {
  type t = {
    isSelected: bool,
  }
}

module ComponentProps = {
  type t = {
    ...Common.BaseProps.t,
    name?: string,
    value?: string,
    isSelected?: bool,
    defaultSelected?: bool,
    onChange?: bool => unit,
    isDisabled?: bool,
    isReadOnly?: bool,
    inputRef?: ReactDOM.domRef,
  }
}

type props = {...ComponentProps.t, children?: React.element}

@module("react-aria-components")
external make: React.component<props> = "Switch"

module Field = {
  type props = {
    ...Common.ElementProps.t,
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
  external make: React.component<Common.ElementProps.t> = "SwitchButton"
}
