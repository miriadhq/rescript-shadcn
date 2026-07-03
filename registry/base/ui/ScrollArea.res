@@directive("'use client'")

open BaseUi.Types

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
  ~orientation=?,
) =>
  <BaseUi.ScrollArea.Root
    ?id
    ?style
    ?onClick
    ?onKeyDown
    ?tabIndex
    ?ariaLabel
    ?dir
    ?orientation
    dataSlot="scroll-area"
    className={cn("cn-scroll-area relative", className)}
  >
    <BaseUi.ScrollArea.Viewport
      dataSlot="scroll-area-viewport"
      className="cn-scroll-area-viewport focus-visible:ring-ring/50 size-full rounded-[inherit] transition-[color,box-shadow] outline-none focus-visible:ring-[3px] focus-visible:outline-1"
      ?children
    />
    <BaseUi.ScrollArea.Scrollbar
      dataSlot="scroll-area-scrollbar"
      orientation={Orientation.Vertical}
      className="cn-scroll-area-scrollbar flex touch-none p-px transition-colors select-none"
    >
      <BaseUi.ScrollArea.Thumb
        dataSlot="scroll-area-thumb" className="cn-scroll-area-thumb bg-border relative flex-1"
      />
    </BaseUi.ScrollArea.Scrollbar>
    <BaseUi.ScrollArea.Corner />
  </BaseUi.ScrollArea.Root>

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
    <BaseUi.ScrollArea.Scrollbar
      ?id
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="scroll-area-scrollbar"
      orientation
      className={cn(
        "cn-scroll-area-scrollbar flex touch-none p-px transition-colors select-none",
        className,
      )}
    >
      <BaseUi.ScrollArea.Thumb
        dataSlot="scroll-area-thumb" className="cn-scroll-area-thumb bg-border relative flex-1"
      />
      {children}
    </BaseUi.ScrollArea.Scrollbar>
}
