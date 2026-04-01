module Root = {
  type props<'value> = {
    ...Types.BaseUIComponentProps.t,
    value?: 'value,
    onValueChange?: ('value, Types.BaseUIChangeEventDetail.t<[#none], unknown>) => unit,
    defaultValue?: 'value,
  }
  @module("@base-ui/react/tabs") @scope("Tabs")
  external make: React.component<props<'value>> = "Root"
}

module List = {
  @module("@base-ui/react/tabs") @scope("Tabs")
  external make: React.component<Types.BaseUIComponentProps.t> = "List"
}

module Tab = {
  type props<'value> = {
    ...Types.BaseUIComponentProps.t,
    ...Types.NativeButtonProps.t,
    value: 'value,
  }
  @module("@base-ui/react/tabs") @scope("Tabs")
  external make: React.component<props<'value>> = "Tab"
}

module Panel = {
  type props<'value> = {
    ...Types.BaseUIComponentProps.t,
    value: 'value,
    keepMounted?: bool,
  }
  @module("@base-ui/react/tabs") @scope("Tabs")
  external make: React.component<props<'value>> = "Panel"
}

module Indicator = {
  @module("@base-ui/react/tabs") @scope("Tabs")
  external make: React.component<Types.BaseUIComponentProps.t> = "Indicator"
}
