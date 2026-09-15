type props = {
  ...Common.elementProps,
  isOpen?: bool,
  defaultOpen?: bool,
  onOpenChange?: bool => unit,
  isDisabled?: bool,
  delay?: int,
  closeDelay?: int,
}
@module("react-aria-components")
external make: React.component<props> = "PreviewTrigger"
