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
  ~dataSlot="dropdown-menu",
) =>
  <BaseUi.Menu.Root
    ?children ?open_ ?defaultOpen ?onOpenChange ?onOpenChangeComplete ?modal dataSlot
  />

module Portal = {
  @react.component
  let make = (~children=?, ~container=?) =>
    <BaseUi.Menu.Portal ?children ?container dataSlot="dropdown-menu-portal" />
}

module Trigger = {
  @react.componentWithProps(BaseUi.Menu.Trigger.props)
  let make = (props: BaseUi.Menu.Trigger.props) =>
    <BaseUi.Menu.Trigger {...props} dataSlot="dropdown-menu-trigger" />
}

module Content = {
  module ContentProps = {
    type t = {
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
  }
  @react.component(: ContentProps.t)
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
    <BaseUi.Menu.Portal>
      <BaseUi.Menu.Positioner
        className="isolate z-50 outline-none"
        align
        alignOffset={Const(alignOffset)}
        side
        sideOffset={Const(sideOffset)}
      >
        <BaseUi.Menu.Popup
          ?id
          ?dir
          ?dataLang
          ?style
          ?onClick
          ?onKeyDown
          ?children
          dataSlot
          className={cn(
            "cn-dropdown-menu-content cn-dropdown-menu-content-logical cn-menu-target cn-menu-translucent z-50 max-h-(--available-height) w-(--anchor-width) origin-(--transform-origin) overflow-x-hidden overflow-y-auto outline-none data-closed:overflow-hidden",
            className,
          )}
        />
      </BaseUi.Menu.Positioner>
    </BaseUi.Menu.Portal>
  }
}

module Group = {
  @react.component
  let make = (~className="", ~children=?, ~id=?, ~style=?) =>
    <BaseUi.Menu.Group ?id ?style ?children dataSlot="dropdown-menu-group" className />
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
    <BaseUi.Menu.GroupLabel
      ?id
      ?style
      ?onClick
      ?onKeyDown
      dataInset=?inset
      ?children
      dataSlot
      className={cn("cn-dropdown-menu-label", className)}
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
    <BaseUi.Menu.Item
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?disabled
      ?closeOnClick
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
  ) =>
    <BaseUi.Menu.CheckboxItem
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
        <BaseUi.Menu.CheckboxItemIndicator>
          <Icons.Check />
        </BaseUi.Menu.CheckboxItemIndicator>
      </span>
      {children}
    </BaseUi.Menu.CheckboxItem>
}

module RadioGroup = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~id=?,
    ~style=?,
    ~value: option<string>=?,
    ~onValueChange=?,
    ~dataSlot="dropdown-menu-radio-group",
  ) => <BaseUi.Menu.RadioGroup ?id ?style ?value ?onValueChange ?children dataSlot ?className />
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
    <BaseUi.Menu.RadioItem
      ?id
      ?style
      value
      ?disabled
      ?closeOnClick
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
        <BaseUi.Menu.RadioItemIndicator>
          <Icons.Check />
        </BaseUi.Menu.RadioItemIndicator>
      </span>
      {children}
    </BaseUi.Menu.RadioItem>
}

module Separator = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~dataSlot="dropdown-menu-separator") =>
    <BaseUi.Menu.Separator
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
      className={cn("cn-dropdown-menu-shortcut", className)}
      ?children
    />
}

module Sub = {
  @react.component
  let make = (
    ~dataSlot="dropdown-menu-sub",
    ~className=?,
    ~children=?,
    ~open_=?,
    ~defaultOpen=?,
    ~onOpenChange=?,
  ) => <BaseUi.Menu.SubmenuRoot ?className ?children ?open_ ?defaultOpen ?onOpenChange dataSlot />
}

module SubTrigger = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Menu.SubmenuTrigger
      {...props}
      dataSlot={props.dataSlot->Option.getOr("dropdown-menu-sub-trigger")}
      className={cn(
        "cn-dropdown-menu-sub-trigger data-popup-open:bg-accent data-popup-open:text-accent-foreground flex cursor-default items-center outline-hidden select-none [&_svg]:pointer-events-none [&_svg]:shrink-0",
        props.className,
      )}
    >
      {props.children->Option.getOr(React.null)}
      <Icons.ChevronRight className="cn-rtl-flip ml-auto" />
    </BaseUi.Menu.SubmenuTrigger>
}

module SubContent = {
  @react.component(: Content.ContentProps.t)
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
        "cn-dropdown-menu-sub-content cn-menu-target cn-menu-translucent w-auto",
        className,
      )}
    />
}
