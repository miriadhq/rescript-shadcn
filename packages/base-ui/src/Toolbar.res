module Root = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    loopFocus?: bool,
  }
  @module("@base-ui/react/toolbar") @scope("Toolbar")
  external make: React.component<props> = "Root"
}

module Group = {
  @module("@base-ui/react/toolbar") @scope("Toolbar")
  external make: React.component<Types.BaseUIComponentProps.t> = "Group"
}

module Button = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    ...Types.NativeButtonProps.t,
  }
  @module("@base-ui/react/toolbar") @scope("Toolbar")
  external make: React.component<props> = "Button"
}

module Link = {
  type props = {...Types.BaseUIComponentProps.t, @as("type") type_?: string}
  @module("@base-ui/react/toolbar") @scope("Toolbar")
  external make: React.component<props> = "Link"
}

module Input = {
  type props = {...Types.BaseUIComponentProps.t, @as("type") type_?: string}
  @module("@base-ui/react/toolbar") @scope("Toolbar")
  external make: React.component<props> = "Input"
}

module Separator = {
  @module("@base-ui/react/toolbar") @scope("Toolbar")
  external make: React.component<Types.BaseUIComponentProps.t> = "Separator"
}
