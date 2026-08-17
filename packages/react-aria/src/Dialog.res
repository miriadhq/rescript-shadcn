type props = Common.ElementProps.t

@module("react-aria-components")
external make: React.component<props> = "Dialog"

module Trigger = {
  type props = {
    ...Common.BaseProps.t,
    children?: React.element,
    isOpen?: bool,
    defaultOpen?: bool,
    onOpenChange?: bool => unit,
  }

  @module("react-aria-components")
  external make: React.component<props> = "DialogTrigger"
}

module Modal = {
  type props = {
    ...Common.ElementProps.t,
    isOpen?: bool,
    defaultOpen?: bool,
    onOpenChange?: bool => unit,
    isDismissable?: bool,
    isKeyboardDismissDisabled?: bool,
    shouldCloseOnInteractOutside?: Dom.element => bool,
    isEntering?: bool,
    isExiting?: bool,
    @as("UNSTABLE_portalContainer") unstablePortalContainer?: Dom.element,
  }

  @module("react-aria-components")
  external make: React.component<props> = "Modal"
}

module ModalOverlay = {
  @module("react-aria-components")
  external make: React.component<Modal.props> = "ModalOverlay"
}
