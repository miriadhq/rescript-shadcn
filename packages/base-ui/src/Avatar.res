module Root = {
  @module("@base-ui/react/avatar") @scope("Avatar")
  external make: React.component<Types.BaseUIComponentProps.t> = "Root"
}

module Image = {
  type loadingStatus = [#idle | #loading | #loaded | #error]
  type props = {
    ...Types.BaseUIComponentProps.t,
    keepMounted?: bool,
    onLoadingStatusChange?: loadingStatus => unit,
  }
  @module("@base-ui/react/avatar") @scope("Avatar")
  external make: React.component<props> = "Image"
}

module Fallback = {
  @module("@base-ui/react/avatar") @scope("Avatar")
  external make: React.component<Types.BaseUIComponentProps.t> = "Fallback"
}
