type props = {
  ...Common.baseProps,
  isOpen?: bool,
  defaultOpen?: bool,
  onOpenChange?: bool => unit,
  placement?: Common.placement,
  offset?: float,
  crossOffset?: float,
  shouldFlip?: bool,
  isNonModal?: bool,
  isKeyboardDismissDisabled?: bool,
  isDismissable?: bool,
  trigger?: string,
  triggerRef?: ReactDOM.domRef,
  @as("UNSTABLE_portalContainer") unstablePortalContainer?: Dom.element,
}

@module("react-aria-components")
external make: React.component<props> = "Popover"
