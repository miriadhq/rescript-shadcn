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
  @react.componentWithProps(BaseUi.Collapsible.Trigger.props)
  let make = (props: BaseUi.Collapsible.Trigger.props) => {
    <BaseUi.Collapsible.Trigger
      {...props} dataSlot={props.dataSlot->Option.getOr("collapsible-trigger")}
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
