@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module State = {
  @unboxed
  type t =
    | @as("expanded") Expanded
    | @as("collapsed") Collapsed
}

module ContextValue = {
  type t = {
    state: State.t,
    @as("open") open_: bool,
    setOpen: bool => unit,
    openMobile: bool,
    setOpenMobile: bool => unit,
    isMobile: bool,
    toggleSidebar: unit => unit,
  }
}

module BrowserWindow = {
  type t
}
module MediaQueryList = {
  type t
}
module WindowKeyboardEvent = {
  type t
}

@val external browserWindow: BrowserWindow.t = "window"
@val external browserDocument: Dom.document = "document"
@get external windowInnerWidth: BrowserWindow.t => int = "innerWidth"
@send external windowMatchMedia: (BrowserWindow.t, string) => MediaQueryList.t = "matchMedia"
@send
external addMediaQueryListener: (MediaQueryList.t, string, unit => unit) => unit =
  "addEventListener"
@send
external removeMediaQueryListener: (MediaQueryList.t, string, unit => unit) => unit =
  "removeEventListener"
@send
external addWindowListener: (BrowserWindow.t, string, WindowKeyboardEvent.t => unit) => unit =
  "addEventListener"
@send
external removeWindowListener: (BrowserWindow.t, string, WindowKeyboardEvent.t => unit) => unit =
  "removeEventListener"
@get external keyboardEventKey: WindowKeyboardEvent.t => string = "key"
@get external keyboardEventMetaKey: WindowKeyboardEvent.t => bool = "metaKey"
@get external keyboardEventCtrlKey: WindowKeyboardEvent.t => bool = "ctrlKey"
@send external preventDefaultKeyboardEvent: WindowKeyboardEvent.t => unit = "preventDefault"
@set external setDocumentCookie: (Dom.document, string) => unit = "cookie"
@val external mathRandom: unit => float = "Math.random"
@val @scope("Math") external mathFloor: float => int = "floor"
let sidebarCookieName = "sidebar_state"
let sidebarCookieMaxAge = 60 * 60 * 24 * 7
let sidebarWidth = "16rem"
let sidebarWidthMobile = "18rem"
let sidebarWidthIcon = "3rem"
let sidebarKeyboardShortcut = "b"
let mobileBreakpoint = 768

let context: React.Context.t<option<ContextValue.t>> = React.createContext(None)

@throws(JsExn)
let use = () =>
  switch React.useContext(context) {
  | Some(sidebar) => sidebar
  | None => JsError.throwWithMessage("use must be used within a SidebarProvider.")
  }

let useIsMobile = () => {
  let (isMobile, setIsMobile) = React.useState(() => false)
  React.useEffect0(() => {
    let mediaQuery =
      browserWindow->windowMatchMedia(`(max-width: ${Int.toString(mobileBreakpoint - 1)}px)`)
    let onChange = () => {
      let nextIsMobile = browserWindow->windowInnerWidth < mobileBreakpoint
      setIsMobile(_ => nextIsMobile)
    }

    mediaQuery->addMediaQueryListener("change", onChange)
    onChange()

    Some(() => mediaQuery->removeMediaQueryListener("change", onChange))
  })
  isMobile
}

module Variant = {
  @unboxed
  type t =
    | @as("sidebar") Sidebar
    | @as("floating") Floating
    | @as("inset") Inset
}

module Side = {
  @unboxed
  type t =
    | @as("left") Left
    | @as("right") Right
}

module Collapsible = {
  @unboxed
  type t =
    | @as("offcanvas") Offcanvas
    | @as("icon") Icon
    | @as("none") NotCollapsible
}

type props = {
  side?: Side.t,
  variant?: Variant.t,
  collapsible?: Collapsible.t,
  ...ReactAria.Types.DomProps.t,
}

