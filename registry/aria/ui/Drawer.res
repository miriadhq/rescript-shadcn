@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module SwipeDirection = {
  @unboxed
  type t = BaseUi.Drawer.SwipeDirection.t =
    | @as("down") Down
    | @as("up") Up
    | @as("left") Left
    | @as("right") Right
}

module SnapPoint = {
  @unboxed
  type t = BaseUi.Drawer.SnapPoint.t =
    | Pixels(string)
    | Ratio(float)
}

module Context = {
  type t = {
    hasSnapPoints: bool,
    modal: BaseUi.Types.Modal.t,
    showSwipeHandle: bool,
    swipeDirection: SwipeDirection.t,
  }
}

let drawerContext: React.Context.t<nullable<Context.t>> = React.createContext(Nullable.null)

module ContextProvider = {
  let make = React.Context.provider(drawerContext)
}

let use = () =>
  switch React.useContext(drawerContext) {
  | Value(context) => context
  | Null | Undefined => throw(Invalid_argument("useDrawer must be used within a Drawer."))
  }

type props = {
  ...BaseUi.Drawer.Root.props,
  showSwipeHandle?: bool,
}

@react.componentWithProps(props)
let make = ({?showSwipeHandle, ...BaseUi.Drawer.Root.props as props}) => {
  let modal = props.modal->Option.getOr(BaseUi.Types.Modal.True)
  let showSwipeHandle = showSwipeHandle->Option.getOr(false)
  let swipeDirection = props.swipeDirection->Option.getOr(SwipeDirection.Down)
  let hasSnapPoints =
    props.snapPoints->Option.mapOr(false, snapPoints => snapPoints->Array.length > 0)
  let value: Context.t = {hasSnapPoints, modal, showSwipeHandle, swipeDirection}

  <ContextProvider value={value->Nullable.make}>
    <BaseUi.Drawer.Root {...props} dataSlot="drawer" modal swipeDirection />
  </ContextProvider>
}

module Trigger = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Drawer.Trigger {...props} dataSlot="drawer-trigger" />
}

module Portal = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Drawer.Portal {...props} dataSlot="drawer-portal" />
}

module Close = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Drawer.Close {...props} dataSlot="drawer-close" />
}

module Overlay = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Drawer.Backdrop
      {...props}
      dataSlot="drawer-overlay"
      className={cn(
        "cn-drawer-overlay fixed inset-0 z-50 min-h-dvh opacity-[max(var(--drawer-overlay-min-opacity,0),calc(1-var(--drawer-swipe-progress)))] transition-opacity duration-450 ease-[cubic-bezier(0.32,0.72,0,1)] select-none data-ending-style:pointer-events-none data-ending-style:opacity-0 data-ending-style:duration-[calc(var(--drawer-swipe-strength)*400ms)] data-snap-points:[--drawer-overlay-min-opacity:0.5] data-starting-style:opacity-0 data-swiping:duration-0 supports-[-webkit-touch-callout:none]:absolute",
        props.className,
      )}
    />
}

module SwipeHandle = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("drawer-swipe-handle")}
      ariaHidden={props.ariaHidden->Option.getOr(true)}
      className={cn(
        "cn-drawer-swipe-handle relative z-10 flex shrink-0 cursor-grab transition-opacity duration-200 group-data-nested-drawer-open/drawer-popup:opacity-0 group-data-nested-drawer-swiping/drawer-popup:opacity-100 group-data-[swipe-direction=left]/drawer-popup:order-last group-data-[swipe-direction=up]/drawer-popup:order-last active:cursor-grabbing",
        props.className,
      )}
    />
}

