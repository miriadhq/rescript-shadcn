@@directive("'use client'")

open BaseUi.Types

@react.component
let make = (
  ~className=?,
  ~children=?,
  ~id=?,
  ~dir=?,
  ~open_=?,
  ~defaultOpen=?,
  ~onOpenChange=?,
  ~disabled=?,
  ~style=?,
) =>
  <BaseUi.Collapsible.Root
    ?className
    ?children
    ?id
    ?dir
    ?open_
    ?defaultOpen
    ?onOpenChange
    ?disabled
    ?style
    dataSlot="collapsible"
  />

module Trigger = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~id=?,
    ~disabled=false,
    ~onClick=?,
    ~onKeyDown=?,
    ~ariaLabel=?,
    ~render=?,
    ~style=?,
  ) => {
    <BaseUi.Collapsible.Trigger
      ?className
      ?children
      ?id
      disabled
      ?onClick
      ?onKeyDown
      ?ariaLabel
      ?render
      ?style
      dataSlot="collapsible-trigger"
    />
  }
}

module Content = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~forceMount=?,
  ) =>
    <BaseUi.Collapsible.Panel
      ?className ?children ?id ?style ?onClick ?onKeyDown ?forceMount dataSlot="collapsible-content"
    />
}
