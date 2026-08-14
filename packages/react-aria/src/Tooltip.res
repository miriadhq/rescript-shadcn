type props = {
  ...Popover.props,
}

@module("react-aria-components")
external make: React.component<props> = "Tooltip"

module Trigger = {
  type props = {
    ...Common.elementProps,
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
  type renderProps = {
    placement: string,
    defaultStyle: ReactDOM.Style.t,
  }

  external renderStyle: (renderProps => ReactDOM.Style.t) => ReactDOM.Style.t = "%identity"

  @module("react-aria-components")
  external make: React.component<Common.elementProps> = "OverlayArrow"
}
