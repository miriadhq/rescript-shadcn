@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

let toSet: array<string> => Set.t<string> = %raw(`values => new Set(values)`)
let fromSet: Set.t<string> => array<string> = %raw(`values => [...values]`)

@react.component
let make = (
  ~className=?,
  ~children=?,
  ~id=?,
  ~value=?,
  ~defaultValue=?,
  ~onValueChange=?,
  ~disabled=?,
  ~onClick=?,
  ~onKeyDown=?,
  ~style=?,
) => {
  let expandedKeys = value->Option.map(toSet)
  let defaultExpandedKeys = defaultValue->Option.map(toSet)
  let onExpandedChange = onValueChange->Option.map(callback => keys =>
    callback(keys->fromSet, %raw(`undefined`))
  )
  <ReactAria.DisclosureGroup
    ?id
    ?expandedKeys
    ?defaultExpandedKeys
    ?onExpandedChange
    isDisabled=?disabled
    ?onClick
    ?onKeyDown
    ?style
    ?children
    dataSlot="accordion"
    className={cn("cn-accordion flex w-full flex-col", className)}
  />
}

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
    ~onClick=?,
    ~onKeyDown=?,
    ~style=?,
  ) => {
    let expandedKeys = value->Option.map(toSet)
    let defaultExpandedKeys = defaultValue->Option.map(toSet)
    let onExpandedChange = onValueChange->Option.map(callback => keys =>
      callback(keys->fromSet, %raw(`undefined`))
    )
    <ReactAria.DisclosureGroup
      ?id
      ?expandedKeys
      ?defaultExpandedKeys
      ?onExpandedChange
      isDisabled=?disabled
      allowsMultipleExpanded=true
      ?onClick
      ?onKeyDown
      ?style
      ?children
      dataSlot="accordion"
      className={cn("cn-accordion flex w-full flex-col", className)}
    />
  }
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
    <ReactAria.Disclosure
      id=?{value->Option.orElse(id)}
      isDisabled=?disabled
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
  ) => {
    let className = cn(
      "cn-accordion-trigger group/accordion-trigger relative flex flex-1 items-start justify-between border border-transparent transition-all outline-none aria-disabled:pointer-events-none aria-disabled:opacity-50",
      className,
    )
    let content = <>
      {children}
      <Icons.ChevronDown
        dataSlot="accordion-trigger-icon"
        className="cn-accordion-trigger-icon pointer-events-none shrink-0 group-aria-expanded/accordion-trigger:hidden"
      />
      <Icons.ChevronUp
        dataSlot="accordion-trigger-icon"
        className="cn-accordion-trigger-icon pointer-events-none hidden shrink-0 group-aria-expanded/accordion-trigger:inline"
      />
    </>
    <div className="flex">
      {switch render {
      | Some(render) =>
        Render.use({
          render,
          defaultTagName: "button",
          props: {
            ?id,
            children: content,
            ?disabled,
            ?onClick,
            ?onKeyDown,
            ?ariaLabel,
            ?style,
            slot: "trigger",
            dataSlot: "accordion-trigger",
            className,
          },
        })
      | None =>
        <ReactAria.Button
          ?id
          isDisabled=?disabled
          ?onClick
          ?onKeyDown
          ?ariaLabel
          ?style
          slot="trigger"
          dataSlot="accordion-trigger"
          className
        >
          {content}
        </ReactAria.Button>
      }}
    </div>
  }
}

module Content = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <ReactAria.Disclosure.Panel
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
    </ReactAria.Disclosure.Panel>
}
