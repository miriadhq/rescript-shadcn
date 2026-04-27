module Root = {
  type props<'value> = {
    ...Types.BaseUIComponentProps.t,
    value?: array<'value>,
    hiddenUntilFound?: bool,
    keepMounted?: bool,
    loopFocus?: bool,
    onValueChange?: (
      array<'value>,
      Types.BaseUIChangeEventDetail.t<[#"trigger-press" | #none], unknown>,
    ) => unit,
    defaultValue?: array<'value>,
    multiple?: bool,
  }
  @module("@base-ui/react/accordion") @scope("Accordion")
  external make: React.component<props<'value>> = "Root"
}

module Item = {
  type props<'value> = {
    ...Types.BaseUIComponentProps.t,
    value?: 'value,
    onOpenChange?: (
      bool,
      Types.BaseUIChangeEventDetail.t<[#"trigger-press" | #none], unknown>,
    ) => unit,
  }
  @module("@base-ui/react/accordion") @scope("Accordion")
  external make: React.component<props<'value>> = "Item"
}

module Header = {
  @module("@base-ui/react/accordion") @scope("Accordion")
  external make: React.component<Types.BaseUIComponentProps.t> = "Header"
}

module Trigger = {
  @module("@base-ui/react/accordion") @scope("Accordion")
  external make: React.component<Types.BaseUIComponentProps.t> = "Trigger"
}

module Panel = {
  @module("@base-ui/react/accordion") @scope("Accordion")
  external make: React.component<Types.BaseUIComponentProps.t> = "Panel"
}
