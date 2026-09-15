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

@react.componentWithProps(BaseUi.ContextMenu.Root.props)
let make = (props: BaseUi.ContextMenu.Root.props<'payload>) =>
  <BaseUi.ContextMenu.Root {...props} dataSlot={props.dataSlot->Option.getOr("context-menu")} />

module Portal = {
  @react.componentWithProps(BaseUi.ContextMenu.Portal.props)
  let make = (props: BaseUi.ContextMenu.Portal.props) =>
    <BaseUi.ContextMenu.Portal
      {...props} dataSlot={props.dataSlot->Option.getOr("context-menu-portal")}
    />
}

module Trigger = {
  @react.componentWithProps(BaseUi.ContextMenu.Trigger.props)
  let make = (props: BaseUi.ContextMenu.Trigger.props) =>
    <BaseUi.ContextMenu.Trigger
      {...props}
      dataSlot={props.dataSlot->Option.getOr("context-menu-trigger")}
      className={cn("cn-context-menu-trigger select-none", props.className)}
    />
}

module Content = {
  type props = {
    ...BaseUi.Types.BaseUIComponentProps.t,
    align?: Align.t,
    alignOffset?: float,
    side?: Side.t,
    sideOffset?: float,
  }

  let toBaseUiProps: props => BaseUi.Types.BaseUIComponentProps.t = %raw(`({align, alignOffset, side, sideOffset, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let dataSlot = props.dataSlot->Option.getOr("context-menu-content")
    let align = props.align->Option.getOr(Align.Start)
    let alignOffset = props.alignOffset->Option.getOr(4.)
    let side = props.side->Option.getOr(Side.Right)
    let sideOffset = props.sideOffset->Option.getOr(0.)
    <BaseUi.ContextMenu.Portal>
      <BaseUi.ContextMenu.Positioner
        className="isolate z-50 outline-none"
        align
        alignOffset={Const(alignOffset)}
        side
        sideOffset={Const(sideOffset)}
      >
        <BaseUi.ContextMenu.Popup
          {...props->toBaseUiProps}
          dataSlot
          className={cn(
            "cn-context-menu-content-logical cn-context-menu-content cn-menu-target cn-menu-translucent z-50 max-h-(--available-height) origin-(--transform-origin) overflow-x-hidden overflow-y-auto outline-none",
            props.className,
          )}
        />
      </BaseUi.ContextMenu.Positioner>
    </BaseUi.ContextMenu.Portal>
  }
}

module Group = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) => {
    let className = props.className->Option.getOr("")
    <BaseUi.ContextMenu.Group
      {...props} dataSlot={props.dataSlot->Option.getOr("context-menu-group")} className
    />
  }
}

module Label = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.ContextMenu.GroupLabel
      {...props}
      dataSlot={props.dataSlot->Option.getOr("context-menu-label")}
      className={cn("cn-context-menu-label", props.className)}
    />
}

module Item = {
  type props = {
    ...BaseUi.ContextMenu.Item.props,
    inset?: bool,
    variant?: Variant.t,
  }

  let toBaseUiProps: props => BaseUi.ContextMenu.Item.props = %raw(`({inset, variant, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let inset = props.inset
    let variant = props.variant->Option.getOr(Variant.Default)
    <BaseUi.ContextMenu.Item
      {...props->toBaseUiProps}
      dataInset=?{props.dataInset->Option.orElse(inset)}
      dataSlot={props.dataSlot->Option.getOr("context-menu-item")}
      dataVariant={props.dataVariant->Option.getOr((variant :> string))}
      className={cn(
        "cn-context-menu-item group/context-menu-item relative flex cursor-default items-center outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0",
        props.className,
      )}
    />
  }
}

module CheckboxItem = {
  @react.componentWithProps(BaseUi.Menu.CheckboxItem.props)
  let make = (props: BaseUi.Menu.CheckboxItem.props) => {
    let children = props.children->Option.getOr(React.null)
    <BaseUi.ContextMenu.CheckboxItem
      {...props}
      dataSlot={props.dataSlot->Option.getOr("context-menu-checkbox-item")}
      className={cn(
        "cn-context-menu-radio-item relative flex cursor-default items-center outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0",
        props.className,
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
}

module RadioGroup = {
  @react.componentWithProps(BaseUi.Menu.RadioGroup.props)
  let make = (props: BaseUi.Menu.RadioGroup.props<'value>) => {
    let className = props.className->Option.getOr("")
    <BaseUi.ContextMenu.RadioGroup
      {...props} dataSlot={props.dataSlot->Option.getOr("context-menu-radio-group")} className
    />
  }
}

module RadioItem = {
  @react.componentWithProps(BaseUi.Menu.RadioItem.props)
  let make = (props: BaseUi.Menu.RadioItem.props<'value>) => {
    let children = props.children->Option.getOr(React.null)
    <BaseUi.ContextMenu.RadioItem
      {...props}
      dataSlot={props.dataSlot->Option.getOr("context-menu-radio-item")}
      className={cn(
        "cn-context-menu-checkbox-item relative flex cursor-default items-center outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0",
        props.className,
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
}

module Separator = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.ContextMenu.Separator
      {...props}
      dataSlot={props.dataSlot->Option.getOr("context-menu-separator")}
      className={cn("cn-context-menu-separator", props.className)}
    />
}

module Shortcut = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <span
      {...props}
      dataSlot={props.dataSlot->Option.getOr("context-menu-shortcut")}
      className={cn("cn-context-menu-shortcut", props.className)}
    />
}

module Sub = {
  @react.componentWithProps(BaseUi.Menu.SubmenuRoot.props)
  let make = (props: BaseUi.Menu.SubmenuRoot.props<'payload>) =>
    <BaseUi.ContextMenu.SubmenuRoot
      {...props} dataSlot={props.dataSlot->Option.getOr("context-menu-sub")}
    />
}

module SubContent = {
  @react.componentWithProps(Content.props)
  let make = (props: Content.props) => {
    let align = props.align->Option.getOr(Align.Start)
    let alignOffset = props.alignOffset->Option.getOr(4.)
    let side = props.side->Option.getOr(Side.Right)
    let sideOffset = props.sideOffset->Option.getOr(0.)
    <Content
      {...props}
      align
      alignOffset
      side
      sideOffset
      dataSlot={props.dataSlot->Option.getOr("context-menu-sub-content")}
      className={cn("cn-context-menu-subcontent", props.className)}
    />
  }
}

module SubTrigger = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) => {
    let children = props.children->Option.getOr(React.null)
    <BaseUi.ContextMenu.SubmenuTrigger
      {...props}
      dataSlot={props.dataSlot->Option.getOr("context-menu-sub-trigger")}
      className={cn(
        "cn-context-menu-sub-trigger flex cursor-default items-center outline-hidden select-none [&_svg]:pointer-events-none [&_svg]:shrink-0",
        props.className,
      )}
    >
      {children}
      <Icons.ChevronRight className="cn-rtl-flip ml-auto" />
    </BaseUi.ContextMenu.SubmenuTrigger>
  }
}
