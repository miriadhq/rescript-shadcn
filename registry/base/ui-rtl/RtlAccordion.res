@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@@directive("'use client'")

@react.component
let make = (~children=React.null, ~className="", ~defaultValue=?) =>
  <BaseUi.Accordion.Root
    ?defaultValue dataSlot="accordion" className={`flex w-full flex-col ${className}`}
  >
    {children}
  </BaseUi.Accordion.Root>

module Item = {
  @react.component
  let make = (~children=React.null, ~value: string) =>
    <BaseUi.Accordion.Item value dataSlot="accordion-item" className="not-last:border-b">
      {children}
    </BaseUi.Accordion.Item>
}

module Trigger = {
  @react.component
  let make = (~children=React.null) =>
    <BaseUi.Accordion.Header className="flex">
      <BaseUi.Accordion.Trigger
        dataSlot="accordion-trigger"
        className="focus-visible:ring-ring/50 focus-visible:border-ring focus-visible:after:border-ring **:data-[slot=accordion-trigger-icon]:text-muted-foreground group/accordion-trigger relative flex flex-1 items-start justify-between rounded-lg border border-transparent py-2.5 text-start text-sm font-medium transition-all outline-none hover:underline focus-visible:ring-3 disabled:pointer-events-none disabled:opacity-50 **:data-[slot=accordion-trigger-icon]:ms-auto **:data-[slot=accordion-trigger-icon]:size-4"
      >
        {children}
        <Icons.ChevronDown
          dataSlot="accordion-trigger-icon"
          className="pointer-events-none shrink-0 group-aria-expanded/accordion-trigger:hidden"
        />
        <Icons.ChevronUp
          dataSlot="accordion-trigger-icon"
          className="pointer-events-none hidden shrink-0 group-aria-expanded/accordion-trigger:inline"
        />
      </BaseUi.Accordion.Trigger>
    </BaseUi.Accordion.Header>
}

module Content = {
  @react.component
  let make = (~children=React.null) =>
    <BaseUi.Accordion.Panel
      dataSlot="accordion-content"
      className="data-open:animate-accordion-down data-closed:animate-accordion-up overflow-hidden text-sm"
    >
      <div
        className="[&_a]:hover:text-foreground h-(--accordion-panel-height) pt-0 pb-2.5 data-ending-style:h-0 data-starting-style:h-0 [&_a]:underline [&_a]:underline-offset-3 [&_p:not(:last-child)]:mb-4"
      >
        {children}
      </div>
    </BaseUi.Accordion.Panel>
}
