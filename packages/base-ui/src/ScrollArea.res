module Root = {
  @module("@base-ui/react/scroll-area") @scope("ScrollArea")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Root"
}

module Viewport = {
  @module("@base-ui/react/scroll-area") @scope("ScrollArea")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Viewport"
}

module Scrollbar = {
  @module("@base-ui/react/scroll-area") @scope("ScrollArea")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Scrollbar"
}

module Content = {
  @module("@base-ui/react/scroll-area") @scope("ScrollArea")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Content"
}

module Thumb = {
  @module("@base-ui/react/scroll-area") @scope("ScrollArea")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Thumb"
}

module Corner = {
  @module("@base-ui/react/scroll-area") @scope("ScrollArea")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Corner"
}
