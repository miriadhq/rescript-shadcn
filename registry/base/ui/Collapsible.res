@@directive("'use client'")

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
    ~disabled=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~ariaLabel=?,
    ~render=?,
    ~style=?,
    ~type_=?,
    ~nativeButton=?,
  ) => {
    <BaseUi.Collapsible.Trigger
      ?className
      ?children
      ?id
      ?disabled
      ?onClick
      ?onKeyDown
      ?ariaLabel
      ?render
      ?style
      ?type_
      ?nativeButton
      dataSlot="collapsible-trigger"
    />
  }
}

module Content = {
  @react.component
  let make = (
    ~className=?,
    ~children,
    ~id=?,
    ~style=?,
    ~render=?,
    ~hiddenUntilFound=?,
    ~keepMounted=?,
  ) =>
    <BaseUi.Collapsible.Panel
      ?className ?id ?style ?hiddenUntilFound ?keepMounted ?render dataSlot="collapsible-content"
    >
      {children}
    </BaseUi.Collapsible.Panel>
}
