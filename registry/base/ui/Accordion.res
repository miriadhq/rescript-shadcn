@@directive("'use client'")

@module("cn")
external cn: (string, option<string>) => string = "cn"

@react.componentWithProps(BaseUi.Accordion.Root.props)
let make = (props: BaseUi.Accordion.Root.props<'value>) =>
  <BaseUi.Accordion.Root
    {...props}
    dataSlot={props.dataSlot->Option.getOr("accordion")}
    className={cn("cn-accordion flex w-full flex-col", props.className)}
  />

module Multiple = {
  @react.componentWithProps(BaseUi.Accordion.Root.props)
  let make = (props: BaseUi.Accordion.Root.props<'value>) =>
    <BaseUi.Accordion.Root
      {...props}
      multiple=true
      dataSlot={props.dataSlot->Option.getOr("accordion")}
      className={cn("cn-accordion flex w-full flex-col", props.className)}
    />
}

module Item = {
  @react.componentWithProps(BaseUi.Accordion.Item.props)
  let make = (props: BaseUi.Accordion.Item.props<'value>) =>
    <BaseUi.Accordion.Item
      {...props}
      dataSlot={props.dataSlot->Option.getOr("accordion-item")}
      className={cn("cn-accordion-item", props.className)}
    />
}

module Trigger = {
  @react.componentWithProps(BaseUi.Accordion.Trigger.props)
  let make = (props: BaseUi.Accordion.Trigger.props) =>
    <BaseUi.Accordion.Header className="flex">
      <BaseUi.Accordion.Trigger
        {...props}
        dataSlot={props.dataSlot->Option.getOr("accordion-trigger")}
        className={cn(
          "cn-accordion-trigger group/accordion-trigger relative flex flex-1 items-start justify-between border border-transparent transition-all outline-none aria-disabled:pointer-events-none aria-disabled:opacity-50",
          props.className,
        )}
      >
        {props.children->Option.getOr(React.null)}
        <Icons.ChevronDown
          dataSlot="accordion-trigger-icon"
          className="cn-accordion-trigger-icon pointer-events-none shrink-0 group-aria-expanded/accordion-trigger:hidden"
        />
        <Icons.ChevronUp
          dataSlot="accordion-trigger-icon"
          className="cn-accordion-trigger-icon pointer-events-none hidden shrink-0 group-aria-expanded/accordion-trigger:inline"
        />
      </BaseUi.Accordion.Trigger>
    </BaseUi.Accordion.Header>
}

module Content = {
  type props = BaseUi.Types.BaseUIComponentProps.t

  let toBaseUiProps: props => BaseUi.Types.BaseUIComponentProps.t = %raw(`({className, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let children = props.children
    <BaseUi.Accordion.Panel
      {...props->toBaseUiProps}
      dataSlot={props.dataSlot->Option.getOr("accordion-content")}
      className="cn-accordion-content overflow-hidden"
    >
      <div
        className={cn(
          "cn-accordion-content-inner [&_a]:hover:text-foreground h-(--accordion-panel-height) data-ending-style:h-0 data-starting-style:h-0 [&_a]:underline [&_a]:underline-offset-3 [&_p:not(:last-child)]:mb-4",
          props.className,
        )}
        ?children
      />
    </BaseUi.Accordion.Panel>
  }
}
