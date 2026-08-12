@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

open ReactAria.Types

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
) => {
  let onOpenChange = onOpenChange->Option.map(callback => open_ => callback(open_, %raw(`undefined`)))
  <ReactAria.Menu.Trigger ?children isOpen=?open_ ?defaultOpen ?onOpenChange />
}

module Portal = {
  @react.component
  let make = (~children=?) => children->Option.getOr(React.null)
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
    <Button.Primitive
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
    let placement: ReactAria.Common.placement = switch (side, align) {
    | (Top, Start) => ReactAria.Common.TopStart
    | (Top, End) => ReactAria.Common.TopEnd
    | (Top, _) => ReactAria.Common.Top
    | (Bottom, Start) => ReactAria.Common.BottomStart
    | (Bottom, End) => ReactAria.Common.BottomEnd
    | (Bottom, _) => ReactAria.Common.Bottom
    | (Left, Start) => ReactAria.Common.LeftTop
    | (Left, End) => ReactAria.Common.LeftBottom
    | (Left, _) => ReactAria.Common.Left
    | (Right, Start) => ReactAria.Common.RightTop
    | (Right, End) => ReactAria.Common.RightBottom
    | (Right, _) => ReactAria.Common.Right
    | _ => ReactAria.Common.Right
    }
    <ReactAria.Popover placement offset={sideOffset} crossOffset={alignOffset} className="isolate z-50 outline-none">
      <ReactAria.Menu
          ?id
          ?style
          ?onClick
          ?onKeyDown
          ?children
          ?dir
          ?dataLang
          dataSlot
          className={cn(
            "cn-context-menu-content-logical cn-context-menu-content cn-context-menu-content-aria cn-menu-target cn-menu-translucent cn-menu-translucent-aria z-50 max-h-(--available-height) origin-(--transform-origin) overflow-x-hidden overflow-y-auto outline-none",
            className,
          )}
        />
    </ReactAria.Popover>
  }
}

module Group = {
  @react.component
  let make = (~className="", ~children=?, ~id=?, ~style=?) =>
    <ReactAria.Menu.Section ?id ?style ?children dataSlot="context-menu-group" className />
}

module Label = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?, ~dataInset=?) =>
    <header
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?dataInset
      ?children
      dataSlot="context-menu-label"
      className={cn(
        "cn-context-menu-label",
        className,
      )}
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
    <ReactAria.Menu.Item
      ?id
      ?style
      ?onClick
      ?onKeyDown
      isDisabled=?disabled
      shouldCloseOnSelect=?closeOnClick
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
  ) => {
    let (internalChecked, setInternalChecked) = React.useState(() => defaultChecked->Option.getOr(false))
    let isChecked = checked->Option.getOr(internalChecked)
    let onAction = () => {
      let nextChecked = !isChecked
      if checked->Option.isNone {
        setInternalChecked(_ => nextChecked)
      }
      onCheckedChange->Option.forEach(callback => callback(nextChecked, %raw(`undefined`)))
    }
    <ReactAria.Menu.Item
      ?id
      ?style
      isDisabled=?disabled
      shouldCloseOnSelect=?closeOnClick
      onAction
      dataChecked={isChecked}
      dataUnchecked={!isChecked}
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
        {isChecked ? <Icons.Check /> : React.null}
      </span>
      {children}
    </ReactAria.Menu.Item>
  }
}

type radioContext = {
  value: option<string>,
  onValueChange: option<(string, JSON.t) => unit>,
}

let radioContext = React.createContext({value: None, onValueChange: None})

module RadioProvider = {
  let make = React.Context.provider(radioContext)
}

module RadioGroup = {
  @react.component
  let make = (~children=?, ~value=?, ~onValueChange=?) => {
    <RadioProvider value={{value, onValueChange}}> {children->Option.getOr(React.null)} </RadioProvider>
  }
}

module RadioItem = {
  @react.component
  let make = (
    ~className=?,
    ~children=React.null,
    ~id=?,
    ~style=?,
    ~value,
    ~disabled=?,
    ~closeOnClick=?,
    ~dataInset=?,
    ~onClick=?,
    ~onKeyDown=?,
  ) => {
    let context = React.useContext(radioContext)
    let isChecked = context.value == Some(value)
    let onAction = () => context.onValueChange->Option.forEach(callback =>
      callback(value, %raw(`undefined`))
    )
    <ReactAria.Menu.Item
      ?id
      ?style
      value
      isDisabled=?disabled
      shouldCloseOnSelect=?closeOnClick
      onAction
      dataChecked={isChecked}
      dataUnchecked={!isChecked}
      ?dataInset
      ?onClick
      ?onKeyDown
      dataSlot="context-menu-radio-item"
      className={cn(
        "cn-context-menu-checkbox-item relative flex cursor-default items-center outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0",
        className,
      )}
    >
      <span className="cn-context-menu-item-indicator pointer-events-none flex items-center justify-center">
        {isChecked ? <Icons.Check /> : React.null}
      </span>
      {children}
    </ReactAria.Menu.Item>
  }
}

module Separator = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?) =>
    <ReactAria.Separator
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
      className={cn(
        "cn-context-menu-shortcut",
        className,
      )}
      ?children
    />
}

module Sub = {
  @react.component
  let make = (~children=?) => <ReactAria.Menu.SubmenuTrigger ?children />
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
      className={cn(
        "cn-context-menu-subcontent cn-context-menu-sub-content-aria",
        className,
      )}
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
    <ReactAria.Menu.Item
      ?id
      ?style
      ?onClick
      ?onKeyDown
      isDisabled=?disabled
      ?dataInset
      dataSlot="context-menu-sub-trigger"
      className={cn(
        "cn-context-menu-sub-trigger flex cursor-default items-center outline-hidden select-none [&_svg]:pointer-events-none [&_svg]:shrink-0",
        className,
      )}
    >
      {children}
      <Icons.ChevronRight className="cn-rtl-flip ml-auto" />
    </ReactAria.Menu.Item>
}
