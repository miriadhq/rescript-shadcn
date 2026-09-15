@@directive("'use client'")

@react.componentWithProps(BaseUi.Collapsible.Root.props)
let make = (props: BaseUi.Collapsible.Root.props) =>
  <BaseUi.Collapsible.Root {...props} dataSlot={props.dataSlot->Option.getOr("collapsible")} />

module Trigger = {
  @react.componentWithProps(BaseUi.Collapsible.Trigger.props)
  let make = (props: BaseUi.Collapsible.Trigger.props) =>
    <BaseUi.Collapsible.Trigger
      {...props} dataSlot={props.dataSlot->Option.getOr("collapsible-trigger")}
    />
}

module Content = {
  @react.componentWithProps(BaseUi.Collapsible.Panel.props)
  let make = (props: BaseUi.Collapsible.Panel.props) => {
    let children = props.children->Option.getOr(React.null)
    <BaseUi.Collapsible.Panel
      {...props} dataSlot={props.dataSlot->Option.getOr("collapsible-content")}
    >
      {children}
    </BaseUi.Collapsible.Panel>
  }
}
