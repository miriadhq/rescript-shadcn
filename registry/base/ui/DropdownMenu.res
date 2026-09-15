@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

open BaseUi.Types

@module("cn")
external cn: (string, option<string>) => string = "cn"

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
    <BaseUi.Menu.Trigger
      {...props} dataSlot={props.dataSlot->Option.getOr("dropdown-menu-trigger")}
    />
}

module Content = {
  type props = {
    align?: Align.t,
    alignOffset?: float,
    side?: Side.t,
    sideOffset?: float,
    ...BaseUi.Types.BaseUIComponentProps.t,
  }

  let toBaseUiProps: props => BaseUi.Types.BaseUIComponentProps.t = %raw(`({align, alignOffset, side, sideOffset, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    <BaseUi.Menu.Portal>
      <BaseUi.Menu.Positioner
        className="isolate z-50 outline-none"
        align={props.align->Option.getOr(Align.Start)}
        alignOffset={Const(props.alignOffset->Option.getOr(0.))}
        side={props.side->Option.getOr(Side.Bottom)}
        sideOffset={Const(props.sideOffset->Option.getOr(4.))}
      >
        <BaseUi.Menu.Popup
          {...toBaseUiProps(props)}
          dataSlot={props.dataSlot->Option.getOr("dropdown-menu-content")}
          className={cn(
            "cn-dropdown-menu-content cn-dropdown-menu-content-logical cn-menu-target cn-menu-translucent z-50 max-h-(--available-height) w-(--anchor-width) origin-(--transform-origin) overflow-x-hidden overflow-y-auto outline-none data-closed:overflow-hidden",
            props.className,
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
  type props = {
    ...BaseUi.Types.BaseUIComponentProps.t,
    inset?: bool,
  }

  let toBaseUiProps: props => BaseUi.Types.BaseUIComponentProps.t = %raw(`({inset, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) =>
    <BaseUi.Menu.GroupLabel
      {...toBaseUiProps(props)}
      dataSlot={props.dataSlot->Option.getOr("dropdown-menu-label")}
      dataInset=?{props.dataInset->Option.orElse(props.inset)}
      className={cn("cn-dropdown-menu-label", props.className)}
    />
}

module Item = {
  type props = {
    inset?: bool,
    variant?: Variant.t,
    ...BaseUi.Menu.Item.props,
  }

  let toBaseUiProps: props => BaseUi.Menu.Item.props = %raw(`({inset, variant, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let variant = props.variant->Option.getOr(Variant.Default)

    <BaseUi.Menu.Item
      {...toBaseUiProps(props)}
      dataSlot={props.dataSlot->Option.getOr("dropdown-menu-item")}
      dataInset=?{props.dataInset->Option.orElse(props.inset)}
      dataVariant={(variant :> string)}
      className={cn(
        "cn-dropdown-menu-item group/dropdown-menu-item relative flex cursor-default items-center outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0",
        props.className,
      )}
    />
  }
}

module CheckboxItem = {
  @react.componentWithProps(BaseUi.Menu.CheckboxItem.props)
  let make = (props: BaseUi.Menu.CheckboxItem.props) =>
    <BaseUi.Menu.CheckboxItem
      {...props}
      dataSlot={props.dataSlot->Option.getOr("dropdown-menu-checkbox-item")}
      className={cn(
        "cn-dropdown-menu-checkbox-item relative flex cursor-default items-center outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0",
        props.className,
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
      {props.children->Option.getOr(React.null)}
    </BaseUi.Menu.CheckboxItem>
}

module RadioGroup = {
  @react.componentWithProps(BaseUi.Menu.RadioGroup.props)
  let make = (props: BaseUi.Menu.RadioGroup.props<'value>) =>
    <BaseUi.Menu.RadioGroup
      {...props} dataSlot={props.dataSlot->Option.getOr("dropdown-menu-radio-group")}
    />
}

module RadioItem = {
  @react.componentWithProps(BaseUi.Menu.RadioItem.props)
  let make = (props: BaseUi.Menu.RadioItem.props<'value>) =>
    <BaseUi.Menu.RadioItem
      {...props}
      dataSlot={props.dataSlot->Option.getOr("dropdown-menu-radio-item")}
      className={cn(
        "cn-dropdown-menu-radio-item relative flex cursor-default items-center outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0",
        props.className,
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
      {props.children->Option.getOr(React.null)}
    </BaseUi.Menu.RadioItem>
}

module Separator = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Menu.Separator
      {...props}
      dataSlot={props.dataSlot->Option.getOr("dropdown-menu-separator")}
      className={cn("cn-dropdown-menu-separator", props.className)}
    />
}

module Shortcut = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <span
      {...props}
      dataSlot={props.dataSlot->Option.getOr("dropdown-menu-shortcut")}
      className={cn("cn-dropdown-menu-shortcut", props.className)}
    />
}

module Sub = {
  @react.componentWithProps(BaseUi.Menu.SubmenuRoot.props)
  let make = (props: BaseUi.Menu.SubmenuRoot.props<'payload>) =>
    <BaseUi.Menu.SubmenuRoot
      {...props} dataSlot={props.dataSlot->Option.getOr("dropdown-menu-sub")}
    />
}

module SubTrigger = {
  type props = {
    ...BaseUi.Types.BaseUIComponentProps.t,
    inset?: bool,
  }

  let toBaseUiProps: props => BaseUi.Types.BaseUIComponentProps.t = %raw(`({inset, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) =>
    <BaseUi.Menu.SubmenuTrigger
      {...toBaseUiProps(props)}
      dataSlot={props.dataSlot->Option.getOr("dropdown-menu-sub-trigger")}
      dataInset=?{props.dataInset->Option.orElse(props.inset)}
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
  @react.componentWithProps(Content.contentProps)
  let make = (props: Content.props) =>
    <Content
      {...props}
      align={props.align->Option.getOr(Align.Start)}
      alignOffset={props.alignOffset->Option.getOr(-3.)}
      side={props.side->Option.getOr(Side.Right)}
      sideOffset={props.sideOffset->Option.getOr(0.)}
      dataSlot={props.dataSlot->Option.getOr("dropdown-menu-sub-content")}
      className={cn(
        "cn-dropdown-menu-sub-content cn-menu-target cn-menu-translucent w-auto",
        props.className,
      )}
    />
}
