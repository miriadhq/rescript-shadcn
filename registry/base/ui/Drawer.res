@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@@directive("'use client'")

open BaseUi.Types

@unboxed
type direction =
  | @as("bottom") Bottom
  | @as("left") Left
  | @as("right") Right
  | @as("top") Top

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module DrawerPrimitive = {
  module Root = {
    @module("vaul") @scope("Drawer")
    external make: React.component<props<'value, 'checked>> = "Root"
  }

  module Trigger = {
    @module("vaul") @scope("Drawer")
    external make: React.component<props<'value, 'checked>> = "Trigger"
  }

  module Portal = {
    @module("vaul") @scope("Drawer")
    external make: React.component<props<'value, 'checked>> = "Portal"
  }

  module Close = {
    @module("vaul") @scope("Drawer")
    external make: React.component<props<'value, 'checked>> = "Close"
  }

  module Overlay = {
    @module("vaul") @scope("Drawer")
    external make: React.component<props<'value, 'checked>> = "Overlay"
  }

  module Content = {
    @module("vaul") @scope("Drawer")
    external make: React.component<props<'value, 'checked>> = "Content"
  }

  module Title = {
    @module("vaul") @scope("Drawer")
    external make: React.component<props<'value, 'checked>> = "Title"
  }

  module Description = {
    @module("vaul") @scope("Drawer")
    external make: React.component<props<'value, 'checked>> = "Description"
  }
}

@react.component
let make = (
  ~children=?,
  ~open_=?,
  ~defaultOpen=?,
  ~onOpenChange=?,
  ~onOpenChangeComplete=?,
  ~modal=?,
  ~direction=Bottom,
) =>
  <DrawerPrimitive.Root
    ?children
    ?open_
    ?defaultOpen
    ?onOpenChange
    ?onOpenChangeComplete
    ?modal
    direction={(direction :> string)}
    dataSlot="drawer"
  />

module Trigger = {
  @react.component
  let make = (
    ~className="",
    ~children=?,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~disabled=?,
    ~asChild=?,
    ~type_=?,
    ~ariaLabel=?,
  ) =>
    <DrawerPrimitive.Trigger
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?disabled
      ?asChild
      ?type_
      ?ariaLabel
      ?children
      dataSlot="drawer-trigger"
      className
    />
}

module Portal = {
  @react.component
  let make = (~children=?, ~container=?) =>
    <DrawerPrimitive.Portal ?children ?container dataSlot="drawer-portal" />
}

module Close = {
  @react.component
  let make = (
    ~className="",
    ~children=?,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~disabled=?,
    ~asChild=?,
    ~type_=?,
    ~ariaLabel=?,
  ) =>
    <DrawerPrimitive.Close
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?disabled
      ?asChild
      ?type_
      ?ariaLabel
      ?children
      dataSlot="drawer-close"
      className
    />
}

module Overlay = {
  @react.component
  let make = (~className=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <DrawerPrimitive.Overlay
      ?id
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="drawer-overlay"
      className={cn(
        "data-open:animate-in data-closed:animate-out data-closed:fade-out-0 data-open:fade-in-0 fixed inset-0 z-50 bg-black/10 supports-backdrop-filter:backdrop-blur-xs",
        className,
      )}
    />
}

module Content = {
  @react.componentWithProps(BaseUi.Types.props)
  let make = (props: BaseUi.Types.props<'value, 'checked>) =>
    <Portal>
      <Overlay />
      <DrawerPrimitive.Content
        {...props}
        dataSlot="drawer-content"
        className={cn(
          "bg-background group/drawer-content fixed z-50 flex h-auto flex-col text-sm data-[vaul-drawer-direction=bottom]:inset-x-0 data-[vaul-drawer-direction=bottom]:bottom-0 data-[vaul-drawer-direction=bottom]:mt-24 data-[vaul-drawer-direction=bottom]:max-h-[80vh] data-[vaul-drawer-direction=bottom]:rounded-t-xl data-[vaul-drawer-direction=bottom]:border-t data-[vaul-drawer-direction=left]:inset-y-0 data-[vaul-drawer-direction=left]:left-0 data-[vaul-drawer-direction=left]:w-3/4 data-[vaul-drawer-direction=left]:rounded-r-xl data-[vaul-drawer-direction=left]:border-r data-[vaul-drawer-direction=right]:inset-y-0 data-[vaul-drawer-direction=right]:right-0 data-[vaul-drawer-direction=right]:w-3/4 data-[vaul-drawer-direction=right]:rounded-l-xl data-[vaul-drawer-direction=right]:border-l data-[vaul-drawer-direction=top]:inset-x-0 data-[vaul-drawer-direction=top]:top-0 data-[vaul-drawer-direction=top]:mb-24 data-[vaul-drawer-direction=top]:max-h-[80vh] data-[vaul-drawer-direction=top]:rounded-b-xl data-[vaul-drawer-direction=top]:border-b data-[vaul-drawer-direction=left]:sm:max-w-sm data-[vaul-drawer-direction=right]:sm:max-w-sm",
          props.className,
        )}
      >
        <div
          className="bg-muted mx-auto mt-4 hidden h-1 w-[100px] shrink-0 rounded-full group-data-[vaul-drawer-direction=bottom]/drawer-content:block"
        />
        {props.children->Option.getOr(React.null)}
      </DrawerPrimitive.Content>
    </Portal>
}

module Header = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot="drawer-header"
      className={cn(
        "flex flex-col gap-0.5 p-4 group-data-[vaul-drawer-direction=bottom]/drawer-content:text-center group-data-[vaul-drawer-direction=top]/drawer-content:text-center md:gap-0.5 md:text-left",
        props.className,
      )}
    />
}

module Footer = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <div
      ?id
      ?style
      ?children
      ?onClick
      ?onKeyDown
      dataSlot="drawer-footer"
      className={cn("mt-auto flex flex-col gap-2 p-4", className)}
    />
}

module Title = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <DrawerPrimitive.Title
      ?id
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="drawer-title"
      className={cn("text-foreground text-base font-medium", className)}
      ?children
    />
}

module Description = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <DrawerPrimitive.Description
      ?id
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="drawer-description"
      className={cn("text-muted-foreground text-sm", className)}
      ?children
    />
}
