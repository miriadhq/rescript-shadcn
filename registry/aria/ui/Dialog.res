@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@@directive("'use client'")

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
    ~dataSlot="dialog-trigger",
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
      dataSlot
      className
    />
}

module Portal = {
  @react.component
  let make = (~children=?) => children->Option.getOr(React.null)
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
    ~dataSlot="dialog-close",
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
      dataSlot
      className
    />
}

module Overlay = {
  @react.component
  let make = (~className=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <ReactAria.Dialog.ModalOverlay
      ?id
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="dialog-overlay"
      className={cn(
        "cn-dialog-overlay cn-dialog-overlay-aria fixed inset-0 isolate z-50",
        className,
      )}
    />
}

module Content = {
  @react.component
  let make = (
    ~className=?,
    ~children=React.null,
    ~id=?,
    ~dir=?,
    ~dataLang=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~showCloseButton=true,
  ) =>
    <ReactAria.Dialog.ModalOverlay
      dataSlot="dialog-overlay"
      className="cn-dialog-overlay cn-dialog-overlay-aria fixed inset-0 isolate z-50"
    >
      <ReactAria.Dialog.Modal
        ?id
        ?dir
        ?dataLang
        ?style
        ?onClick
        ?onKeyDown
        dataSlot="dialog-content"
        className={cn(
          "cn-dialog-content cn-dialog-content-aria bg-background data-open:animate-in data-closed:animate-out data-closed:fade-out-0 data-open:fade-in-0 data-closed:zoom-out-95 data-open:zoom-in-95 ring-foreground/10 fixed top-1/2 left-1/2 z-50 grid w-full max-w-[calc(100%-2rem)] -translate-x-1/2 -translate-y-1/2 gap-4 rounded-xl p-4 text-sm ring-1 duration-100 outline-none sm:max-w-sm",
          className,
        )}
      >
        <ReactAria.Dialog dataSlot="dialog-content-inner">
          {children}
        {showCloseButton
          ? <Button
              dataSlot="dialog-close"
              variant=Ghost
              size=IconSm
              className="cn-dialog-close"
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

module Header = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <div
      ?id
      ?style
      ?children
      ?onClick
      ?onKeyDown
      dataSlot="dialog-header"
      className={cn("cn-dialog-header flex flex-col", className)}
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
      dataSlot="dialog-footer"
      className={cn(
        "cn-dialog-header cn-dialog-footer flex flex-col-reverse sm:flex-row sm:justify-end",
        className,
      )}
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
      dataSlot="dialog-title"
      className={cn("cn-dialog-title cn-font-heading", className)}
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
      dataSlot="dialog-description"
      className={cn(
        "cn-dialog-description",
        className,
      )}
    />
}
