type props = Common.baseProps

@module("react-aria-components")
external make: React.component<props> = "Dialog"

module Trigger = {
  type props = {
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
    ...Common.baseProps,
    isDismissable?: bool,
    isKeyboardDismissDisabled?: bool,
  }

  @module("react-aria-components")
  external make: React.component<props> = "Modal"
}

module ModalOverlay = {
  @module("react-aria-components")
  external make: React.component<Modal.props> = "ModalOverlay"
}
