module Root = {
  type base<'value, 'checked> = {}
  type props<'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    hiddenUntilFound?: bool,
    keepMounted?: bool,
    loopFocus?: bool,
    onValueChange?: (
      'value,
      Types.BaseUIChangeEventDetail.t<[#"trigger-press" | #none], unknown>,
    ) => unit,
    defaultValue?: array<'value>,
    multiple?: bool,
  }
  @module("@base-ui/react/accordion") @scope("Accordion")
  external make: React.component<props<'value, 'checked>> = "Root"
}

module Item = {
  @module("@base-ui/react/accordion") @scope("Accordion")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Item"
}

module Header = {
  @module("@base-ui/react/accordion") @scope("Accordion")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Header"
}

module Trigger = {
  @module("@base-ui/react/accordion") @scope("Accordion")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Trigger"
}

module Panel = {
  @module("@base-ui/react/accordion") @scope("Accordion")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Panel"
}
