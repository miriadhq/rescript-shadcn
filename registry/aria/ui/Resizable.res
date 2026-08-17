@@directive("'use client'")

open ReactAria.Types

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module ResizablePrimitive = {
  module Layout = {
    type t = dict<float>
  }
  module ResizeTargetMinimumSize = {
    type t = {
      coarse: float,
      fine: float,
    }
  }
  module Group = {
    module DivProps = {
      type t = {
        children?: React.element,
        className?: string,
        id?: string,
        style?: ReactDOM.Style.t,
        onClick?: JsxEvent.Mouse.t => unit,
        onKeyDown?: JsxEvent.Keyboard.t => unit,
        @as("data-slot") dataSlot?: string,
      }
    }

    type props = {
      ...DivProps.t,
      defaultLayout?: Layout.t,
      disableCursor?: bool,
      disabled?: bool,
      elementRef?: ReactDOM.domRef,
      onLayoutChange?: Layout.t => unit,
      onLayoutChanged?: Layout.t => unit,
      orientation?: Orientation.t,
      resizeTargetMinimumSize?: ResizeTargetMinimumSize.t,
    }
    @module("react-resizable-panels")
    external make: React.component<props> = "Group"
  }

  module Panel = {
    type props = {
      ...Group.DivProps.t,
      collapsedSize?: string,
      collapsible?: bool,
      defaultSize?: string,
      disabled?: bool,
      elementRef?: ReactDOM.domRef,
      groupResizeBehavior?: [#"preserve-relative-size" | #"preserve-pixel-size"],
      minSize?: string,
      maxSize?: string,
      onResize?: (~panelSize: string, ~id: string=?, ~prevPanelSize: string=?) => unit,
    }
    @module("react-resizable-panels")
    external make: React.component<props> = "Panel"
  }

  module Separator = {
    type props = {
      ...Group.DivProps.t,
      disabled?: bool,
      elementRef?: ReactDOM.domRef,
    }
    @module("react-resizable-panels")
    external make: React.component<props> = "Separator"
  }
}

@react.componentWithProps(ResizablePrimitive.Group.props)
let make = (props: ResizablePrimitive.Group.props) =>
  <ResizablePrimitive.Group
    {...props}
    dataSlot="resizable-panel-group"
    className={cn(
      "cn-resizable-panel-group flex h-full w-full aria-[orientation=vertical]:flex-col",
      props.className,
    )}
  />

module Panel = {
  @react.componentWithProps(ResizablePrimitive.Panel.props)
  let make = (props: ResizablePrimitive.Panel.props) =>
    <ResizablePrimitive.Panel {...props} dataSlot="resizable-panel" />
}

module Handle = {
  type props = {withHandle?: bool, ...ResizablePrimitive.Separator.props}

  @react.componentWithProps(props)
  let make = ({?withHandle, ...ResizablePrimitive.Separator.props as props}) => {
    <ResizablePrimitive.Separator
      {...props}
      dataSlot="resizable-handle"
      className={cn(
        "cn-resizable-handle relative flex w-px items-center justify-center bg-border ring-offset-background after:absolute after:inset-y-0 after:left-1/2 after:w-1 after:-translate-x-1/2 focus-visible:ring-1 focus-visible:ring-ring focus-visible:outline-hidden aria-[orientation=horizontal]:h-px aria-[orientation=horizontal]:w-full aria-[orientation=horizontal]:after:left-0 aria-[orientation=horizontal]:after:h-1 aria-[orientation=horizontal]:after:w-full aria-[orientation=horizontal]:after:translate-x-0 aria-[orientation=horizontal]:after:-translate-y-1/2 [&[aria-orientation=horizontal]>div]:rotate-90",
        props.className,
      )}
    >
      {withHandle->Option.getOr(false)
        ? <div className="cn-resizable-handle-icon z-10 flex shrink-0" />
        : React.null}
    </ResizablePrimitive.Separator>
  }
}
