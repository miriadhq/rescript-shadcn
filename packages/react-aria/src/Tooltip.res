type props = {
  ...Popover.props,
}

@module("react-aria-components")
external make: React.component<props> = "Tooltip"

module Trigger = {
  type props = {
    ...Common.ElementProps.t,
    isOpen?: bool,
    defaultOpen?: bool,
    onOpenChange?: bool => unit,
    delay?: float,
    closeDelay?: float,
    isDisabled?: bool,
    trigger?: [#focus | #hover],
    shouldCloseOnPress?: bool,
  }

  @module("react-aria-components")
  external make: React.component<props> = "TooltipTrigger"
}

module Arrow = {
  module RenderProps = {
    type t = {
      placement: string,
      defaultStyle: ReactDOM.Style.t,
    }
  }

  type props = {
    className?: string,
    style?: RenderProps.t => ReactDOM.Style.t,
    children?: React.element,
  }

  @module("react-aria-components")
  external make: React.component<props> = "OverlayArrow"
}
