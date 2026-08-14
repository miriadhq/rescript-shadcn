@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@unboxed
type state =
  | @as("expanded") Expanded
  | @as("collapsed") Collapsed

type sidebar = {
  state: state,
  @as("open") open_: bool,
  setOpen: bool => unit,
  openMobile: bool,
  setOpenMobile: bool => unit,
  isMobile: bool,
  toggleSidebar: unit => unit,
}

type browserWindow
type mediaQueryList
type windowKeyboardEvent

@val external browserWindow: browserWindow = "window"
@val external browserDocument: Dom.document = "document"
@get external windowInnerWidth: browserWindow => int = "innerWidth"
@send external windowMatchMedia: (browserWindow, string) => mediaQueryList = "matchMedia"
@send
external addMediaQueryListener: (mediaQueryList, string, unit => unit) => unit = "addEventListener"
@send
external removeMediaQueryListener: (mediaQueryList, string, unit => unit) => unit =
  "removeEventListener"
@send
external addWindowListener: (browserWindow, string, windowKeyboardEvent => unit) => unit =
  "addEventListener"
@send
external removeWindowListener: (browserWindow, string, windowKeyboardEvent => unit) => unit =
  "removeEventListener"
@get external keyboardEventKey: windowKeyboardEvent => string = "key"
@get external keyboardEventMetaKey: windowKeyboardEvent => bool = "metaKey"
@get external keyboardEventCtrlKey: windowKeyboardEvent => bool = "ctrlKey"
@send external preventDefaultKeyboardEvent: windowKeyboardEvent => unit = "preventDefault"
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

let context: React.Context.t<option<sidebar>> = React.createContext(None)

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

@unboxed
type variant =
  | @as("sidebar") Sidebar
  | @as("floating") Floating
  | @as("inset") Inset

@unboxed
type side =
  | @as("left") Left
  | @as("right") Right

@unboxed
type collapsible =
  | @as("offcanvas") Offcanvas
  | @as("icon") Icon
  | @as("none") NotCollapsible

type props = {
  side?: side,
  variant?: variant,
  collapsible?: collapsible,
  ...ReactAria.Common.elementProps,
}
let contentDomProps: props => ReactAria.Types.DomProps.t = %raw(
  `({side, variant, collapsible, className, children, dir, ...props}) => props`
)
let mobileSheetProps: props => Sheet.props = %raw(
  `({side, variant, collapsible, className, children, dir, style, ...props}) => props`
)

