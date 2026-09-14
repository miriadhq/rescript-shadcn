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
    {...props} dataSlot="menubar" className={cn("cn-menubar flex items-center", props.className)}
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
  let make = (props: DropdownMenu.Content.props) => {
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
  @react.componentWithProps(DropdownMenu.Item.props)
  let make = (props: DropdownMenu.Item.props) =>
    <DropdownMenu.Item
      {...props}
      dataSlot={props.dataSlot->Option.getOr("menubar-item")}
      dataVariant={(props.variant->Option.getOr(Default) :> string)}
      className={cn("cn-menubar-item group/menubar-item", props.className)}
    />
}

module CheckboxItem = {
  type props = {
    ...BaseUi.Menu.CheckboxItem.props,
    inset?: bool,
  }
  let toCheckboxItemProps: props => BaseUi.Menu.CheckboxItem.props = %raw(`({inset, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) =>
    <BaseUi.Menu.CheckboxItem
      {...props->toCheckboxItemProps}
      dataSlot={props.dataSlot->Option.getOr("menubar-checkbox-item")}
      dataInset=?{props.dataInset->Option.orElse(props.inset)}
      checked=?{props.checked}
      className={cn(
        "cn-menubar-checkbox-item relative flex cursor-default items-center outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0",
        props.className,
      )}
    >
      <span
        className="cn-menubar-radio-item-indicator pointer-events-none absolute flex items-center justify-center"
      >
        <BaseUi.Menu.CheckboxItemIndicator>
          <Icons.Check />
        </BaseUi.Menu.CheckboxItemIndicator>
      </span>
      {props.children->Option.getOr(React.null)}
    </BaseUi.Menu.CheckboxItem>
}

module RadioGroup = {
  @react.componentWithProps(BaseUi.Menu.RadioGroup.props)
  let make = (props: BaseUi.Menu.RadioGroup.props<'value>) =>
    <DropdownMenu.RadioGroup {...props} dataSlot="menubar-radio-group" />
}

module RadioItem = {
  type props<'value> = {inset?: bool, ...BaseUi.Menu.RadioItem.props<'value>}

  let toBaseUiProps: props<'value> => BaseUi.Menu.RadioItem.props<
    'value,
  > = %raw(`({inset, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props<'value>) =>
    <BaseUi.Menu.RadioItem
      {...toBaseUiProps(props)}
      dataSlot={props.dataSlot->Option.getOr("menubar-radio-item")}
      dataInset=?{props.dataInset->Option.orElse(props.inset)}
      className={cn(
        "cn-menubar-radio-item relative flex cursor-default items-center outline-hidden select-none data-disabled:pointer-events-none [&_svg]:pointer-events-none [&_svg]:shrink-0",
        props.className,
      )}
    >
      <span
        className="cn-menubar-checkbox-item-indicator pointer-events-none absolute flex items-center justify-center"
      >
        <BaseUi.Menu.RadioItemIndicator>
          <Icons.Check />
        </BaseUi.Menu.RadioItemIndicator>
      </span>
      {props.children->Option.getOr(React.null)}
    </BaseUi.Menu.RadioItem>
}

module Label = {
  @react.componentWithProps(DropdownMenu.Label.props)
  let make = (props: DropdownMenu.Label.props) =>
    <DropdownMenu.Label
      {...props}
      dataSlot={props.dataSlot->Option.getOr("menubar-label")}
      className={cn("cn-menubar-label", props.className)}
    />
}

module Separator = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <DropdownMenu.Separator
      {...props}
      dataSlot={props.dataSlot->Option.getOr("menubar-separator")}
      className={cn("cn-menubar-separator -mx-1 my-1 h-px", props.className)}
    />
}

module Shortcut = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <DropdownMenu.Shortcut
      {...props}
      dataSlot={props.dataSlot->Option.getOr("menubar-shortcut")}
      className={cn("cn-menubar-shortcut ml-auto", props.className)}
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
  @react.componentWithProps(DropdownMenu.SubTrigger.props)
  let make = (props: DropdownMenu.SubTrigger.props) =>
    <DropdownMenu.SubTrigger
      {...props}
      dataSlot="menubar-sub-trigger"
      className={cn("cn-menubar-sub-trigger", props.className)}
    />
}

module SubContent = {
  @react.componentWithProps(DropdownMenu.Content.props)
  let make = (props: DropdownMenu.Content.props) =>
    <DropdownMenu.SubContent
      {...props}
      dataSlot="menubar-sub-content"
      className={cn("cn-menubar-sub-content cn-menu-target cn-menu-translucent", props.className)}
    />
}
