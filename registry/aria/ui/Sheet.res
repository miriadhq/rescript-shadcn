@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@@directive("'use client'")

open ReactAria.Types

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@react.component
let make = (
  ~children=?,
  ~open_=?,
  ~defaultOpen=?,
  ~onOpenChange=?,
) => {
  let onOpenChange = onOpenChange->Option.map(callback => open_ => callback(open_, %raw(`undefined`)))
  <ReactAria.Dialog.Trigger ?children isOpen=?open_ ?defaultOpen ?onOpenChange />
}

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
    ~render=?,
    ~nativeButton=?,
    ~type_=?,
    ~ariaLabel=?,
  ) =>
    <Button
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?disabled
      ?render
      ?nativeButton
      ?type_
      ?ariaLabel
      ?children
      dataSlot="sheet-trigger"
      className
    />
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
    ~render=?,
    ~nativeButton=?,
    ~type_=?,
    ~ariaLabel=?,
  ) =>
    <Button
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?disabled
      ?render
      ?nativeButton
      ?type_
      ?ariaLabel
      ?children
      slot="close"
      dataSlot="sheet-close"
      className
    />
}

module Portal = {
  @react.component
  let make = (~children=?) => children->Option.getOr(React.null)
}

module Overlay = {
  @react.component
  let make = (~className=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <ReactAria.Dialog.ModalOverlay
      ?id
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="sheet-overlay"
      className={cn(
        "cn-sheet-overlay data-open:animate-in data-closed:animate-out data-closed:fade-out-0 data-open:fade-in-0 fixed inset-0 z-50 duration-100 data-ending-style:opacity-0 data-starting-style:opacity-0",
        className,
      )}
    />
}

let sideToString = (side: Side.t) =>
  switch side {
  | Top => "top"
  | Bottom => "bottom"
  | Left => "left"
  | Right
  | InlineStart
  | InlineEnd => "right"
  }

module Content = {
  @react.component
  let make = (
    ~className=?,
    ~children=React.null,
    ~id=?,
    ~style=?,
    ~dir: option<string>=?,
    ~dataSidebar=?,
    ~dataSlot="sheet-content",
    ~dataMobile=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~side=Side.Right,
    ~showCloseButton=true,
  ) => {
    let style = switch (style, dir) {
    | (Some(style), Some(dir)) => Some(style->ReactDOM.Style.unsafeAddProp("direction", dir))
    | (None, Some(dir)) => Some(ReactDOM.Style._dictToStyle(dict{"direction": dir}))
    | (Some(style), None) => Some(style)
    | (None, None) => None
    }
    <ReactAria.Dialog.ModalOverlay
      dataSlot="sheet-overlay"
      className="cn-sheet-overlay data-open:animate-in data-closed:animate-out data-closed:fade-out-0 data-open:fade-in-0 fixed inset-0 z-50 duration-100 data-ending-style:opacity-0 data-starting-style:opacity-0"
    >
      <ReactAria.Dialog.Modal
        ?id
        style=?style
        ?onClick
        ?onKeyDown
        dataSlot
        ?dataSidebar
        ?dataMobile
        dataSide={sideToString(side)}
        className={cn(
          "cn-sheet-content bg-background data-open:animate-in data-closed:animate-out data-[side=right]:data-closed:slide-out-to-right-10 data-[side=right]:data-open:slide-in-from-right-10 data-[side=left]:data-closed:slide-out-to-left-10 data-[side=left]:data-open:slide-in-from-left-10 data-[side=top]:data-closed:slide-out-to-top-10 data-[side=top]:data-open:slide-in-from-top-10 data-closed:fade-out-0 data-open:fade-in-0 data-[side=bottom]:data-closed:slide-out-to-bottom-10 data-[side=bottom]:data-open:slide-in-from-bottom-10 fixed z-50 flex flex-col gap-4 bg-clip-padding text-sm shadow-lg transition duration-200 ease-in-out data-[side=bottom]:inset-x-0 data-[side=bottom]:bottom-0 data-[side=bottom]:h-auto data-[side=bottom]:border-t data-[side=left]:inset-y-0 data-[side=left]:left-0 data-[side=left]:h-full data-[side=left]:w-3/4 data-[side=left]:border-r data-[side=right]:inset-y-0 data-[side=right]:right-0 data-[side=right]:h-full data-[side=right]:w-3/4 data-[side=right]:border-l data-[side=top]:inset-x-0 data-[side=top]:top-0 data-[side=top]:h-auto data-[side=top]:border-b data-[side=left]:sm:max-w-sm data-[side=right]:sm:max-w-sm",
          className,
        )}
      >
        <ReactAria.Dialog dataSlot="sheet-content-inner">
          {children}
        {showCloseButton
          ? <Button
              dataSlot="sheet-close"
              variant=Ghost
              size=IconSm
              className="cn-sheet-close"
              slot="close"
            >
              <Icons.X />
              <span className="sr-only"> {"Close"->React.string} </span>
            </Button>
          : React.null}
        </ReactAria.Dialog>
      </ReactAria.Dialog.Modal>
    </ReactAria.Dialog.ModalOverlay>
  }
}

module Header = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <div
      ?id
      ?style
      ?children
      ?onClick
      ?onKeyDown
      dataSlot="sheet-header"
      className={cn("cn-sheet-header flex flex-col", className)}
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
      dataSlot="sheet-footer"
      className={cn("cn-sheet-footer mt-auto flex flex-col", className)}
    />
}

module Title = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <h2
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?children
      dataSlot="sheet-title"
      className={cn("cn-sheet-title cn-font-heading", className)}
    />
}

module Description = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <p
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?children
      dataSlot="sheet-description"
      className={cn("cn-sheet-description", className)}
    />
}
