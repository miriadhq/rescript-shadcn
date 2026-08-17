@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

open BaseUi.Types

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Variant = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("destructive") Destructive
}

@react.component
let make = (
  ~children=?,
  ~open_=?,
  ~defaultOpen=?,
  ~onOpenChange=?,
  ~onOpenChangeComplete=?,
  ~modal=?,
) =>
  <BaseUi.ContextMenu.Root
    ?children ?open_ ?defaultOpen ?onOpenChange ?onOpenChangeComplete ?modal dataSlot="context-menu"
  />

module Portal = {
  @react.component
  let make = (~children=?, ~container=?) =>
    <BaseUi.ContextMenu.Portal ?children ?container dataSlot="context-menu-portal" />
}

module Trigger = {
  @react.component
  let make = (
    ~className=?,
    ~dataSlot="context-menu-content",
    ~children=?,
    ~id=?,
    ~style=?,
    ~disabled=?,
    ~render=?,
    ~onClick=?,
    ~onKeyDown=?,
  ) =>
    <BaseUi.ContextMenu.Trigger
      ?id
      ?style
      ?disabled
      ?render
      ?onClick
      ?onKeyDown
      ?children
      dataSlot
      className={cn("cn-context-menu-trigger select-none", className)}
    />
}

module Content = {
  @react.component
  let make = (
    ~className=?,
    ~dataSlot="context-menu-content",
    ~children=?,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~align=Align.Start,
    ~alignOffset=4.,
    ~side=Side.Right,
    ~sideOffset=0.,
    ~dir=?,
    ~dataLang=?,
  ) => {
    <BaseUi.ContextMenu.Portal>
      <BaseUi.ContextMenu.Positioner
        className="isolate z-50 outline-none"
        align
        alignOffset={Const(alignOffset)}
        side
        sideOffset={Const(sideOffset)}
      >
        <BaseUi.ContextMenu.Popup
          ?id
          ?style
          ?onClick
          ?onKeyDown
          ?children
          ?dir
          ?dataLang
          dataSlot
          className={cn(
            "cn-context-menu-content-logical cn-context-menu-content cn-menu-target cn-menu-translucent z-50 max-h-(--available-height) origin-(--transform-origin) overflow-x-hidden overflow-y-auto outline-none",
            className,
          )}
        />
      </BaseUi.ContextMenu.Positioner>
    </BaseUi.ContextMenu.Portal>
  }
}

module Group = {
  @react.component
  let make = (~className="", ~children=?, ~id=?, ~style=?) =>
    <BaseUi.ContextMenu.Group ?id ?style ?children dataSlot="context-menu-group" className />
}

module Label = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?, ~dataInset=?) =>
    <BaseUi.ContextMenu.GroupLabel
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?dataInset
      ?children
      dataSlot="context-menu-label"
      className={cn("cn-context-menu-label", className)}
    />
}

module Item = {
  @react.component
  let make = (
    ~className=?,
    ~inset=?,
    ~variant=Variant.Default,
    ~children=?,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~disabled=?,
    ~closeOnClick=?,
  ) => {
    <BaseUi.ContextMenu.Item
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?disabled
      ?closeOnClick
      dataInset=?inset
      ?children
      dataSlot="context-menu-item"
      dataVariant={(variant :> string)}
      className={cn(
        "cn-context-menu-item group/context-menu-item relative flex cursor-default items-center outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0",
        className,
      )}
    />
  }
}