@react.componentWithProps(props)
let make = ({?side, ?variant, ?collapsible, ...ReactAria.Types.DomProps.t as props}) => {
  let {isMobile, state, openMobile, setOpenMobile} = use()
  let side = side->Option.getOr(Left)
  let variant = variant->Option.getOr(Sidebar)
  let collapsible = collapsible->Option.getOr(Offcanvas)

  if collapsible == NotCollapsible {
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("sidebar")}
      className={cn(
        "bg-sidebar text-sidebar-foreground flex h-full w-(--sidebar-width) flex-col",
        props.className,
      )}
    >
      {props.children->Option.getOr(React.null)}
    </div>
  } else if isMobile {
    let mobileStyle =
      props.style->Option.getOr(
        ReactDOM.Style._dictToStyle(dict{"--sidebar-width": sidebarWidthMobile}),
      )
    <Sheet
      isOpen={openMobile}
      onOpenChange={nextOpen => setOpenMobile(nextOpen)}
      dir=?props.dir
      dataSidebar={props.dataSidebar->Option.getOr("sidebar")}
      dataSlot={props.dataSlot->Option.getOr("sidebar")}
      dataMobile={props.dataMobile->Option.getOr("true")}
      className="w-(--sidebar-width) bg-sidebar p-0 text-sidebar-foreground [&>button]:hidden"
      side={side == Right ? Sheet.Side.Right : Sheet.Side.Left}
      style={mobileStyle}
      showCloseButton={false}
    >
      <Sheet.Header className="sr-only">
        <Sheet.Title> {"Sidebar"->React.string} </Sheet.Title>
        <Sheet.Description> {"Displays the mobile sidebar."->React.string} </Sheet.Description>
      </Sheet.Header>
      <div className="flex h-full w-full flex-col">
        {props.children->Option.getOr(React.null)}
      </div>
    </Sheet>
  } else {
    let desktopGapClass = switch variant {
    | Floating
    | Inset => "group-data-[collapsible=icon]:w-[calc(var(--sidebar-width-icon)+(--spacing(4)))]"
    | Sidebar => "group-data-[collapsible=icon]:w-(--sidebar-width-icon)"
    }
    let desktopContainerClass = switch variant {
    | Floating
    | Inset => "p-2 group-data-[collapsible=icon]:w-[calc(var(--sidebar-width-icon)+(--spacing(4))+2px)]"
    | Sidebar => "group-data-[collapsible=icon]:w-(--sidebar-width-icon) group-data-[side=left]:border-r group-data-[side=right]:border-l"
    }

    <div
      dataState={(state :> string)}
      dataCollapsible={switch state {
      | Collapsed => (collapsible :> string)
      | Expanded => ""
      }}
      dataSide={(side :> string)}
      dataVariant={(variant :> string)}
      dataSlot="sidebar"
      className="group peer text-sidebar-foreground hidden md:block"
    >
      <div
        dataSlot="sidebar-gap"
        className={`cn-sidebar-gap relative w-(--sidebar-width) bg-transparent group-data-[collapsible=offcanvas]:w-0 group-data-[side=right]:rotate-180 ${desktopGapClass}`}
      />
      <div
        {...props}
        dataSlot={props.dataSlot->Option.getOr("sidebar-container")}
        dataSide={(side :> string)}
        className={cn(
          `fixed inset-y-0 z-10 hidden h-svh w-(--sidebar-width) transition-[left,right,width] duration-200 ease-linear data-[side=left]:left-0 data-[side=left]:group-data-[collapsible=offcanvas]:left-[calc(var(--sidebar-width)*-1)] data-[side=right]:right-0 data-[side=right]:group-data-[collapsible=offcanvas]:right-[calc(var(--sidebar-width)*-1)] md:flex ${desktopContainerClass}`,
          props.className,
        )}
      >
        <div
          dataSidebar="sidebar"
          dataSlot="sidebar-inner"
          className="cn-sidebar-inner flex size-full flex-col"
          children={props.children->Option.getOr(React.null)}
        />
      </div>
    </div>
  }
}

