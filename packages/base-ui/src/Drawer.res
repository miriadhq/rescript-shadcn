module Root = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    defaultOpen?: bool,
    onOpenChange?: (bool, Types.BaseUIChangeEventDetail.t<[#none], unknown>) => unit,
    onOpenChangeComplete?: bool => unit,
    modal?: Types.Modal.t,
  }
  @module("@base-ui/react/drawer") @scope("DrawerPreview")
  external make: React.component<props> = "Root"
}

module Provider = {
  @module("@base-ui/react/drawer") @scope("DrawerPreview")
  external make: React.component<Types.BaseUIComponentProps.t> = "Provider"
}

module Trigger = {
  @module("@base-ui/react/drawer") @scope("DrawerPreview")
  external make: React.component<Types.BaseUIComponentProps.t> = "Trigger"
}

module Portal = {
  @module("@base-ui/react/drawer") @scope("DrawerPreview")
  external make: React.component<Types.BaseUIComponentProps.t> = "Portal"
}

module Backdrop = {
  @module("@base-ui/react/drawer") @scope("DrawerPreview")
  external make: React.component<Types.BaseUIComponentProps.t> = "Backdrop"
}

module Viewport = {
  @module("@base-ui/react/drawer") @scope("DrawerPreview")
  external make: React.component<Types.BaseUIComponentProps.t> = "Viewport"
}

module Popup = {
  @module("@base-ui/react/drawer") @scope("DrawerPreview")
  external make: React.component<Types.BaseUIComponentProps.t> = "Popup"
}

module Content = {
  @module("@base-ui/react/drawer") @scope("DrawerPreview")
  external make: React.component<Types.BaseUIComponentProps.t> = "Content"
}

module Title = {
  @module("@base-ui/react/drawer") @scope("DrawerPreview")
  external make: React.component<Types.BaseUIComponentProps.t> = "Title"
}

module Description = {
  @module("@base-ui/react/drawer") @scope("DrawerPreview")
  external make: React.component<Types.BaseUIComponentProps.t> = "Description"
}

module Close = {
  @module("@base-ui/react/drawer") @scope("DrawerPreview")
  external make: React.component<Types.BaseUIComponentProps.t> = "Close"
}

module Indent = {
  @module("@base-ui/react/drawer") @scope("DrawerPreview")
  external make: React.component<Types.BaseUIComponentProps.t> = "Indent"
}

module IndentBackground = {
  @module("@base-ui/react/drawer") @scope("DrawerPreview")
  external make: React.component<Types.BaseUIComponentProps.t> = "IndentBackground"
}
