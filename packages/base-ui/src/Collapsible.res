module Root = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    defaultOpen?: bool,
    onOpenChange?: (
      bool,
      Types.BaseUIChangeEventDetail.t<[#"trigger-pressed" | #none], unknown>,
    ) => unit,
  }
  @module("@base-ui/react/collapsible") @scope("Collapsible")
  external make: React.component<props> = "Root"
}

module Trigger = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    ...Types.NativeButtonProps.t,
  }
  @module("@base-ui/react/collapsible") @scope("Collapsible")
  external make: React.component<props> = "Trigger"
}

module Panel = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    hiddenUntilFound?: bool,
    keepMounted?: bool,
  }
  @module("@base-ui/react/collapsible") @scope("Collapsible")
  external make: React.component<props> = "Panel"
}
