@@directive("'use client'")

open BaseUi.Types

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module ResizablePrimitive = {
  module Group = {
    @module("react-resizable-panels")
    external make: React.component<props<'value, 'checked>> = "Group"
  }

  module Panel = {
    @module("react-resizable-panels")
    external make: React.component<props<'value, 'checked>> = "Panel"
  }

  module Separator = {
    @module("react-resizable-panels")
    external make: React.component<props<'value, 'checked>> = "Separator"
  }
}

@react.component
let make = (
  ~className=?,
  ~children=?,
  ~id=?,
  ~dir=?,
  ~style=?,
  ~onClick=?,
  ~onKeyDown=?,
  ~orientation=?,
) =>
  <ResizablePrimitive.Group
    ?id
    ?style
    ?dir
    ?onClick
    ?onKeyDown
    ?orientation
    ?children
    dataSlot="resizable-panel-group"
    className={cn("flex h-full w-full aria-[orientation=vertical]:flex-col", className)}
  />

module Panel = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~defaultSize=?, ~min=?, ~max=?) =>
    <ResizablePrimitive.Panel
      ?className ?children ?id ?style ?defaultSize ?min ?max dataSlot="resizable-panel"
    />
}

module Handle = {
  @react.component
  let make = (
    ~className=?,
    ~children=React.null,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~orientation=?,
    ~withHandle=false,
  ) => {
    <ResizablePrimitive.Separator
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?orientation
      dataSlot="resizable-handle"
      className={cn(
        "bg-border focus-visible:ring-ring ring-offset-background relative flex w-px items-center justify-center after:absolute after:inset-y-0 after:start-1/2 after:w-1 after:-translate-x-1/2 rtl:after:translate-x-1/2 focus-visible:ring-1 focus-visible:outline-hidden aria-[orientation=horizontal]:h-px aria-[orientation=horizontal]:w-full aria-[orientation=horizontal]:after:left-0 aria-[orientation=horizontal]:after:h-1 aria-[orientation=horizontal]:after:w-full aria-[orientation=horizontal]:after:translate-x-0 aria-[orientation=horizontal]:after:-translate-y-1/2 [&[aria-orientation=horizontal]>div]:rotate-90",
        className,
      )}
    >
      {children}
      {withHandle
        ? <div className="bg-border z-10 flex h-6 w-1 shrink-0 rounded-lg" />
        : React.null}
    </ResizablePrimitive.Separator>
  }
}
