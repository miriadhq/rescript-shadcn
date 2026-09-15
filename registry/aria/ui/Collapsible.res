@@directive("'use client'")

@react.componentWithProps(ReactAria.Disclosure.props)
let make = (props: ReactAria.Disclosure.props) =>
  <ReactAria.Disclosure {...props} dataSlot={props.dataSlot->Option.getOr("collapsible")} />

module Trigger = {
  @react.componentWithProps(ReactAria.Button.props)
  let make = (props: ReactAria.Button.props) =>
    <ReactAria.Button
      {...props}
      slot={props.slot->Option.getOr("trigger")}
      dataSlot={props.dataSlot->Option.getOr("collapsible-trigger")}
    />
}

module Content = {
  @react.componentWithProps(ReactAria.Disclosure.Panel.props)
  let make = (props: ReactAria.Disclosure.Panel.props) =>
    <ReactAria.Disclosure.Panel
      {...props}
      dataSlot={props.dataSlot->Option.getOr("collapsible-content")}
    />
}
