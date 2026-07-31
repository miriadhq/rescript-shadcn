@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

open ReactAria.Types

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@react.component
let make = (
  ~className=?,
  ~children=?,
  ~id=?,
  ~style=?,
  ~onClick=?,
  ~onKeyDown=?,
  ~tabIndex=?,
  ~ariaLabel=?,
  ~dir=?,
  ~orientation=Orientation.Vertical,
) => {
  <div
    ?id
    ?style
    ?onClick
    ?onKeyDown
    ?tabIndex
    ?ariaLabel
    ?dir
    dataSlot="scroll-area"
    className={cn("cn-scroll-area relative", className)}
  >
    <div
      dataSlot="scroll-area-viewport"
      className="cn-scroll-area-viewport focus-visible:ring-ring/50 size-full rounded-[inherit] transition-[color,box-shadow] outline-none focus-visible:ring-[3px] focus-visible:outline-1"
      ?children
    />
    <div
      dataSlot="scroll-area-scrollbar"
      dataOrientation={(orientation :> string)}
      className="cn-scroll-area-scrollbar flex touch-none p-px transition-colors select-none"
    >
      <div
        dataSlot="scroll-area-thumb" className="cn-scroll-area-thumb bg-border relative flex-1"
      />
    </div>
  </div>
}

module ScrollBar = {
  @react.component
  let make = (
    ~className=?,
    ~children=React.null,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~orientation=Orientation.Vertical,
  ) =>
    <div
      ?id
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="scroll-area-scrollbar"
      dataOrientation={(orientation :> string)}
      className={cn(
        "cn-scroll-area-scrollbar flex touch-none p-px transition-colors select-none",
        className,
      )}
    >
      <div
        dataSlot="scroll-area-thumb" className="cn-scroll-area-thumb bg-border relative flex-1"
      />
      {children}
    </div>
}
