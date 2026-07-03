open BaseUi.Types

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

let navigationMenuTriggerStyle = () =>
  "cn-navigation-menu-trigger bg-background group/navigation-menu-trigger inline-flex h-9 w-max items-center justify-center disabled:pointer-events-none outline-none"

@react.component
let make = (
  ~className=?,
  ~children=React.null,
  ~id=?,
  ~dir=?,
  ~style=?,
  ~onClick=?,
  ~onKeyDown=?,
  ~value=?,
  ~defaultValue=?,
  ~onValueChange=?,
  ~align=Align.Start,
) =>
  <BaseUi.NavigationMenu.Root
    ?id
    ?dir
    ?style
    ?onClick
    ?onKeyDown
    ?value
    ?defaultValue
    ?onValueChange
    dataSlot="navigation-menu"
    className={cn(
      "cn-navigation-menu group/navigation-menu relative flex flex-1 items-center justify-center",
      className,
    )}
  >
    {children}
    <BaseUi.NavigationMenu.Portal>
      <BaseUi.NavigationMenu.Positioner
        side={Side.Bottom}
        sideOffset={Const(8.)}
        align
        alignOffset={Const(0.)}
        className="cn-navigation-menu-positioner isolate z-50 h-(--positioner-height) w-(--positioner-width) max-w-(--available-width) transition-[top,left,right,bottom] duration-[0.35s] ease-[cubic-bezier(0.22,1,0.36,1)] data-instant:transition-none data-[side=bottom]:before:top-[-10px] data-[side=bottom]:before:right-0 data-[side=bottom]:before:left-0"
      >
        <BaseUi.NavigationMenu.Popup
          className="cn-navigation-menu-popup bg-popover text-popover-foreground ring-foreground/10 data-[ending-style]:easing-[ease] xs:w-(--popup-width) relative h-(--popup-height) w-(--popup-width) origin-(--transform-origin) rounded-lg shadow ring-1 transition-[opacity,transform,width,height,scale,translate] duration-[0.35s] ease-[cubic-bezier(0.22,1,0.36,1)] outline-none data-ending-style:scale-90 data-ending-style:opacity-0 data-ending-style:duration-150 data-starting-style:scale-90 data-starting-style:opacity-0"
        >
          <BaseUi.NavigationMenu.Viewport className="relative size-full overflow-hidden" />
        </BaseUi.NavigationMenu.Popup>
      </BaseUi.NavigationMenu.Positioner>
    </BaseUi.NavigationMenu.Portal>
  </BaseUi.NavigationMenu.Root>

module List = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <BaseUi.NavigationMenu.List
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?children
      dataSlot="navigation-menu-list"
      className={cn("cn-navigation-menu-list group flex flex-1 list-none items-center justify-center", className)}
    />
}

module Item = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <BaseUi.NavigationMenu.Item
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?children
      dataSlot="navigation-menu-item"
      className={cn("cn-navigation-menu-item relative", className)}
    />
}

module Trigger = {
  @react.component
  let make = (
    ~className=?,
    ~children=React.null,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~disabled=?,
    ~render=?,
    ~nativeButton=?,
    ~type_=?,
    ~ariaLabel=?,
  ) => {
    let shouldSetDefaultType = switch (type_, nativeButton, render) {
    | (None, Some(false), _)
    | (None, _, Some(_))
    | (Some(_), _, _) => false
    | (None, _, _) => true
    }
    let content =
      <>
        {children}
        <Icons.ChevronDown
          ariaHidden=true
          className="cn-navigation-menu-trigger-icon"
        />
      </>
    if shouldSetDefaultType {
      <BaseUi.NavigationMenu.Trigger
        ?id
        ?style
        ?onClick
        ?onKeyDown
        ?disabled
        ?render
        ?nativeButton
        type_="button"
        ?ariaLabel
        dataSlot="navigation-menu-trigger"
        className={cn(`${navigationMenuTriggerStyle()} group`, className)}
      >
        {content}
      </BaseUi.NavigationMenu.Trigger>
    } else {
      <BaseUi.NavigationMenu.Trigger
        ?id
        ?style
        ?onClick
        ?onKeyDown
        ?disabled
        ?render
        ?nativeButton
        ?type_
        ?ariaLabel
        dataSlot="navigation-menu-trigger"
        className={cn(`${navigationMenuTriggerStyle()} group`, className)}
      >
        {content}
      </BaseUi.NavigationMenu.Trigger>
    }
  }
}

