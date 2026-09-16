@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("cn")
external cn: (string, option<string>) => string = "cn"

module Variant = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("destructive") Destructive
}

module Trigger = {
  @react.componentWithProps(ReactAria.Menu.Trigger.props)
  let make = (props: ReactAria.Menu.Trigger.props) => {
    let dataSlot = props.dataSlot->Option.getOr("dropdown-menu-trigger")
    <ReactAria.Menu.Trigger {...props} dataSlot />
  }
}

type props<'item> = {
  placement?: ReactAria.Common.placement,
  offset?: float,
  crossOffset?: float,
  ...ReactAria.Menu.props<'item>,
}

let toMenuProps: props<'item> => ReactAria.Menu.props<
  'item,
> = %raw(`({placement, offset, crossOffset, className, children, ...props}) => props`)

module Base = {
  @react.componentWithProps(props)
  let make = (props: props<'item>) => {
    let dataSlot = props.dataSlot->Option.getOr("dropdown-menu-content")
    let placement = props.placement->Option.getOr(BottomStart)
    let offset = props.offset->Option.getOr(4.)
    let crossOffset = props.crossOffset->Option.getOr(0.)
    <ReactAria.Popover
      dataSlot
      placement
      offset
      crossOffset
      className={cn(
        "cn-dropdown-menu-content-aria cn-menu-target cn-menu-translucent cn-menu-translucent-aria z-50 w-(--trigger-width) origin-(--trigger-anchor-point) overflow-x-hidden overflow-y-auto outline-none data-exiting:overflow-hidden",
        props.className,
      )}
    >
      <ReactAria.Menu
        {...props->toMenuProps}
        className="max-h-[inherit] overflow-x-hidden overflow-y-auto outline-hidden"
      >
        {props.children->Option.getOr(React.null)}
      </ReactAria.Menu>
    </ReactAria.Popover>
  }
}

module Group = {
  @react.componentWithProps(ReactAria.Menu.Section.props)
  let make = (props: ReactAria.Menu.Section.props<'item>) => {
    let dataSlot = props.dataSlot->Option.getOr("dropdown-menu-group")
    <ReactAria.Menu.Section {...props} dataSlot />
  }
}

module Label = {
  type props = {inset?: bool, ...ReactAria.Header.props}
  let headerProps: props => ReactAria.Header.props = %raw(`({inset, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let dataSlot = props.dataSlot->Option.getOr("dropdown-menu-label")
    <ReactAria.Header
      {...props->headerProps}
      dataSlot
      dataInset=?{props.inset}
      className={cn("cn-dropdown-menu-label", props.className)}
    />
  }
}

let itemClass = (selectionMode: ReactAria.Common.itemSelectionMode) =>
  switch selectionMode {
  | ReactAria.Common.None => "cn-dropdown-menu-item"
  | ReactAria.Common.Single => "cn-dropdown-menu-radio-item"
  | ReactAria.Common.Multiple => "cn-dropdown-menu-checkbox-item"
  }

let textValueFromChildren: option<React.element> => option<string> = %raw(`children =>
  typeof children === "string" ? children : undefined
`)

module Item = {
  type props<'item> = {inset?: bool, variant?: Variant.t, ...ReactAria.Menu.Item.props<'item>}
  let itemProps: props<'item> => ReactAria.Menu.Item.props<
    'item,
  > = %raw(`({inset, variant, className, children, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props<'item>) => {
    let dataSlot = props.dataSlot->Option.getOr("dropdown-menu-item")
    let textValue = props.textValue->Option.orElse(textValueFromChildren(props.children))
    let className = ReactAria.Common.itemRenderClassName(({selectionMode}) =>
      cn(
        `group/dropdown-menu-item relative flex cursor-default items-center outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 ${itemClass(
            selectionMode,
          )}`,
        props.className,
      )
    )
    let children = ReactAria.Common.composeItemRenderProps(props.children, (
      children,
      {isSelected, selectionMode},
    ) =>
      <>
        {switch selectionMode {
        | ReactAria.Common.None => React.null
        | Single | Multiple =>
          <span
            className="cn-dropdown-menu-item-indicator pointer-events-none"
            dataSlot={switch selectionMode {
            | Single => "dropdown-menu-radio-item-indicator"
            | Multiple => "dropdown-menu-checkbox-item-indicator"
            | None => ""
            }}
          >
            {isSelected ? <Icons.Check /> : React.null}
          </span>
        }}
        {children}
      </>
    )
    <ReactAria.Menu.Item
      {...props->itemProps}
      ?textValue
      dataSlot
      dataInset=?{props.inset}
      dataVariant={(props.variant->Option.getOr(Default) :> string)}
      className
      children
    />
  }
}

module Sub = {
  @react.componentWithProps(ReactAria.Menu.SubmenuTrigger.props)
  let make = (props: ReactAria.Menu.SubmenuTrigger.props) => {
    let dataSlot = props.dataSlot->Option.getOr("dropdown-menu-sub")
    <ReactAria.Menu.SubmenuTrigger {...props} dataSlot />
  }
}

module SubTrigger = {
  type props<'item> = {inset?: bool, ...ReactAria.Menu.Item.props<'item>}
  let itemProps: props<'item> => ReactAria.Menu.Item.props<
    'item,
  > = %raw(`({inset, className, children, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props<'item>) => {
    let dataSlot = props.dataSlot->Option.getOr("dropdown-menu-sub-trigger")
    let textValue = props.textValue->Option.orElse(textValueFromChildren(props.children))
    let children = ReactAria.Common.composeItemRenderProps(props.children, (children, _) =>
      <>
        {children}
        <Icons.ChevronRight className="cn-rtl-flip ml-auto" />
      </>
    )
    <ReactAria.Menu.Item
      {...props->itemProps}
      ?textValue
      dataSlot
      dataInset=?{props.inset}
      className={cn(
        "cn-dropdown-menu-sub-trigger flex cursor-default items-center outline-hidden select-none [&_svg]:pointer-events-none [&_svg]:shrink-0",
        props.className,
      )}
      children
    />
  }
}

module SubContent = {
  @react.componentWithProps(props)
  let make = (props: props<'item>) => {
    let dataSlot = props.dataSlot->Option.getOr("dropdown-menu-sub-content")
    let placement = props.placement->Option.getOr(EndTop)
    let crossOffset = props.crossOffset->Option.getOr(-3.)
    let offset = props.offset->Option.getOr(0.)
    <Base
      {...props}
      dataSlot
      className={cn(
        "cn-dropdown-menu-sub-content-aria cn-menu-target cn-menu-translucent w-auto",
        props.className,
      )}
      placement
      crossOffset
      offset
    />
  }
}

module Separator = {
  @react.componentWithProps(ReactAria.Separator.props)
  let make = (props: ReactAria.Separator.props) => {
    let dataSlot = props.dataSlot->Option.getOr("dropdown-menu-separator")
    <ReactAria.Separator
      {...props} dataSlot className={cn("cn-dropdown-menu-separator", props.className)}
    />
  }
}

module Shortcut = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) => {
    let dataSlot = props.dataSlot->Option.getOr("dropdown-menu-shortcut")
    <span {...props} dataSlot className={cn("cn-dropdown-menu-shortcut", props.className)} />
  }
}

include Base
