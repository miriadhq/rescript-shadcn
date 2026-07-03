@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Variant = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("destructive") Destructive
}

@react.componentWithProps(BaseUi.Menubar.props)
let make = (props: BaseUi.Menubar.props) =>
  <BaseUi.Menubar
    {...props}
    dataSlot="menubar"
    className={cn("cn-menubar flex items-center", props.className)}
  />

module Menu = {
  @react.component
  let make = (
    ~children=?,
    ~open_=?,
    ~defaultOpen=?,
    ~onOpenChange=?,
    ~onOpenChangeComplete=?,
    ~modal=?,
  ) =>
    <DropdownMenu
      ?children
      ?open_
      ?defaultOpen
      ?onOpenChange
      ?onOpenChangeComplete
      ?modal
      dataSlot="menubar-menu"
    />
}

module Group = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?) =>
    <BaseUi.Menu.Group ?id ?style ?children dataSlot="menubar-group" ?className />
}

module Portal = {
  @react.component
  let make = (~children=?, ~container=?) =>
    <BaseUi.Menu.Portal ?children ?container dataSlot="menubar-portal" />
}

module Trigger = {
  @react.componentWithProps(BaseUi.Menu.Trigger.props)
  let make = (props: BaseUi.Menu.Trigger.props) => {
    <DropdownMenu.Trigger
      {...props}
      dataSlot="menubar-trigger"
      className={cn(
        "cn-menubar-trigger flex items-center outline-hidden select-none",
        props.className,
      )}
    />
  }
}

module Content = {
  @react.componentWithProps(DropdownMenu.Content.contentProps)
  let make = (props: DropdownMenu.Content.contentProps) => {
    let align = props.align->Option.getOr(BaseUi.Types.Align.Start)
    let alignOffset = props.alignOffset->Option.getOr(-4.)
    let sideOffset = props.sideOffset->Option.getOr(8.)
    <DropdownMenu.Content
      {...props}
      dataSlot="menubar-content"
      align
      alignOffset
      sideOffset
      className={cn(
        "cn-menubar-content-logical cn-menubar-content cn-menu-target cn-menu-translucent",
        props.className,
      )}
    />
  }
}

module Item = {
  @react.component
  let make = (
    ~inset=?,
    ~variant=Variant.Default,
    ~className=?,
    ~children=?,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~disabled=?,
    ~closeOnClick=?,
  ) => {
    <DropdownMenu.Item
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?disabled
      ?closeOnClick
      ?children
      dataSlot="menubar-item"
      ?inset
      variant={(variant :> DropdownMenu.Variant.t)}
      className={cn(
        "cn-menubar-item group/menubar-item",
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
      dataSlot="menubar-checkbox-item"
      className={cn(
        "cn-menubar-checkbox-item relative flex cursor-default items-center outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0",
        className,
      )}
    >
      <span
        className="cn-menubar-radio-item-indicator pointer-events-none absolute flex items-center justify-center"
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
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~value=?, ~onValueChange=?) =>
    <DropdownMenu.RadioGroup
      dataSlot="menubar-radio-group" ?id ?style ?value ?onValueChange ?children ?className
    />
}

module RadioItem = {
  @react.component
  let make = (
    ~className=?,
    ~children=React.null,
    ~inset=?,
    ~id=?,
    ~style=?,
    ~value,
    ~disabled=?,
    ~closeOnClick=?,
    ~onClick=?,
    ~onKeyDown=?,
  ) =>
    <BaseUi.Menu.RadioItem
      ?id
      ?style
      value
      ?disabled
      ?closeOnClick
      dataInset=?inset
      ?onClick
      ?onKeyDown
      dataSlot="menubar-radio-item"
      className={cn(
        "cn-menubar-radio-item relative flex cursor-default items-center outline-hidden select-none data-disabled:pointer-events-none [&_svg]:pointer-events-none [&_svg]:shrink-0",
        className,
      )}
    >
      <span
        className="cn-menubar-checkbox-item-indicator pointer-events-none absolute flex items-center justify-center"
      >
        <BaseUi.Menu.RadioItemIndicator>
          <Icons.Check />
        </BaseUi.Menu.RadioItemIndicator>
      </span>
      {children}
    </BaseUi.Menu.RadioItem>
}

module Label = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?, ~inset=?) =>
    <DropdownMenu.Label
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?inset
      ?children
      dataSlot="menubar-label"
      className={cn("cn-menubar-label", className)}
    />
}

module Separator = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?) =>
    <DropdownMenu.Separator
      ?id
      ?style
      ?children
      dataSlot="menubar-separator"
      className={cn("cn-menubar-separator -mx-1 my-1 h-px", className)}
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
    ~dataSlot="menubar-shortcut",
  ) =>
    <DropdownMenu.Shortcut
      ?id
      ?style
      ?onClick
      ?onKeyDown
      dataSlot
      className={cn(
        "cn-menubar-shortcut ml-auto",
        className,
      )}
      ?children
    />
}

module Sub = {
  @react.component
  let make = (~className=?, ~children=?, ~open_=?, ~defaultOpen=?, ~onOpenChange=?) =>
    <DropdownMenu.Sub
      dataSlot="menubar-sub" ?className ?children ?open_ ?defaultOpen ?onOpenChange
    />
}

module SubTrigger = {
  type subTriggerProps = {
    inset?: bool,
    ...BaseUi.Types.BaseUIComponentProps.t,
  }
  let toBaseUiProps: subTriggerProps => BaseUi.Types.BaseUIComponentProps.t = %raw(`({inset, ...props}) => props`)

  @react.componentWithProps(subTriggerProps)
  let make = (props: subTriggerProps) => {
    let baseUiProps = toBaseUiProps(props)
    <DropdownMenu.SubTrigger
      {...baseUiProps}
      dataSlot="menubar-sub-trigger"
      dataInset=?props.inset
      className={cn(
        "cn-menubar-sub-trigger",
        props.className,
      )}
    />
  }
}

module SubContent = {
  @react.componentWithProps(DropdownMenu.Content.contentProps)
  let make = (props: DropdownMenu.Content.contentProps) =>
    <DropdownMenu.SubContent
      {...props}
      dataSlot="menubar-sub-content"
      className={cn(
        "cn-menubar-sub-content cn-menu-target cn-menu-translucent",
        props.className,
      )}
    />
}
