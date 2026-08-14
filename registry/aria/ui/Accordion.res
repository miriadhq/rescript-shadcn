@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@react.componentWithProps(ReactAria.DisclosureGroup.props)
let make = (props: ReactAria.DisclosureGroup.props) =>
  <ReactAria.DisclosureGroup
    {...props}
    dataSlot="accordion"
    className={cn("cn-accordion flex w-full flex-col", props.className)}
  />

module Item = {
  @react.componentWithProps(ReactAria.Disclosure.props)
  let make = (props: ReactAria.Disclosure.props) =>
    <ReactAria.Disclosure
      {...props}
      dataSlot="accordion-item"
      className={cn("cn-accordion-item", props.className)}
    />
}

module Trigger = {
  @react.componentWithProps(ReactAria.Button.props)
  let make = (props: ReactAria.Button.props) =>
    <ReactAria.Heading className="flex">
      <ReactAria.Button
        {...props}
        slot="trigger"
        dataSlot="accordion-trigger"
        className={cn(
          "cn-accordion-trigger group/accordion-trigger relative flex flex-1 items-start justify-between border border-transparent transition-all outline-none disabled:pointer-events-none disabled:opacity-50",
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
      </ReactAria.Button>
    </ReactAria.Heading>
}

module Content = {
  let panelProps: ReactAria.Disclosure.Panel.props => ReactAria.Disclosure.Panel.props = %raw(`({className, children, ...props}) => props`)

  @react.componentWithProps(ReactAria.Disclosure.Panel.props)
  let make = (props: ReactAria.Disclosure.Panel.props) =>
    <ReactAria.Disclosure.Panel
      {...props->panelProps}
      dataSlot="accordion-content"
      className="cn-accordion-content h-(--disclosure-panel-height) overflow-clip transition-[height]"
    >
      <div
        className={cn(
          "cn-accordion-content-inner [&_a]:underline [&_a]:underline-offset-3 [&_a]:hover:text-foreground [&_p:not(:last-child)]:mb-4",
          props.className,
        )}
        children=?props.children
      />
    </ReactAria.Disclosure.Panel>
}