module Provider = {
  type props = {
    defaultOpen?: bool,
    onOpenChange?: bool => unit,
    ...ReactAria.Types.DomProps.t,
  }
  @react.componentWithProps(props) @warning("-112")
  let make = ({?defaultOpen, ?open_, ?onOpenChange, ...ReactAria.Types.DomProps.t as props}) => {
    let defaultOpen = defaultOpen->Option.getOr(true)
    let isMobile = useIsMobile()
    let (openMobile, setOpenMobileState) = React.useState(() => false)
    let (internalOpen, setInternalOpenState) = React.useState(() => defaultOpen)
    let isOpen = open_->Option.getOr(internalOpen)
    let setSidebarCookie = (nextOpen: bool) =>
      browserDocument->setDocumentCookie(
        `${sidebarCookieName}=${nextOpen ? "true" : "false"}; path=/; max-age=${Int.toString(
            sidebarCookieMaxAge,
          )}`,
      )
    let setOpenMobile = (nextOpen: bool) => setOpenMobileState(_ => nextOpen)
    let setOpen = (nextOpen: bool) => {
      switch onOpenChange {
      | Some(setOpenProp) => setOpenProp(nextOpen)
      | None => setInternalOpenState(_ => nextOpen)
      }
      setSidebarCookie(nextOpen)
    }
    let toggleSidebar = () =>
      if isMobile {
        setOpenMobileState(previousOpen => !previousOpen)
      } else {
        switch open_ {
        | Some(currentOpen) =>
          let nextOpen = !currentOpen
          switch onOpenChange {
          | Some(setOpenProp) => setOpenProp(nextOpen)
          | None => ()
          }
          setSidebarCookie(nextOpen)
        | None =>
          setInternalOpenState(previousOpen => {
            let nextOpen = !previousOpen
            switch onOpenChange {
            | Some(setOpenProp) => setOpenProp(nextOpen)
            | None => ()
            }
            setSidebarCookie(nextOpen)
            nextOpen
          })
        }
      }

    React.useEffect(() => {
      let handleKeyDown = (event: WindowKeyboardEvent.t) => {
        if (
          event->keyboardEventKey == sidebarKeyboardShortcut &&
            (event->keyboardEventMetaKey || event->keyboardEventCtrlKey)
        ) {
          event->preventDefaultKeyboardEvent
          toggleSidebar()
        }
      }

      browserWindow->addWindowListener("keydown", handleKeyDown)
      Some(() => browserWindow->removeWindowListener("keydown", handleKeyDown))
    }, [isMobile, isOpen, openMobile])

    let contextValue: option<ContextValue.t> = Some({
      state: isOpen ? Expanded : Collapsed,
      open_: isOpen,
      setOpen,
      openMobile,
      setOpenMobile,
      isMobile,
      toggleSidebar,
    })

    let baseStyle = ReactDOM.Style._dictToStyle(
      dict{
        "--sidebar-width": sidebarWidth,
        "--sidebar-width-icon": sidebarWidthIcon,
      },
    )
    let resolvedStyle = switch props.style {
    | Some(style) => ReactDOM.Style.combine(baseStyle, style)
    | None => baseStyle
    }
    module ContextProvider = {
      let make = React.Context.provider(context)
    }

    <ContextProvider value={contextValue}>
      <div
        {...props}
        style={resolvedStyle}
        dataSlot={props.dataSlot->Option.getOr("sidebar-wrapper")}
        className={cn(
          "group/sidebar-wrapper has-data-[variant=inset]:bg-sidebar flex min-h-svh w-full",
          props.className,
        )}
      />
    </ContextProvider>
  }
}

