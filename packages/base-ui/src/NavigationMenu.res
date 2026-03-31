module Root = {
  module Actions = {
    type t = {
      unmount: unit => unit,
    }
  }

  type props<'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    actionsRef?: React.ref<Actions.t>,
    onOpenChangeComplete?: bool => unit,
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
  external make: React.component<props<'value, 'checked>> = "Root"
}

module List = {
  @module("@base-ui/react/navigation-menu") @scope("NavigationMenu")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "List"
}

module Item = {
  @module("@base-ui/react/navigation-menu") @scope("NavigationMenu")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Item"
}

module Content = {
  @module("@base-ui/react/navigation-menu") @scope("NavigationMenu")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Content"
}

module Trigger = {
  type props<'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    ...Types.NativeButtonProps.t,
  }
  @module("@base-ui/react/navigation-menu") @scope("NavigationMenu")
  external make: React.component<props<'value, 'checked>> = "Trigger"
}

module Portal = {
  @module("@base-ui/react/navigation-menu") @scope("NavigationMenu")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Portal"
}

module Positioner = {
  /** See `NavigationMenuPositionerProps` in `@base-ui/react/navigation-menu/positioner/NavigationMenuPositioner.d.ts`. */
  type props<'value, 'checked> = {
    ...Types.BaseUIComponentProps.t<'value, 'checked>,
    ...AnchorPositioning.SharedParameters.t,
  }
  @module("@base-ui/react/navigation-menu") @scope("NavigationMenu")
  external make: React.component<props<'value, 'checked>> = "Positioner"
}

module Viewport = {
  @module("@base-ui/react/navigation-menu") @scope("NavigationMenu")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Viewport"
}

module Backdrop = {
  @module("@base-ui/react/navigation-menu") @scope("NavigationMenu")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Backdrop"
}

module Popup = {
  @module("@base-ui/react/navigation-menu") @scope("NavigationMenu")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Popup"
}

module Arrow = {
  @module("@base-ui/react/navigation-menu") @scope("NavigationMenu")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Arrow"
}

module Link = {
  @module("@base-ui/react/navigation-menu") @scope("NavigationMenu")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Link"
}

module Icon = {
  @module("@base-ui/react/navigation-menu") @scope("NavigationMenu")
  external make: React.component<Types.BaseUIComponentProps.t<'value, 'checked>> = "Icon"
}
