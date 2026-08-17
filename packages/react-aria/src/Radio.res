module RenderProps = {
  type t = {
    isSelected: bool,
  }
}

module ComponentProps = {
  type t = {
    ...Common.BaseProps.t,
    value: string,
    isDisabled?: bool,
  }
}

type props = {...ComponentProps.t, children?: React.element}

@module("react-aria-components")
external make: React.component<props> = "Radio"

module Field = {
  type props = {
    ...Common.ElementProps.t,
    value: string,
    isDisabled?: bool,
  }

  @module("react-aria-components")
  external make: React.component<props> = "RadioField"
}

module Button = {
  @module("react-aria-components")
  external make: React.component<Common.ElementProps.t> = "RadioButton"
}