let popupClass = "cn-drawer-popup group/drawer-popup pointer-events-auto fixed z-50 m-(--drawer-inset,0px) flex h-(--drawer-content-height) max-h-(--drawer-content-max-height,none) min-h-0 w-(--drawer-content-width,auto) transform-[translate3d(var(--translate-x,0px),var(--translate-y,0px),0)_scale(var(--stack-scale))] flex-col transition-[transform,height,opacity,filter] duration-450 ease-[cubic-bezier(0.22,1,0.36,1)] will-change-transform outline-none select-none [interpolate-size:allow-keywords] data-nested-drawer-open:overflow-hidden data-nested-drawer-open:brightness-95 after:pointer-events-none after:absolute after:bg-(--drawer-bleed-background,var(--color-popover)) data-[swipe-axis=x]:after:inset-y-0 data-[swipe-axis=x]:after:w-(--bleed) data-[swipe-axis=y]:after:inset-x-0 data-[swipe-axis=y]:after:h-(--bleed) data-[swipe-direction=down]:after:top-full data-[swipe-direction=left]:after:right-full data-[swipe-direction=right]:after:left-full data-[swipe-direction=up]:after:bottom-full [--drawer-content-height:var(--drawer-height,auto)] data-[swipe-axis=x]:[--drawer-content-width:75%] data-[swipe-axis=y]:[--drawer-content-max-height:calc(100dvh-6rem)] data-[swipe-axis=y]:data-snap-points:[--drawer-content-height:100dvh] data-[swipe-axis=x]:sm:[--drawer-content-width:24rem] [--bleed:3rem] [--peek:1rem] [--stack-height:var(--drawer-frontmost-height,var(--drawer-height,0px))] [--stack-peek-offset:max(0px,calc((var(--nested-drawers)-var(--stack-progress))*var(--peek)))] [--stack-progress:clamp(0,var(--drawer-swipe-progress),1)] [--stack-scale-base:max(0,calc(1-(var(--nested-drawers)*var(--stack-step))))] [--stack-scale:clamp(0,calc(var(--stack-scale-base)+(var(--stack-step)*var(--stack-progress))),1)] [--stack-shrink:calc(1-var(--stack-scale))] [--stack-step:0.05] data-ending-style:transform-(--closed-transform) data-ending-style:opacity-[0.9999] data-ending-style:duration-[calc(var(--drawer-swipe-strength)*400ms)] data-nested-drawer-swiping:duration-0 data-ending-style:data-nested-drawer-swiping:duration-[calc(var(--drawer-swipe-strength)*400ms)] data-starting-style:transform-(--closed-transform) data-swiping:duration-0 data-ending-style:data-swiping:duration-[calc(var(--drawer-swipe-strength)*400ms)] data-[swipe-axis=y]:inset-x-0 data-[swipe-axis=y]:data-nested-drawer-open:h-(--stack-height) data-[swipe-axis=x]:inset-y-0 data-[swipe-axis=x]:flex-row data-[swipe-direction=down]:bottom-0 data-[swipe-direction=down]:origin-bottom data-[swipe-direction=down]:[--closed-transform:translate3d(0,calc(100%+var(--drawer-inset,0px)+2px),0)] data-[swipe-direction=down]:[--translate-y:calc(var(--drawer-snap-point-offset,0px)+var(--drawer-swipe-movement-y)-var(--stack-peek-offset)-(var(--stack-shrink)*var(--stack-height)))] data-[swipe-direction=up]:top-0 data-[swipe-direction=up]:origin-top data-[swipe-direction=up]:[--closed-transform:translate3d(0,calc(-100%-var(--drawer-inset,0px)-2px),0)] data-[swipe-direction=up]:[--translate-y:calc(var(--drawer-snap-point-offset,0px)+var(--drawer-swipe-movement-y)+var(--stack-peek-offset)+(var(--stack-shrink)*var(--stack-height)))] data-[swipe-direction=left]:left-0 data-[swipe-direction=left]:origin-left data-[swipe-direction=left]:[--closed-transform:translate3d(calc(-100%-var(--drawer-inset,0px)-2px),0,0)] data-[swipe-direction=left]:[--translate-x:calc(var(--drawer-swipe-movement-x)+var(--stack-peek-offset)+(var(--stack-shrink)*100%))] data-[swipe-direction=right]:right-0 data-[swipe-direction=right]:origin-right data-[swipe-direction=right]:[--closed-transform:translate3d(calc(100%+var(--drawer-inset,0px)+2px),0,0)] data-[swipe-direction=right]:[--translate-x:calc(var(--drawer-swipe-movement-x)-var(--stack-peek-offset)-(var(--stack-shrink)*100%))]"

module Content = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) => {
    let drawer = use()
    let swipeAxis = switch drawer.swipeDirection {
    | Down | Up => "y"
    | Left | Right => "x"
    }
    let dataSnapPoints = drawer.hasSnapPoints ? Some("") : None
    let isModal = switch drawer.modal {
    | True => true
    | False | TrapFocus => false
    }

    <Portal>
      {isModal ? <Overlay dataSnapPoints=?dataSnapPoints /> : React.null}
      <BaseUi.Drawer.Viewport
        dataSlot="drawer-viewport"
        dataModal=drawer.modal
        className="pointer-events-none fixed inset-0 z-50 select-none data-[modal=true]:pointer-events-auto"
      >
        <BaseUi.Drawer.Popup
          {...props}
          dataSlot="drawer-popup"
          dataSwipeAxis=swipeAxis
          dataSnapPoints=?dataSnapPoints
          className={cn(popupClass, props.className)}
        >
          {drawer.showSwipeHandle ? <SwipeHandle /> : React.null}
          <BaseUi.Drawer.Content
            dataSlot="drawer-content"
            className="cn-drawer-content-base flex min-h-0 flex-1 flex-col overflow-hidden overscroll-contain rounded-[inherit] transition-opacity duration-300 ease-[cubic-bezier(0.45,1.005,0,1.005)] select-text group-data-nested-drawer-open/drawer-popup:opacity-0 group-data-nested-drawer-swiping/drawer-popup:opacity-100 group-data-swiping/drawer-popup:select-none"
          >
            {props.children->Option.getOr(React.null)}
          </BaseUi.Drawer.Content>
        </BaseUi.Drawer.Popup>
      </BaseUi.Drawer.Viewport>
    </Portal>
  }
}

module Header = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("drawer-header")}
      className={cn(
        "cn-drawer-header-base flex shrink-0 flex-col group-data-[swipe-axis=y]/drawer-popup:text-center",
        props.className,
      )}
    />
}

module Footer = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("drawer-footer")}
      className={cn("cn-drawer-footer-base mt-auto flex shrink-0 flex-col", props.className)}
    />
}

module Title = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Drawer.Title
      {...props}
      dataSlot="drawer-title"
      className={cn("cn-drawer-title cn-font-heading", props.className)}
    />
}

module Description = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Drawer.Description
      {...props}
      dataSlot="drawer-description"
      className={cn("cn-drawer-description text-balance", props.className)}
    />
}
