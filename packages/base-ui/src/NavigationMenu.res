module Root = {
  module Actions = {
    type t = {
      unmount: unit => unit,
    }
  }

  type props<'value> = {
    ...Types.BaseUIComponentProps.t,
    actionsRef?: React.ref<Actions.t>,
    onOpenChangeComplete?: bool => unit,
    value?: 'value,
    onValueChange?: (
      'value,
      Types.BaseUIChangeEventDetail.t<
        [
          | #"trigger-pressed"
          | #"trigger-hover"
          | #"outside-press"
          | #"list-navigation"
          | #"focus-out"
          | #"escape-key"
          | #"link-press"
          | #none
        ],
        unknown,
      >,
    ) => unit,
    delay?: int,
    closeDelay?: int,
    defaultValue?: 'value,
  }
  @module("@base-ui/react/navigation-menu") @scope("NavigationMenu")
  external make: React.component<props<'value>> = "Root"
}

module List = {
  @module("@base-ui/react/navigation-menu") @scope("NavigationMenu")
  external make: React.component<Types.BaseUIComponentProps.t> = "List"
}

module Item = {
  @module("@base-ui/react/navigation-menu") @scope("NavigationMenu")
  external make: React.component<Types.BaseUIComponentProps.t> = "Item"
}

module Content = {
  @module("@base-ui/react/navigation-menu") @scope("NavigationMenu")
  external make: React.component<Types.BaseUIComponentProps.t> = "Content"
}

module Trigger = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    ...Types.NativeButtonProps.t,
  }
  @module("@base-ui/react/navigation-menu") @scope("NavigationMenu")
  external make: React.component<props> = "Trigger"
}

module Portal = {
  @module("@base-ui/react/navigation-menu") @scope("NavigationMenu")
  external make: React.component<Types.BaseUIComponentProps.t> = "Portal"
}

module Positioner = {
  /** See `NavigationMenuPositionerProps` in `@base-ui/react/navigation-menu/positioner/NavigationMenuPositioner.d.ts`. */
  type props = {
    ...Types.BaseUIComponentProps.t,
    ...AnchorPositioning.SharedParameters.t,
  }
  @module("@base-ui/react/navigation-menu") @scope("NavigationMenu")
  external make: React.component<props> = "Positioner"
}

module Viewport = {
  @module("@base-ui/react/navigation-menu") @scope("NavigationMenu")
  external make: React.component<Types.BaseUIComponentProps.t> = "Viewport"
}

module Backdrop = {
  @module("@base-ui/react/navigation-menu") @scope("NavigationMenu")
  external make: React.component<Types.BaseUIComponentProps.t> = "Backdrop"
}

module Popup = {
  @module("@base-ui/react/navigation-menu") @scope("NavigationMenu")
  external make: React.component<Types.BaseUIComponentProps.t> = "Popup"
}

module Arrow = {
  @module("@base-ui/react/navigation-menu") @scope("NavigationMenu")
  external make: React.component<Types.BaseUIComponentProps.t> = "Arrow"
}

module Link = {
  @module("@base-ui/react/navigation-menu") @scope("NavigationMenu")
  external make: React.component<Types.BaseUIComponentProps.t> = "Link"
}

module Icon = {
  @module("@base-ui/react/navigation-menu") @scope("NavigationMenu")
  external make: React.component<Types.BaseUIComponentProps.t> = "Icon"
}
