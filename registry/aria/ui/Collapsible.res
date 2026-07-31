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
) => {
  let onExpandedChange = onOpenChange->Option.map(callback => open_ => callback(open_, %raw(`undefined`)))
  <ReactAria.Disclosure
    ?className
    ?children
    ?id
    ?dir
    isExpanded=?open_
    defaultExpanded=?defaultOpen
    ?onExpandedChange
    isDisabled=?disabled
    ?style
    dataSlot="collapsible"
  />
}

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
  ) => {
    switch render {
    | Some(render) =>
      Render.use({
        render,
        defaultTagName: "button",
        props: {
          ?className,
          ?children,
          ?id,
          ?disabled,
          ?onClick,
          ?onKeyDown,
          ?ariaLabel,
          ?style,
          ?type_,
          slot: "trigger",
          dataSlot: "collapsible-trigger",
        },
      })
    | None =>
      <ReactAria.Button
        ?className
        ?children
        ?id
        isDisabled=?disabled
        ?onClick
        ?onKeyDown
        ?ariaLabel
        ?style
        ?type_
        slot="trigger"
        dataSlot="collapsible-trigger"
      />
    }
  }
}

module Content = {
  @react.component
  let make = (
    ~className=?,
    ~children,
    ~id=?,
    ~style=?,
  ) =>
    <ReactAria.Disclosure.Panel
      ?className ?id ?style dataSlot="collapsible-content"
    >
      {children}
    </ReactAria.Disclosure.Panel>
}
