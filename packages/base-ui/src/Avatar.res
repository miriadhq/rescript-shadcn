module Root = {
  @module("@base-ui/react/avatar") @scope("Avatar")
  external make: React.component<Types.BaseUIComponentProps.t> = "Root"
}

module Image = {
  @module("@base-ui/react/avatar") @scope("Avatar")
  external make: React.component<Types.BaseUIComponentProps.t> = "Image"
}

module Fallback = {
  @module("@base-ui/react/avatar") @scope("Avatar")
  external make: React.component<Types.BaseUIComponentProps.t> = "Fallback"
}