module Trigger = {
  @react.componentWithProps(Button.props)
  let make = (props: Button.props) => {
    let {toggleSidebar} = use()
    let onPress = event => {
      props.onPress->Option.forEach(onPress => onPress(event))
      toggleSidebar()
    }
    <Button
      {...props}
      className={cn("cn-sidebar-trigger", props.className)}
      variant={props.variant->Option.getOr(Ghost)}
      size={props.size->Option.getOr(IconSm)}
      dataSidebar="trigger"
      dataSlot="sidebar-trigger"
      onPress
    >
      <Icons.PanelLeft className="cn-rtl-flip" />
      <span className="sr-only"> {"Toggle Sidebar"->React.string} </span>
    </Button>
  }
}

module Rail = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) => {
    let {toggleSidebar} = use()
    let onClick = switch props.onClick {
    | Some(onClick) => onClick
    | None => _ => toggleSidebar()
    }
    <button
      {...props}
      onClick
      ariaLabel="Toggle Sidebar"
      tabIndex={-1}
      dataSidebar="rail"
      dataSlot="sidebar-rail"
      className={cn(
        "cn-sidebar-rail absolute inset-y-0 z-20 hidden w-4 transition-all ease-linear group-data-[side=left]:-right-4 group-data-[side=right]:left-0 after:absolute after:inset-y-0 after:start-1/2 after:w-[2px] sm:flex ltr:-translate-x-1/2 rtl:-translate-x-1/2 in-data-[side=left]:cursor-w-resize in-data-[side=right]:cursor-e-resize [[data-side=left][data-state=collapsed]_&]:cursor-e-resize [[data-side=right][data-state=collapsed]_&]:cursor-w-resize hover:group-data-[collapsible=offcanvas]:bg-sidebar group-data-[collapsible=offcanvas]:translate-x-0 group-data-[collapsible=offcanvas]:after:left-full [[data-side=left][data-collapsible=offcanvas]_&]:-right-2 [[data-side=right][data-collapsible=offcanvas]_&]:-left-2",
        props.className,
      )}
      title="Toggle Sidebar"
    />
  }
}

module Inset = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <main
      {...props}
      dataSlot={props.dataSlot->Option.getOr("sidebar-inset")}
      className={cn("cn-sidebar-inset relative flex w-full flex-1 flex-col", props.className)}
    />
}

module AriaInput = Input

module Input = {
  @react.componentWithProps(ReactAria.Input.props)
  let make = (props: ReactAria.Input.props) =>
    <AriaInput
      {...props}
      dataSlot="sidebar-input"
      dataSidebar="input"
      className={cn("cn-sidebar-input", props.className)}
    />
}

module Header = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("sidebar-header")}
      dataSidebar={props.dataSidebar->Option.getOr("header")}
      className={cn("cn-sidebar-header flex flex-col", props.className)}
    />
}

module Footer = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("sidebar-footer")}
      dataSidebar={props.dataSidebar->Option.getOr("footer")}
      className={cn("cn-sidebar-footer flex flex-col", props.className)}
    />
}

module Separator = {
  @react.componentWithProps(ReactAria.Separator.props)
  let make = (props: ReactAria.Separator.props) =>
    <ReactAria.Separator
      {...props}
      dataSlot={props.dataSlot->Option.getOr("sidebar-separator")}
      dataSidebar={props.dataSidebar->Option.getOr("separator")}
      className={cn("cn-sidebar-separator w-auto", props.className)}
    />
}

module Content = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("sidebar-content")}
      dataSidebar={props.dataSidebar->Option.getOr("content")}
      className={cn(
        "cn-sidebar-content flex min-h-0 flex-1 flex-col overflow-auto group-data-[collapsible=icon]:overflow-hidden",
        props.className,
      )}
    />
}

module Group = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("sidebar-group")}
      dataSidebar={props.dataSidebar->Option.getOr("group")}
      className={cn("cn-sidebar-group relative flex w-full min-w-0 flex-col", props.className)}
    />
}

