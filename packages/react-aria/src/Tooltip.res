type props = {
  ...Popover.props,
}

@module("react-aria-components")
external make: React.component<props> = "Tooltip"

module Trigger = {
  type props = {
    children?: React.element,
    isOpen?: bool,
    defaultOpen?: bool,
    onOpenChange?: bool => unit,
    delay?: float,
    closeDelay?: float,
    trigger?: [#focus],
  }

  @module("react-aria-components")
  external make: React.component<props> = "TooltipTrigger"
}

module Arrow = {
  @module("react-aria-components")
  external make: React.component<Common.baseProps> = "OverlayArrow"
}