@react.componentWithProps(props)
let make = (props: props) => {
  let {isMobile, state, openMobile, setOpenMobile} = use()
  let side = props.side->Option.getOr(Left)
  let variant = props.variant->Option.getOr(Sidebar)
  let collapsible = props.collapsible->Option.getOr(Offcanvas)

  if collapsible == NotCollapsible {
    <div
      {...props->contentDomProps}
      dataSlot={props.dataSlot->Option.getOr("sidebar")}
      className={cn(
        "bg-sidebar text-sidebar-foreground flex h-full w-(--sidebar-width) flex-col",
        props.className,
      )}
    >
      {props.children->Option.getOr(React.null)}
    </div>
  } else if isMobile {
    let mobileStyle = props.style->Option.getOr(
      ReactDOM.Style._dictToStyle(dict{"--sidebar-width": sidebarWidthMobile}),
    )
    <Sheet
        {...props->mobileSheetProps}
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
        <div className="flex h-full w-full flex-col"> {props.children->Option.getOr(React.null)} </div>
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
        {...props->contentDomProps}
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
    @as("open") open_?: bool,
    onOpenChange?: bool => unit,
    ...ReactAria.Common.elementProps,
  }
  let domProps: props => ReactAria.Types.DomProps.t = %raw(
    `({defaultOpen, open, onOpenChange, ...props}) => props`
  )

  @react.componentWithProps(props)
  let make = (props: props) => {
    let defaultOpen = props.defaultOpen->Option.getOr(true)
    let isMobile = useIsMobile()
    let (openMobile, setOpenMobileState) = React.useState(() => false)
    let (internalOpen, setInternalOpenState) = React.useState(() => defaultOpen)
    let isOpen = props.open_->Option.getOr(internalOpen)
    let setSidebarCookie = (nextOpen: bool) =>
      browserDocument->setDocumentCookie(
        `${sidebarCookieName}=${nextOpen ? "true" : "false"}; path=/; max-age=${Int.toString(
            sidebarCookieMaxAge,
          )}`,
      )
    let setOpenMobile = (nextOpen: bool) => setOpenMobileState(_ => nextOpen)
    let setOpen = (nextOpen: bool) => {
      switch props.onOpenChange {
      | Some(setOpenProp) => setOpenProp(nextOpen)
      | None => setInternalOpenState(_ => nextOpen)
      }
      setSidebarCookie(nextOpen)
    }
    let toggleSidebar = () =>
      if isMobile {
        setOpenMobileState(previousOpen => !previousOpen)
      } else {
        switch props.open_ {
        | Some(currentOpen) =>
          let nextOpen = !currentOpen
          switch props.onOpenChange {
          | Some(setOpenProp) => setOpenProp(nextOpen)
          | None => ()
          }
          setSidebarCookie(nextOpen)
        | None =>
          setInternalOpenState(previousOpen => {
            let nextOpen = !previousOpen
            switch props.onOpenChange {
            | Some(setOpenProp) => setOpenProp(nextOpen)
            | None => ()
            }
            setSidebarCookie(nextOpen)
            nextOpen
          })
        }
      }

    React.useEffect(() => {
      let handleKeyDown = (event: windowKeyboardEvent) => {
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

    let contextValue = Some({
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
        {...props->domProps}
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
      className={cn(
        "cn-sidebar-inset relative flex w-full flex-1 flex-col",
        props.className,
      )}
    />
}

module Input = {
  @react.componentWithProps(ReactAria.Input.props)
  let make = (props: ReactAria.Input.props) =>
    <Aria.Input
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
      className={cn(
        "cn-sidebar-group relative flex w-full min-w-0 flex-col",
        props.className,
      )}
    />
}

module GroupLabel = {
  @module("react")
  external createElement: (
    React.component<ReactAria.Button.props>,
    ReactAria.Button.props,
  ) => React.element = "createElement"

  type props = {elementType?: React.component<ReactAria.Button.props>, ...ReactAria.Button.props}
  let buttonProps: props => ReactAria.Button.props = %raw(
    `({elementType, ...props}) => props`
  )
  let domProps: ReactAria.Button.props => ReactAria.Types.DomProps.t = %raw(`props => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let componentProps = {
      ...props->buttonProps,
      dataSlot: props.dataSlot->Option.getOr("sidebar-group-label"),
      dataSidebar: props.dataSidebar->Option.getOr("group-label"),
      className: cn(
        "cn-sidebar-group-label flex shrink-0 items-center outline-hidden [&>svg]:shrink-0",
        props.className,
      ),
    }
    switch props.elementType {
    | Some(elementType) => createElement(elementType, componentProps)
    | None => <div {...componentProps->domProps} />
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

  type props<'tooltip> = {
    ...ReactAria.Button.props,
    href?: string,
    target?: string,
    rel?: string,
    download?: string,
    variant?: Variant.t,
    size?: Size.t,
    isActive?: bool,
    tooltip?: 'tooltip,
    render?: ReactAria.Button.Link.renderProps => React.element,
  }

  let buttonProps: props<'tooltip> => ReactAria.Button.props = %raw(`({
    href,
    target,
    rel,
    download,
    variant,
    size,
    isActive,
    tooltip,
    ...props
  }) => props`)

  let linkProps: props<'tooltip> => ReactAria.Button.Link.props = %raw(`({
    variant,
    size,
    isActive,
    tooltip,
    preventFocusOnPress,
    allowFocusWhenDisabled,
    excludeFromTabOrder,
    type,
    ...props
  }) => props`)

  let tooltipProps: 'tooltip => Tooltip.contentProps = %raw(
    `tooltip => typeof tooltip === "string" ? {children: tooltip} : tooltip`
  )

  @react.componentWithProps(props)
  let make = (props: props<'tooltip>) => {
    let {isMobile, state} = use()
    let variant = props.variant->Option.getOr(Variant.Default)
    let size = props.size->Option.getOr(Size.Default)
    let isActive = props.isActive->Option.getOr(false)
    let className = cn(sidebarMenuButtonVariants(~variant, ~size), props.className)
    let comp = switch props.href {
    | Some(_) =>
      <ReactAria.Button.Link
        {...props->linkProps}
        dataSlot="sidebar-menu-button"
        dataSidebar="menu-button"
        dataSize={(size :> string)}
        dataActive={isActive}
        className
      />
    | None =>
      <ReactAria.Button
        {...props->buttonProps}
        dataSlot="sidebar-menu-button"
        dataSidebar="menu-button"
        dataSize={(size :> string)}
        dataActive={isActive}
        className
      />
    }
    switch props.tooltip {
    | None => comp
    | Some(tooltip) =>
      let tooltip = tooltip->tooltipProps
      <Tooltip.Trigger isDisabled={state !== Collapsed || isMobile}>
        {comp}
        <Tooltip
          {...tooltip}
          placement={tooltip.placement->Option.getOr(ReactAria.Common.Right)}
        />
      </Tooltip.Trigger>
    }
  }
}

module MenuAction = {
  type props = {showOnHover?: bool, ...ReactAria.Button.props}

  let buttonProps: props => ReactAria.Button.props = %raw(`({showOnHover, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let showOnHoverClass = props.showOnHover->Option.getOr(false)
      ? "peer-data-active/menu-button:text-sidebar-accent-foreground group-focus-within/menu-item:opacity-100 group-hover/menu-item:opacity-100 aria-expanded:opacity-100 md:opacity-0"
      : ""
    <ReactAria.Button
      {...props->buttonProps}
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
  let domProps: props => ReactAria.Types.DomProps.t = %raw(`({showIcon, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let showIcon = props.showIcon->Option.getOr(false)
    let (width, _setWidth) = React.useState(() =>
      `${(mathRandom() *. 40. +. 50.)->mathFloor->Int.toString}%`
    )
    let textStyle = ReactDOM.Style._dictToStyle(
      dict{
        "--skeleton-width": width,
      },
    )
    <div
      {...props->domProps}
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
      className={cn(
        "cn-sidebar-menu-sub flex min-w-0 flex-col",
        props.className,
      )}
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
    render?: ReactAria.Button.Link.renderProps => React.element,
  }

  let buttonProps: props => ReactAria.Button.props = %raw(`({
    href,
    target,
    rel,
    download,
    size,
    isActive,
    ...props
  }) => props`)

  let linkProps: props => ReactAria.Button.Link.props = %raw(`({
    size,
    isActive,
    preventFocusOnPress,
    allowFocusWhenDisabled,
    excludeFromTabOrder,
    type,
    ...props
  }) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let size = props.size->Option.getOr(Size.Md)
    let isActive = props.isActive->Option.getOr(false)
    let className = cn(
      "cn-sidebar-menu-sub-button flex min-w-0 -translate-x-px items-center overflow-hidden outline-hidden group-data-[collapsible=icon]:hidden disabled:pointer-events-none disabled:opacity-50 aria-disabled:pointer-events-none aria-disabled:opacity-50 [&>span:last-child]:truncate [&>svg]:shrink-0",
      props.className,
    )
    switch props.href {
    | Some(_) =>
      <ReactAria.Button.Link
        {...props->linkProps}
        dataSlot="sidebar-menu-sub-button"
        dataSidebar="menu-sub-button"
        dataSize={(size :> string)}
        dataActive={isActive}
        className
      />
    | None =>
      <ReactAria.Button
        {...props->buttonProps}
        dataSlot="sidebar-menu-sub-button"
        dataSidebar="menu-sub-button"
        dataSize={(size :> string)}
        dataActive={isActive}
        className
      />
    }
  }
}