module GroupLabel = {
  @module("react")
  external createElement: (
    React.component<ReactAria.Button.props>,
    ReactAria.Button.props,
  ) => React.element = "createElement"
  @module("react")
  external createDomElement: (string, ReactAria.Common.ElementProps.t) => React.element =
    "createElement"

  type props = {elementType?: React.component<ReactAria.Button.props>, ...ReactAria.Button.props}

  @react.componentWithProps(props)
  let make = ({?elementType, ...ReactAria.Button.props as props}) => {
    let componentProps = {
      ...props,
      dataSlot: props.dataSlot->Option.getOr("sidebar-group-label"),
      dataSidebar: props.dataSidebar->Option.getOr("group-label"),
      className: cn(
        "cn-sidebar-group-label flex shrink-0 items-center outline-hidden [&>svg]:shrink-0",
        props.className,
      ),
    }
    switch elementType {
    | Some(elementType) => createElement(elementType, componentProps)
    | None =>
      let {
        isPending: ?_,
        isDisabled: ?_,
        preventFocusOnPress: ?_,
        allowFocusWhenDisabled: ?_,
        excludeFromTabOrder: ?_,
        name: ?_,
        value: ?_,
        form: ?_,
        formAction: ?_,
        formMethod: ?_,
        formNoValidate: ?_,
        formTarget: ?_,
        type_: ?_,
        ...ReactAria.Common.ElementProps.t as props,
      } = componentProps
      createDomElement("div", props)
    }
  }
}

module GroupAction = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <button
      {...props}
      dataSlot={props.dataSlot->Option.getOr("sidebar-group-action")}
      dataSidebar={props.dataSidebar->Option.getOr("group-action")}
      className={cn(
        "cn-sidebar-group-action flex aspect-square items-center justify-center outline-hidden transition-transform [&>svg]:shrink-0 after:absolute after:-inset-2 md:after:hidden group-data-[collapsible=icon]:hidden",
        props.className,
      )}
    />
}

module GroupContent = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("sidebar-group-content")}
      dataSidebar={props.dataSidebar->Option.getOr("group-content")}
      className={cn("cn-sidebar-group-content w-full", props.className)}
    />
}

module Menu = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("sidebar-menu")}
      dataSidebar={props.dataSidebar->Option.getOr("menu")}
      className={cn("cn-sidebar-menu flex w-full min-w-0 flex-col", props.className)}
    />
}

module MenuItem = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("sidebar-menu-item")}
      dataSidebar={props.dataSidebar->Option.getOr("menu-item")}
      className={cn("group/menu-item relative", props.className)}
    />
}

module MenuButton = {
  module Variant = {
    @unboxed
    type t =
      | @as("default") Default
      | @as("outline") Outline
  }
  module Size = {
    @unboxed
    type t =
      | @as("default") Default
      | @as("sm") Sm
      | @as("lg") Lg
  }

  module TooltipValue = {
    @unboxed
    type t =
      | Text(string)
      | Props(Tooltip.ContentProps.t)

    let toProps = value =>
      switch value {
      | Text(text) => ({children: text->React.string}: Tooltip.ContentProps.t)
      | Props(props) => props
      }
  }

  let sidebarMenuButtonVariants = (~variant=Variant.Default, ~size=Size.Default) => {
    let base = "cn-sidebar-menu-button cn-sidebar-menu-button-aria peer/menu-button flex w-full items-center overflow-hidden outline-hidden group/menu-button disabled:pointer-events-none disabled:opacity-50 aria-disabled:pointer-events-none aria-disabled:opacity-50 [&>span:last-child]:truncate [&_svg]:size-4 [&_svg]:shrink-0"
    let variantClass = switch variant {
    | Variant.Outline => "cn-sidebar-menu-button-variant-outline"
    | Default => "cn-sidebar-menu-button-variant-default"
    }
    let sizeClass = switch size {
    | Sm => "cn-sidebar-menu-button-size-sm"
    | Lg => "cn-sidebar-menu-button-size-lg"
    | Default => "cn-sidebar-menu-button-size-default"
    }
    `${base} ${variantClass} ${sizeClass}`
  }

