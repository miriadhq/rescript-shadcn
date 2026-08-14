type props = {
  ...Common.elementProps,
  isOpen?: bool,
  defaultOpen?: bool,
  onOpenChange?: bool => unit,
  placement?: Common.placement,
  offset?: float,
  crossOffset?: float,
  containerPadding?: float,
  shouldFlip?: bool,
  arrowBoundaryOffset?: float,
  boundaryElement?: Dom.element,
  maxHeight?: float,
  isNonModal?: bool,
  isKeyboardDismissDisabled?: bool,
  isDismissable?: bool,
  shouldCloseOnInteractOutside?: Dom.element => bool,
  isEntering?: bool,
  isExiting?: bool,
  trigger?: string,
  triggerRef?: ReactDOM.domRef,
  @as("UNSTABLE_portalContainer") unstablePortalContainer?: Dom.element,
}

@module("react-aria-components")
external make: React.component<props> = "Popover"
