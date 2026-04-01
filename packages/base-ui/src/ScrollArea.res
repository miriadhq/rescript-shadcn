module Root = {
  @module("@base-ui/react/scroll-area") @scope("ScrollArea")
  external make: React.component<Types.BaseUIComponentProps.t> = "Root"
}

module Viewport = {
  @module("@base-ui/react/scroll-area") @scope("ScrollArea")
  external make: React.component<Types.BaseUIComponentProps.t> = "Viewport"
}

module Scrollbar = {
  @module("@base-ui/react/scroll-area") @scope("ScrollArea")
  external make: React.component<Types.BaseUIComponentProps.t> = "Scrollbar"
}

module Content = {
  @module("@base-ui/react/scroll-area") @scope("ScrollArea")
  external make: React.component<Types.BaseUIComponentProps.t> = "Content"
}

module Thumb = {
  @module("@base-ui/react/scroll-area") @scope("ScrollArea")
  external make: React.component<Types.BaseUIComponentProps.t> = "Thumb"
}

module Corner = {
  @module("@base-ui/react/scroll-area") @scope("ScrollArea")
  external make: React.component<Types.BaseUIComponentProps.t> = "Corner"
}
