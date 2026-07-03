@@directive("'use client'")

open BaseUi.Types

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@react.component
let make = (
  ~className=?,
  ~children=?,
  ~id=?,
  ~open_=?,
  ~defaultOpen=?,
  ~onOpenChange=?,
  ~onOpenChangeComplete=?,
  ~delay=?,
  ~closeDelay=?,
  ~style=?,
) =>
  <BaseUi.PreviewCard.Root
    ?className
    ?children
    ?id
    ?open_
    ?defaultOpen
    ?onOpenChange
    ?onOpenChangeComplete
    ?delay
    ?closeDelay
    ?style
    dataSlot="hover-card"
  />

module Trigger = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~id=?,
    ~disabled=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~ariaLabel=?,
    ~delay=?,
    ~closeDelay=?,
    ~render=?,
    ~style=?,
  ) =>
    <BaseUi.PreviewCard.Trigger
      ?className
      ?children
      ?id
      ?disabled
      ?onClick
      ?onKeyDown
      ?ariaLabel
      ?delay
      ?closeDelay
      ?render
      ?style
      dataSlot="hover-card-trigger"
    />
}

module Content = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~id=?,
    ~dir=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~align=Align.Center,
    ~alignOffset=4.,
    ~side=Side.Bottom,
    ~sideOffset=4.,
  ) =>
    <BaseUi.PreviewCard.Portal dataSlot="hover-card-portal">
      <BaseUi.PreviewCard.Positioner
        align
        alignOffset={Const(alignOffset)}
        side
        sideOffset={Const(sideOffset)}
        className="isolate z-50"
      >
        <BaseUi.PreviewCard.Popup
          ?id
          ?dir
          ?style
          ?onClick
          ?onKeyDown
          ?children
          dataSlot="hover-card-content"
          className={cn(
            "cn-hover-card-content-logical cn-hover-card-content z-50 origin-(--transform-origin) outline-hidden",
            className,
          )}
        />
      </BaseUi.PreviewCard.Positioner>
    </BaseUi.PreviewCard.Portal>
}