  type props = {
    ...ReactAria.Button.props,
    href?: string,
    target?: string,
    rel?: string,
    download?: string,
    variant?: Variant.t,
    size?: Size.t,
    isActive?: bool,
    tooltip?: TooltipValue.t,
    render?: ReactAria.Button.Link.RenderProps.t => React.element,
  }

  @react.componentWithProps(props)
  let make = (
    {
      ?href,
      target: ?_,
      rel: ?_,
      download: ?_,
      ?variant,
      ?size,
      ?isActive,
      ?tooltip,
      render: ?_,
      ...ReactAria.Button.props as buttonProps,
    } as allProps,
  ) => {
    let {isMobile, state} = use()
    let variant = variant->Option.getOr(Variant.Default)
    let size = size->Option.getOr(Size.Default)
    let isActive = isActive->Option.getOr(false)
    let className = cn(sidebarMenuButtonVariants(~variant, ~size), buttonProps.className)
    let comp = switch href {
    | Some(_) =>
      let {
        variant: ?_,
        size: ?_,
        isActive: ?_,
        tooltip: ?_,
        isPending: ?_,
        preventFocusOnPress: ?_,
        allowFocusWhenDisabled: ?_,
        excludeFromTabOrder: ?_,
        name: ?_,
        value: ?_,
        form: ?_,
        formAction: ?_,
        formMethod: ?_,
        formNoValidate: ?_,
        formTarget: ?_,
        type_: ?_,
        ...ReactAria.Button.Link.props as linkProps,
      } = allProps
      <ReactAria.Button.Link
        {...linkProps}
        dataSlot="sidebar-menu-button"
        dataSidebar="menu-button"
        dataSize={(size :> string)}
        dataActive={isActive}
        className
      />
    | None =>
      <ReactAria.Button
        {...buttonProps}
        dataSlot="sidebar-menu-button"
        dataSidebar="menu-button"
        dataSize={(size :> string)}
        dataActive={isActive}
        className
      />
    }
    switch tooltip {
    | None => comp
    | Some(tooltip) =>
      let tooltip = tooltip->TooltipValue.toProps
      <Tooltip.Trigger isDisabled={state !== Collapsed || isMobile}>
        {comp}
        <Tooltip
          {...tooltip} placement={tooltip.placement->Option.getOr(ReactAria.Common.Placement.Right)}
        />
      </Tooltip.Trigger>
    }
  }
}

module MenuAction = {
  type props = {showOnHover?: bool, ...ReactAria.Button.props}

  @react.componentWithProps(props)
  let make = ({?showOnHover, ...ReactAria.Button.props as props}) => {
    let showOnHoverClass =
      showOnHover->Option.getOr(false)
        ? "peer-data-active/menu-button:text-sidebar-accent-foreground group-focus-within/menu-item:opacity-100 group-hover/menu-item:opacity-100 aria-expanded:opacity-100 md:opacity-0"
        : ""
    <ReactAria.Button
      {...props}
      dataSlot="sidebar-menu-action"
      dataSidebar="menu-action"
      className={cn(
        `cn-sidebar-menu-action flex items-center justify-center outline-hidden transition-transform group-data-[collapsible=icon]:hidden after:absolute after:-inset-2 md:after:hidden [&>svg]:shrink-0 ${showOnHoverClass}`,
        props.className,
      )}
    />
  }
}

module MenuBadge = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("sidebar-menu-badge")}
      dataSidebar={props.dataSidebar->Option.getOr("menu-badge")}
      className={cn(
        "cn-sidebar-menu-badge flex items-center justify-center tabular-nums select-none group-data-[collapsible=icon]:hidden",
        props.className,
      )}
    />
}

module MenuSkeleton = {
  type props = {showIcon?: bool, ...ReactAria.Types.DomProps.t}

