/** Bindings for Checkbox, CheckboxField, CheckboxButton, and CheckboxGroup. */
module RenderProps = {
  type t = {
    isSelected: bool,
    isIndeterminate: bool,
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
    isIndeterminate?: bool,
    isDisabled?: bool,
    isRequired?: bool,
    isReadOnly?: bool,
    isInvalid?: bool,
    inputRef?: ReactDOM.domRef,
  }
}

type props = {...ComponentProps.t, children?: React.element}

@module("react-aria-components")
external make: React.component<props> = "Checkbox"

module Field = {
  type props = {
    ...Common.ElementProps.t,
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
  external make: React.component<Common.ElementProps.t> = "CheckboxButton"
}

module Group = {
  type props = {
    ...Common.ElementProps.t,
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
