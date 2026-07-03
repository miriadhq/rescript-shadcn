@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@react.component
let make = (
  ~className=?,
  ~children=?,
  ~id=?,
  ~value=?,
  ~defaultValue=?,
  ~onValueChange=?,
  ~disabled=?,
  ~orientation=?,
  ~onClick=?,
  ~onKeyDown=?,
  ~style=?,
) =>
  <BaseUi.Accordion.Root
    ?id
    ?value
    ?defaultValue
    ?onValueChange
    ?disabled
    ?orientation
    ?onClick
    ?onKeyDown
    ?style
    ?children
    dataSlot="accordion"
    className={cn("cn-accordion flex w-full flex-col", className)}
  />

module Multiple = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~id=?,
    ~value=?,
    ~defaultValue=?,
    ~onValueChange=?,
    ~disabled=?,
    ~orientation=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~style=?,
  ) =>
    <BaseUi.Accordion.Root
      ?id
      ?value
      ?defaultValue
      ?onValueChange
      ?disabled
      multiple=true
      ?orientation
      ?onClick
      ?onKeyDown
      ?style
      ?children
      dataSlot="accordion"
      className={cn("cn-accordion flex w-full flex-col", className)}
    />
}

module Item = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~id=?,
    ~value=?,
    ~disabled=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~style=?,
  ) =>
    <BaseUi.Accordion.Item
      ?id
      ?value
      ?disabled
      ?onClick
      ?onKeyDown
      ?style
      ?children
      dataSlot="accordion-item"
      className={cn("cn-accordion-item", className)}
    />
}

module Trigger = {
  @react.component
  let make = (
    ~className=?,
    ~children=React.null,
    ~id=?,
    ~disabled=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~ariaLabel=?,
    ~render=?,
    ~style=?,
  ) =>
    <BaseUi.Accordion.Header className="flex">
      <BaseUi.Accordion.Trigger
        ?id
        ?disabled
        ?onClick
        ?onKeyDown
        ?ariaLabel
        ?render
        ?style
        dataSlot="accordion-trigger"
        className={cn(
          "cn-accordion-trigger group/accordion-trigger relative flex flex-1 items-start justify-between border border-transparent transition-all outline-none aria-disabled:pointer-events-none aria-disabled:opacity-50",
          className,
        )}
      >
        {children}
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
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <BaseUi.Accordion.Panel
      ?id
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="accordion-content"
      className="cn-accordion-content overflow-hidden"
    >
      <div
        className={cn(
          "cn-accordion-content-inner [&_a]:hover:text-foreground h-(--accordion-panel-height) data-ending-style:h-0 data-starting-style:h-0 [&_a]:underline [&_a]:underline-offset-3 [&_p:not(:last-child)]:mb-4",
          className,
        )}
        ?children
      />
    </BaseUi.Accordion.Panel>
}