module CheckboxItem = {
  @react.component
  let make = (
    ~className=?,
    ~children=React.null,
    ~id=?,
    ~style=?,
    ~checked=?,
    ~defaultChecked=?,
    ~onCheckedChange=?,
    ~disabled=?,
    ~closeOnClick=?,
    ~dataInset=?,
    ~onClick=?,
    ~onKeyDown=?,
  ) =>
    <BaseUi.ContextMenu.CheckboxItem
      ?id
      ?style
      ?checked
      ?defaultChecked
      ?onCheckedChange
      ?disabled
      ?closeOnClick
      ?dataInset
      ?onClick
      ?onKeyDown
      dataSlot="context-menu-checkbox-item"
      className={cn(
        "cn-context-menu-radio-item relative flex cursor-default items-center outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0",
        className,
      )}
    >
      <span className="cn-context-menu-item-indicator pointer-events-none">
        <BaseUi.ContextMenu.CheckboxItemIndicator>
          <Icons.Check />
        </BaseUi.ContextMenu.CheckboxItemIndicator>
      </span>
      {children}
    </BaseUi.ContextMenu.CheckboxItem>
}

module RadioGroup = {
  @react.component
  let make = (
    ~className="",
    ~children=?,
    ~id=?,
    ~style=?,
    ~value: option<string>=?,
    ~onValueChange=?,
  ) =>
    <BaseUi.ContextMenu.RadioGroup
      ?id ?style ?value ?onValueChange ?children dataSlot="context-menu-radio-group" className
    />
}

module RadioItem = {
  @react.component
  let make = (
    ~className=?,
    ~children=React.null,
    ~id=?,
    ~style=?,
    ~value: string,
    ~disabled=?,
    ~closeOnClick=?,
    ~dataInset=?,
    ~onClick=?,
    ~onKeyDown=?,
  ) =>
    <BaseUi.ContextMenu.RadioItem
      ?id
      ?style
      value
      ?disabled
      ?closeOnClick
      ?dataInset
      ?onClick
      ?onKeyDown
      dataSlot="context-menu-radio-item"
      className={cn(
        "cn-context-menu-checkbox-item relative flex cursor-default items-center outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0",
        className,
      )}
    >
      <span
        className="cn-context-menu-item-indicator pointer-events-none flex items-center justify-center"
      >
        <BaseUi.ContextMenu.RadioItemIndicator>
          <Icons.Check />
        </BaseUi.ContextMenu.RadioItemIndicator>
      </span>
      {children}
    </BaseUi.ContextMenu.RadioItem>
}

module Separator = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?) =>
    <BaseUi.ContextMenu.Separator
      ?id
      ?style
      ?children
      dataSlot="context-menu-separator"
      className={cn("cn-context-menu-separator", className)}
    />
}

module Shortcut = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <span
      ?id
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="context-menu-shortcut"
      className={cn("cn-context-menu-shortcut", className)}
      ?children
    />
}

module Sub = {
  @react.component
  let make = (~children=?, ~open_=?, ~defaultOpen=?, ~onOpenChange=?) =>
    <BaseUi.ContextMenu.SubmenuRoot
      ?children ?open_ ?defaultOpen ?onOpenChange dataSlot="context-menu-sub"
    />
}

module SubContent = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~align=Align.Start,
    ~alignOffset=4.,
    ~side=Side.Right,
    ~sideOffset=0.,
    ~dir=?,
    ~dataLang=?,
  ) =>
    <Content
      ?children
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?dir
      ?dataLang
      align
      alignOffset
      side
      sideOffset
      dataSlot="context-menu-sub-content"
      className={cn("cn-context-menu-subcontent", className)}
    />
}

module SubTrigger = {
  @react.component
  let make = (
    ~className=?,
    ~children=React.null,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~disabled=?,
    ~dataInset=?,
  ) =>
    <BaseUi.ContextMenu.SubmenuTrigger
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?disabled
      ?dataInset
      dataSlot="context-menu-sub-trigger"
      className={cn(
        "cn-context-menu-sub-trigger flex cursor-default items-center outline-hidden select-none [&_svg]:pointer-events-none [&_svg]:shrink-0",
        className,
      )}
    >
      {children}
      <Icons.ChevronRight className="cn-rtl-flip ml-auto" />
    </BaseUi.ContextMenu.SubmenuTrigger>
}
