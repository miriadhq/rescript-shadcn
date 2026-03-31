module Root = {
  type props<'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    onValueChange?: ('value, Types.BaseUIChangeEventDetail.t<[#none], unknown>) => unit,
    defaultValue?: 'value,
  }
  @module("@base-ui/react/tabs") @scope("Tabs")
  external make: React.component<props<'value, 'checked>> = "Root"
}

module List = {
  @module("@base-ui/react/tabs") @scope("Tabs")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "List"
}

module Tab = {
  @module("@base-ui/react/tabs") @scope("Tabs")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Tab"
}

module Panel = {
  @module("@base-ui/react/tabs") @scope("Tabs")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Panel"
}

module Indicator = {
  @module("@base-ui/react/tabs") @scope("Tabs")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Indicator"
}
