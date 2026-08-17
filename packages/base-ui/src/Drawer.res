module SwipeDirection = {
  @unboxed
  type t =
    | @as("down") Down
    | @as("up") Up
    | @as("left") Left
    | @as("right") Right
}

module SnapPoint = {
  @unboxed
  type t =
    | Pixels(string)
    | Ratio(float)
}

module Root = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    defaultOpen?: bool,
    onOpenChange?: (bool, Types.BaseUIChangeEventDetail.t<[#none], unknown>) => unit,
    onOpenChangeComplete?: bool => unit,
    modal?: Types.Modal.t,
    snapPoints?: array<SnapPoint.t>,
    swipeDirection?: SwipeDirection.t,
    disablePointerDismissal?: bool,
  }
  @module("@base-ui/react/drawer") @scope("Drawer")
  external make: React.component<props> = "Root"
}

module Provider = {
  @module("@base-ui/react/drawer") @scope("Drawer")
  external make: React.component<Types.BaseUIComponentProps.t> = "Provider"
}

module Trigger = {
  @module("@base-ui/react/drawer") @scope("Drawer")
  external make: React.component<Types.BaseUIComponentProps.t> = "Trigger"
}

module Portal = {
  @module("@base-ui/react/drawer") @scope("Drawer")
  external make: React.component<Types.BaseUIComponentProps.t> = "Portal"
}

module Backdrop = {
  @module("@base-ui/react/drawer") @scope("Drawer")
  external make: React.component<Types.BaseUIComponentProps.t> = "Backdrop"
}

module Viewport = {
  @module("@base-ui/react/drawer") @scope("Drawer")
  external make: React.component<Types.BaseUIComponentProps.t> = "Viewport"
}

module Popup = {
  @module("@base-ui/react/drawer") @scope("Drawer")
  external make: React.component<Types.BaseUIComponentProps.t> = "Popup"
}

module Content = {
  @module("@base-ui/react/drawer") @scope("Drawer")
  external make: React.component<Types.BaseUIComponentProps.t> = "Content"
}

module Title = {
  @module("@base-ui/react/drawer") @scope("Drawer")
  external make: React.component<Types.BaseUIComponentProps.t> = "Title"
}

module Description = {
  @module("@base-ui/react/drawer") @scope("Drawer")
  external make: React.component<Types.BaseUIComponentProps.t> = "Description"
}

module Close = {
  @module("@base-ui/react/drawer") @scope("Drawer")
  external make: React.component<Types.BaseUIComponentProps.t> = "Close"
}

module Indent = {
  @module("@base-ui/react/drawer") @scope("Drawer")
  external make: React.component<Types.BaseUIComponentProps.t> = "Indent"
}

module IndentBackground = {
  @module("@base-ui/react/drawer") @scope("Drawer")
  external make: React.component<Types.BaseUIComponentProps.t> = "IndentBackground"
}

module SwipeArea = {
  @module("@base-ui/react/drawer") @scope("Drawer")
  external make: React.component<Types.BaseUIComponentProps.t> = "SwipeArea"
}

module VirtualKeyboardProvider = {
  type props = {
    children?: React.element,
  }
  @module("@base-ui/react/drawer") @scope("Drawer")
  external make: React.component<props> = "VirtualKeyboardProvider"
}
