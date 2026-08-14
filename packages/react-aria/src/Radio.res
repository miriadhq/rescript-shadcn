type renderProps = {
  isSelected: bool,
}

type componentProps = {
  ...Common.baseProps,
  value: string,
  isDisabled?: bool,
}

type props = {...componentProps, children: renderProps => React.element}
external toProps: componentProps => props = "%identity"

@module("react-aria-components")
external make: React.component<props> = "Radio"

module Field = {
  type props = {
    ...Common.elementProps,
    value: string,
    isDisabled?: bool,
  }

  @module("react-aria-components")
  external make: React.component<props> = "RadioField"
}

module Button = {
  @module("react-aria-components")
  external make: React.component<Common.elementProps> = "RadioButton"
}
