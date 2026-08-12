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
  @react.componentWithProps(Button.Primitive.props)
  let make = (props: Button.Primitive.props) =>
    <Button.Primitive {...props} dataSlot="dropdown-menu-trigger" />
}

module Content = {
  type contentProps = {
    className?: string,
    children?: React.element,
    id?: string,
    dir?: string,
    dataLang?: string,
    style?: ReactDOM.Style.t,
    onClick?: JsxEvent.Mouse.t => unit,
    onKeyDown?: JsxEvent.Keyboard.t => unit,
    align?: Align.t,
    alignOffset?: float,
    side?: Side.t,
    sideOffset?: float,
    dataSlot?: string,
  }
  @react.component(: contentProps)
  let make = (
    ~align=Align.Start,
    ~alignOffset=0.,
    ~side=Side.Bottom,
    ~sideOffset=4.,
    ~className=?,
    ~dataSlot="dropdown-menu-content",
    ~children=?,
    ~id=?,
    ~dir=?,
    ~dataLang=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
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
    | _ => ReactAria.Common.Bottom
    }
    <ReactAria.Popover placement offset={sideOffset} crossOffset={alignOffset} className="isolate z-50 outline-none">
      <ReactAria.Menu
          ?id
          ?dir
          ?dataLang
          ?style
          ?onClick
          ?onKeyDown
          ?children
          dataSlot
          className={cn(
            "cn-dropdown-menu-content cn-dropdown-menu-content-aria cn-dropdown-menu-content-logical cn-menu-target cn-menu-translucent cn-menu-translucent-aria z-50 max-h-(--available-height) w-(--anchor-width) origin-(--transform-origin) overflow-x-hidden overflow-y-auto outline-none data-closed:overflow-hidden",
            className,
          )}
        />
    </ReactAria.Popover>
  }
}

module Group = {
  @react.component
  let make = (~className="", ~children=?, ~id=?, ~style=?) =>
    <ReactAria.Menu.Section ?id ?style ?children dataSlot="dropdown-menu-group" className />
}

module Label = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~inset=?,
    ~dataSlot="dropdown-menu-label",
  ) =>
    <header
      ?id
      ?style
      ?onClick
      ?onKeyDown
      dataInset=?inset
      ?children
      dataSlot
      className={cn(
        "cn-dropdown-menu-label",
        className,
      )}
    />
}

module Item = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~inset=?,
    ~variant=Variant.Default,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~disabled=?,
    ~closeOnClick=?,
    ~dataSlot="dropdown-menu-item",
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
      dataSlot
      dataVariant={(variant :> string)}
      className={cn(
        "cn-dropdown-menu-item group/dropdown-menu-item relative flex cursor-default items-center outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0",
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
      dataSlot="dropdown-menu-checkbox-item"
      className={cn(
        "cn-dropdown-menu-checkbox-item relative flex cursor-default items-center outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0",
        className,
      )}
    >
      <span
        className="cn-dropdown-menu-item-indicator pointer-events-none"
        dataSlot="dropdown-menu-checkbox-item-indicator"
      >
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
  let make = (
    ~children=?,
    ~value=?,
    ~onValueChange=?,
  ) => {
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
      dataSlot="dropdown-menu-radio-item"
      className={cn(
        "cn-dropdown-menu-radio-item relative flex cursor-default items-center outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0",
        className,
      )}
    >
      <span
        className="cn-dropdown-menu-item-indicator pointer-events-none"
        dataSlot="dropdown-menu-radio-item-indicator"
      >
        {isChecked ? <Icons.Check /> : React.null}
      </span>
      {children}
    </ReactAria.Menu.Item>
  }
}

module Separator = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~dataSlot="dropdown-menu-separator") =>
    <ReactAria.Separator
      ?id ?style ?children dataSlot className={cn("cn-dropdown-menu-separator", className)}
    />
}

module Shortcut = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~dataSlot="dropdown-menu-shortcut",
  ) =>
    <span
      ?id
      ?style
      ?onClick
      ?onKeyDown
      dataSlot
      className={cn(
        "cn-dropdown-menu-shortcut",
        className,
      )}
      ?children
    />
}

module Sub = {
  @react.component
  let make = (~children=?) => <ReactAria.Menu.SubmenuTrigger ?children />
}

module SubTrigger = {
  external toItemProps: ReactAria.Types.BaseUIComponentProps.t => ReactAria.Menu.Item.props<JSON.t> = "%identity"

  @react.componentWithProps(ReactAria.Types.BaseUIComponentProps.t)
  let make = (props: ReactAria.Types.BaseUIComponentProps.t) =>
    <ReactAria.Menu.Item
      {...props->toItemProps}
      dataSlot={props.dataSlot->Option.getOr("dropdown-menu-sub-trigger")}
      className={cn(
        "cn-dropdown-menu-sub-trigger data-popup-open:bg-accent data-popup-open:text-accent-foreground flex cursor-default items-center outline-hidden select-none [&_svg]:pointer-events-none [&_svg]:shrink-0",
        props.className,
      )}
    >
      {props.children->Option.getOr(React.null)}
      <Icons.ChevronRight className="cn-rtl-flip ml-auto" />
    </ReactAria.Menu.Item>
}

module SubContent = {
  @react.component(: Content.contentProps)
  let make = (
    ~align=Align.Start,
    ~alignOffset=-3.,
    ~side=Side.Right,
    ~sideOffset=0.,
    ~dataSlot="dropdown-menu-sub-content",
    ~className=?,
    ~children=?,
    ~id=?,
    ~dir=?,
    ~dataLang=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
  ) =>
    <Content
      ?children
      ?id
      ?dir
      ?dataLang
      ?style
      ?onClick
      ?onKeyDown
      align
      alignOffset
      side
      sideOffset
      dataSlot
      className={cn(
        "cn-dropdown-menu-sub-content cn-dropdown-menu-sub-content-aria cn-menu-target cn-menu-translucent cn-menu-translucent-aria w-auto",
        className,
      )}
    />
}
