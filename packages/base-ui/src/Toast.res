module Root = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    toast?: JSON.t,
  }
  @module("@base-ui/react/toast") @scope("Toast")
  external make: React.component<props> = "Root"
}

module Provider = {
  @module("@base-ui/react/toast") @scope("Toast")
  external make: React.component<Types.BaseUIComponentProps.t> = "Provider"
}

module Viewport = {
  @module("@base-ui/react/toast") @scope("Toast")
  external make: React.component<Types.BaseUIComponentProps.t> = "Viewport"
}

module Content = {
  @module("@base-ui/react/toast") @scope("Toast")
  external make: React.component<Types.BaseUIComponentProps.t> = "Content"
}

module Description = {
  @module("@base-ui/react/toast") @scope("Toast")
  external make: React.component<Types.BaseUIComponentProps.t> = "Description"
}

module Title = {
  @module("@base-ui/react/toast") @scope("Toast")
  external make: React.component<Types.BaseUIComponentProps.t> = "Title"
}

module Close = {
  @module("@base-ui/react/toast") @scope("Toast")
  external make: React.component<Types.BaseUIComponentProps.t> = "Close"
}

module Action = {
  @module("@base-ui/react/toast") @scope("Toast")
  external make: React.component<Types.BaseUIComponentProps.t> = "Action"
}

module Portal = {
  @module("@base-ui/react/toast") @scope("Toast")
  external make: React.component<Types.BaseUIComponentProps.t> = "Portal"
}

module Positioner = {
  @module("@base-ui/react/toast") @scope("Toast")
  external make: React.component<Types.BaseUIComponentProps.t> = "Positioner"
}

module Arrow = {
  @module("@base-ui/react/toast") @scope("Toast")
  external make: React.component<Types.BaseUIComponentProps.t> = "Arrow"
}