  @react.componentWithProps(props)
  let make = ({?showIcon, ...ReactAria.Types.DomProps.t as props}) => {
    let showIcon = showIcon->Option.getOr(false)
    let (width, _setWidth) = React.useState(() =>
      `${(mathRandom() *. 40. +. 50.)->mathFloor->Int.toString}%`
    )
    let textStyle = ReactDOM.Style._dictToStyle(
      dict{
        "--skeleton-width": width,
      },
    )
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("sidebar-menu-skeleton")}
      dataSidebar={props.dataSidebar->Option.getOr("menu-skeleton")}
      className={cn("cn-sidebar-menu-skeleton flex items-center", props.className)}
    >
      {showIcon
        ? <Skeleton className="cn-sidebar-menu-skeleton-icon" dataSidebar="menu-skeleton-icon" />
        : React.null}
      <Skeleton
        className="cn-sidebar-menu-skeleton-text max-w-(--skeleton-width) flex-1"
        dataSidebar="menu-skeleton-text"
        style={textStyle}
      />
    </div>
  }
}

module MenuSub = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <ul
      {...props}
      dataSlot={props.dataSlot->Option.getOr("sidebar-menu-sub")}
      dataSidebar={props.dataSidebar->Option.getOr("menu-sub")}
      className={cn("cn-sidebar-menu-sub flex min-w-0 flex-col", props.className)}
    />
}

module MenuSubItem = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <li
      {...props}
      dataSlot={props.dataSlot->Option.getOr("sidebar-menu-sub-item")}
      dataSidebar={props.dataSidebar->Option.getOr("menu-sub-item")}
      className={cn("group/menu-sub-item relative", props.className)}
    />
}

module MenuSubButton = {
  module Size = {
    @unboxed
    type t =
      | @as("sm") Sm
      | @as("md") Md
  }

  type props = {
    ...ReactAria.Button.props,
    href?: string,
    target?: string,
    rel?: string,
    download?: string,
    size?: Size.t,
    isActive?: bool,
    render?: ReactAria.Button.Link.RenderProps.t => React.element,
  }

  @react.componentWithProps(props)
  let make = (
    {
      ?href,
      target: ?_,
      rel: ?_,
      download: ?_,
      ?size,
      ?isActive,
      render: ?_,
      ...ReactAria.Button.props as buttonProps,
    } as allProps,
  ) => {
    let size = size->Option.getOr(Size.Md)
    let isActive = isActive->Option.getOr(false)
    let className = cn(
      "cn-sidebar-menu-sub-button flex min-w-0 -translate-x-px items-center overflow-hidden outline-hidden group-data-[collapsible=icon]:hidden disabled:pointer-events-none disabled:opacity-50 aria-disabled:pointer-events-none aria-disabled:opacity-50 [&>span:last-child]:truncate [&>svg]:shrink-0",
      buttonProps.className,
    )
    switch href {
    | Some(_) =>
      let {
        size: ?_,
        isActive: ?_,
        isPending: ?_,
        preventFocusOnPress: ?_,
        allowFocusWhenDisabled: ?_,
        excludeFromTabOrder: ?_,
        name: ?_,
        value: ?_,
        form: ?_,
        formAction: ?_,
        formMethod: ?_,
        formNoValidate: ?_,
        formTarget: ?_,
        type_: ?_,
        ...ReactAria.Button.Link.props as linkProps,
      } = allProps
      <ReactAria.Button.Link
        {...linkProps}
        dataSlot="sidebar-menu-sub-button"
        dataSidebar="menu-sub-button"
        dataSize={(size :> string)}
        dataActive={isActive}
        className
      />
    | None =>
      <ReactAria.Button
        {...buttonProps}
        dataSlot="sidebar-menu-sub-button"
        dataSidebar="menu-sub-button"
        dataSize={(size :> string)}
        dataActive={isActive}
        className
      />
    }
  }
}
