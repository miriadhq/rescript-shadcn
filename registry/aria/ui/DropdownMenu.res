@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Variant = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("destructive") Destructive
}

module Trigger = {
  @react.componentWithProps(ReactAria.Menu.Trigger.props)
  let make = (props: ReactAria.Menu.Trigger.props) =>
    <ReactAria.Menu.Trigger {...props} dataSlot="dropdown-menu-trigger" />
}

type props<'item> = {
  placement?: ReactAria.Common.Placement.t,
  offset?: float,
  crossOffset?: float,
  ...ReactAria.Menu.props<'item>,
}

let renderContent = (
  ~placement,
  ~offset,
  ~crossOffset,
  ~className,
  ~children,
  props: ReactAria.Menu.props<'item>,
  ~subContent=false,
) => {
  let dataSlot =
    props.dataSlot->Option.getOr(subContent ? "dropdown-menu-sub-content" : "dropdown-menu-content")
  <ReactAria.Popover
    dataSlot
    placement={placement->Option.getOr(
      subContent ? ReactAria.Common.Placement.EndTop : ReactAria.Common.Placement.BottomStart,
    )}
    offset={offset->Option.getOr(subContent ? 0. : 4.)}
    crossOffset={crossOffset->Option.getOr(subContent ? -3. : 0.)}
    className={cn(
      subContent
        ? "cn-dropdown-menu-content-aria cn-menu-target cn-menu-translucent cn-menu-translucent-aria z-50 w-(--trigger-width) origin-(--trigger-anchor-point) overflow-x-hidden overflow-y-auto outline-none data-exiting:overflow-hidden cn-dropdown-menu-sub-content-aria cn-menu-target cn-menu-translucent w-auto"
        : "cn-dropdown-menu-content-aria cn-menu-target cn-menu-translucent cn-menu-translucent-aria z-50 w-(--trigger-width) origin-(--trigger-anchor-point) overflow-x-hidden overflow-y-auto outline-none data-exiting:overflow-hidden",
      className,
    )}
  >
    <ReactAria.Menu
      {...props} className="max-h-[inherit] overflow-x-hidden overflow-y-auto outline-hidden"
    >
      {children->Option.getOr(React.null)}
    </ReactAria.Menu>
  </ReactAria.Popover>
}

@react.componentWithProps(props)
let make = ({?placement, ?offset, ?crossOffset, ...ReactAria.Menu.props as props}) =>
  renderContent(
    ~placement,
    ~offset,
    ~crossOffset,
    ~className=props.className,
    ~children=props.children,
    props,
  )

module Group = {
  @react.componentWithProps(ReactAria.Menu.Section.props)
  let make = props => <ReactAria.Menu.Section {...props} dataSlot="dropdown-menu-group" />
}

module Label = {
  type props = {inset?: bool, ...ReactAria.Header.props}

  @react.componentWithProps(props)
  let make = ({?inset, ...ReactAria.Header.props as props}) =>
    <ReactAria.Header
      {...props}
      dataSlot="dropdown-menu-label"
      dataInset=?inset
      className={cn("cn-dropdown-menu-label", props.className)}
    />
}

let itemClass = (selectionMode: ReactAria.Common.ItemSelectionMode.t) =>
  switch selectionMode {
  | ReactAria.Common.ItemSelectionMode.None => "cn-dropdown-menu-item"
  | ReactAria.Common.ItemSelectionMode.Single => "cn-dropdown-menu-radio-item"
  | ReactAria.Common.ItemSelectionMode.Multiple => "cn-dropdown-menu-checkbox-item"
  }

let textValueFromChildren: option<React.element> => option<string> = %raw(`children =>
  typeof children === "string" ? children : undefined
`)

module Item = {
  type props<'item> = {inset?: bool, variant?: Variant.t, ...ReactAria.Menu.Item.props<'item>}

  @react.componentWithProps(props)
  let make = ({?inset, ?variant, ...ReactAria.Menu.Item.props as props}) => {
    let textValue = props.textValue->Option.orElse(textValueFromChildren(props.children))
    let renderClassName = ({selectionMode}: ReactAria.Common.ItemRenderProps.t) =>
      cn(
        `group/dropdown-menu-item relative flex cursor-default items-center outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 ${itemClass(
            selectionMode,
          )}`,
        props.className,
      )
    let children = ReactAria.Common.composeItemRenderProps(props.children, (
      children,
      {isSelected, selectionMode},
    ) =>
      <>
        {switch selectionMode {
        | ReactAria.Common.ItemSelectionMode.None => React.null
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
      {...props}
      ?textValue
      dataSlot="dropdown-menu-item"
      dataInset=?inset
      dataVariant={(variant->Option.getOr(Variant.Default) :> string)}
      renderClassName
      children
    />
  }
}

module Sub = {
  @react.componentWithProps(ReactAria.Menu.SubmenuTrigger.props)
  let make = (props: ReactAria.Menu.SubmenuTrigger.props) =>
    <ReactAria.Menu.SubmenuTrigger {...props} dataSlot="dropdown-menu-sub" />
}

module SubTrigger = {
  type props<'item> = {inset?: bool, ...ReactAria.Menu.Item.props<'item>}

  @react.componentWithProps(props)
  let make = ({?inset, ...ReactAria.Menu.Item.props as props}) => {
    let textValue = props.textValue->Option.orElse(textValueFromChildren(props.children))
    let children = ReactAria.Common.composeItemRenderProps(props.children, (children, _) =>
      <>
        {children}
        <Icons.ChevronRight className="cn-rtl-flip ml-auto" />
      </>
    )
    <ReactAria.Menu.Item
      {...props}
      ?textValue
      dataSlot="dropdown-menu-sub-trigger"
      dataInset=?inset
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
  let make = ({?placement, ?offset, ?crossOffset, ...ReactAria.Menu.props as props}) =>
    renderContent(
      ~placement,
      ~offset,
      ~crossOffset,
      ~className=props.className,
      ~children=props.children,
      props,
      ~subContent=true,
    )
}

module Separator = {
  @react.componentWithProps(ReactAria.Separator.props)
  let make = (props: ReactAria.Separator.props) =>
    <ReactAria.Separator
      {...props}
      dataSlot="dropdown-menu-separator"
      className={cn("cn-dropdown-menu-separator", props.className)}
    />
}

module Shortcut = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <span
      {...props}
      dataSlot="dropdown-menu-shortcut"
      className={cn("cn-dropdown-menu-shortcut", props.className)}
    />
}