module Content = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~id=?,
    ~dir=?,
    ~dataLang=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
  ) =>
    <BaseUi.NavigationMenu.Content
      ?id
      ?dir
      ?dataLang
      ?style
      ?onClick
      ?onKeyDown
      ?children
      dataSlot="navigation-menu-content"
      className={cn(
        "cn-navigation-menu-content data-ending-style:data-activation-direction=left:translate-x-[50%] data-ending-style:data-activation-direction=right:translate-x-[-50%] data-starting-style:data-activation-direction=left:translate-x-[-50%] data-starting-style:data-activation-direction=right:translate-x-[50%] h-full w-auto transition-[opacity,transform,translate] duration-[0.35s] data-ending-style:opacity-0 data-starting-style:opacity-0 **:data-[slot=navigation-menu-link]:focus:ring-0 **:data-[slot=navigation-menu-link]:focus:outline-none",
        className,
      )}
    />
}

module Positioner = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~side=Side.Bottom,
    ~sideOffset=8.,
    ~align=Align.Start,
    ~alignOffset=0.,
    ~positionMethod=?,
  ) =>
    <BaseUi.NavigationMenu.Portal>
      <BaseUi.NavigationMenu.Positioner
        side
        sideOffset={Const(sideOffset)}
        align
        alignOffset={Const(alignOffset)}
        ?positionMethod
        className={cn(
          "cn-navigation-menu-positioner isolate z-50 h-(--positioner-height) w-(--positioner-width) max-w-(--available-width) transition-[top,left,right,bottom] duration-[0.35s] ease-[cubic-bezier(0.22,1,0.36,1)] data-instant:transition-none data-[side=bottom]:before:top-[-10px] data-[side=bottom]:before:right-0 data-[side=bottom]:before:left-0",
          className,
        )}
      >
        {switch children {
        | Some(value) => value
        | None =>
          <BaseUi.NavigationMenu.Popup
            className="cn-navigation-menu-popup bg-popover text-popover-foreground ring-foreground/10 data-[ending-style]:easing-[ease] xs:w-(--popup-width) relative h-(--popup-height) w-(--popup-width) origin-(--transform-origin) rounded-lg shadow ring-1 transition-[opacity,transform,width,height,scale,translate] duration-[0.35s] ease-[cubic-bezier(0.22,1,0.36,1)] outline-none data-ending-style:scale-90 data-ending-style:opacity-0 data-ending-style:duration-150 data-starting-style:scale-90 data-starting-style:opacity-0"
          >
            <BaseUi.NavigationMenu.Viewport className="relative size-full overflow-hidden" />
          </BaseUi.NavigationMenu.Popup>
        }}
      </BaseUi.NavigationMenu.Positioner>
    </BaseUi.NavigationMenu.Portal>
}

module Link = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~href=?,
    ~target=?,
    ~render=?,
    ~ariaCurrent=?,
    ~dataLang=?,
  ) =>
    <BaseUi.NavigationMenu.Link
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?href
      ?target
      ?render
      ?children
      ?ariaCurrent
      ?dataLang
      dataSlot="navigation-menu-link"
      className={cn(
        "cn-navigation-menu-link",
        className,
      )}
    />
}

module Indicator = {
  @react.component
  let make = (~className=?, ~id=?, ~style=?) =>
    <BaseUi.NavigationMenu.Icon
      ?id
      ?style
      dataSlot="navigation-menu-indicator"
      className={cn(
        "cn-navigation-menu-indicator top-full z-1 flex h-1.5 items-end justify-center overflow-hidden",
        className,
      )}
    >
      <div className="cn-navigation-menu-indicator-arrow relative top-[60%] h-2 w-2 rotate-45" />
    </BaseUi.NavigationMenu.Icon>
}
