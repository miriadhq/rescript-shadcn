module Root = {
  type props<'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    defaultOpen?: bool,
    onOpenChange?: (
      bool,
      Types.BaseUIChangeEventDetail.t<[#"trigger-pressed" | #none], unknown>,
    ) => unit,
  }
  @module("@base-ui/react/collapsible") @scope("Collapsible")
  external make: React.component<props<'value, 'checked>> = "Root"
}

module Trigger = {
  type props<'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    ...Types.NativeButtonProps.t,
  }
  @module("@base-ui/react/collapsible") @scope("Collapsible")
  external make: React.component<props<'value, 'checked>> = "Trigger"
}

module Panel = {
  type props<'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    hiddenUntilFound?: bool,
    keepMounted?: bool,
  }
  @module("@base-ui/react/collapsible") @scope("Collapsible")
  external make: React.component<props<'value, 'checked>> = "Panel"
}
