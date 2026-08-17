@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@module("react-dom")
external createPortal: (React.element, Dom.element) => React.element = "createPortal"

@val external documentBody: Dom.element = "document.body"
@send external preventDefault: JsxEvent.Mouse.t => unit = "preventDefault"
@get external clientX: JsxEvent.Mouse.t => float = "clientX"
@get external clientY: JsxEvent.Mouse.t => float = "clientY"

module Position = {
  type t = {x: float, y: float}
}

let anchorStyle: Position.t => ReactDOM.Style.t = %raw(`position => ({
  position: "fixed",
  top: position.y,
  left: position.x,
})`)

@module("react-aria-components")
external popoverContext: React.Context.t<JSON.t> = "PopoverContext"

let withPosition: (
  JSON.t,
  option<Position.t>,
  ReactDOM.domRef,
) => JSON.t = %raw(`(context, position, triggerRef) => ({
  ...context,
  ...position,
  triggerRef,
  style: undefined,
})`)

module PopoverContextProvider = {
  let make = React.Context.provider(popoverContext)
}

module Variant = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("destructive") Destructive
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
    props.dataSlot->Option.getOr(subContent ? "context-menu-sub-content" : "context-menu-content")
  <ReactAria.Popover
    dataSlot
    placement={placement->Option.getOr(
      subContent ? ReactAria.Common.Placement.EndTop : ReactAria.Common.Placement.BottomStart,
    )}
    offset={offset->Option.getOr(subContent ? 0. : 4.)}
    crossOffset={crossOffset->Option.getOr(subContent ? -3. : 0.)}
    className={cn(
      subContent
        ? "cn-context-menu-content-aria cn-menu-target cn-menu-translucent cn-menu-translucent-aria z-50 w-(--trigger-width) origin-(--trigger-anchor-point) overflow-x-hidden overflow-y-auto outline-none data-exiting:overflow-hidden cn-context-menu-sub-content-aria cn-menu-target cn-menu-translucent w-auto"
        : "cn-context-menu-content-aria cn-menu-target cn-menu-translucent cn-menu-translucent-aria z-50 w-(--trigger-width) origin-(--trigger-anchor-point) overflow-x-hidden overflow-y-auto outline-none data-exiting:overflow-hidden",
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

module Trigger = {
  type props = {...ReactAria.Menu.Trigger.props}

  @warning("-112") @react.componentWithProps(props)
  let make = ({
    ?className,
    ?children,
    isOpen: ?_,
    defaultOpen: ?_,
    trigger: ?_,
    ...ReactAria.Menu.Trigger.props as props,
  }) => {
    let (position, setPosition) = React.useState(() => None)
    let positionRef = React.useRef(null)->ReactDOM.Ref.domRef
    let context = React.useContext(popoverContext)
    let isOpen = position->Option.isSome
    let handleOpenChange = isOpen =>
      if !isOpen {
        setPosition(_ => None)
        props.onOpenChange->Option.forEach(callback => callback(false))
      }
    let handleContextMenu = event => {
      event->preventDefault
      let wasOpen = position->Option.isSome
      let next: Position.t = {x: event->clientX, y: event->clientY}
      setPosition(_ => Some(next))
      if !wasOpen {
        props.onOpenChange->Option.forEach(callback => callback(true))
      }
    }
    <ReactAria.Menu.Trigger {...props} dataSlot="context-menu" isOpen onOpenChange=handleOpenChange>
      {switch position {
      | Some(position) =>
        createPortal(
          <div dataSlot="context-menu-anchor" ref={positionRef} style={anchorStyle(position)} />,
          documentBody,
        )
      | None => React.null
      }}
      <div
        dataSlot="context-menu-trigger"
        className={cn("cn-context-menu-trigger contents select-none", className)}
        onContextMenu=handleContextMenu
      >
        <PopoverContextProvider value={withPosition(context, position, positionRef)}>
          {children->Option.getOr(React.null)}
        </PopoverContextProvider>
      </div>
    </ReactAria.Menu.Trigger>
  }
}

module Group = {
  @react.componentWithProps(ReactAria.Menu.Section.props)
  let make = props => <ReactAria.Menu.Section {...props} dataSlot="context-menu-group" />
}

module Label = {
  type props = {inset?: bool, ...ReactAria.Header.props}

  @react.componentWithProps(props)
  let make = ({?inset, ...ReactAria.Header.props as props}) =>
    <ReactAria.Header
      {...props}
      dataSlot="context-menu-label"
      dataInset=?inset
      className={cn("cn-context-menu-label", props.className)}
    />
}

let itemClass = (selectionMode: ReactAria.Common.ItemSelectionMode.t) =>
  switch selectionMode {
  | ReactAria.Common.ItemSelectionMode.None => "cn-context-menu-item"
  | ReactAria.Common.ItemSelectionMode.Single => "cn-context-menu-radio-item"
  | ReactAria.Common.ItemSelectionMode.Multiple => "cn-context-menu-checkbox-item"
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
        `group/context-menu-item relative flex cursor-default items-center outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 ${itemClass(
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
            className="cn-context-menu-item-indicator pointer-events-none"
            dataSlot={switch selectionMode {
            | Single => "context-menu-radio-item-indicator"
            | Multiple => "context-menu-checkbox-item-indicator"
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
      dataSlot="context-menu-item"
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
    <ReactAria.Menu.SubmenuTrigger {...props} dataSlot="context-menu-sub" />
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
      dataSlot="context-menu-sub-trigger"
      dataInset=?inset
      className={cn(
        "cn-context-menu-sub-trigger flex cursor-default items-center outline-hidden select-none [&_svg]:pointer-events-none [&_svg]:shrink-0",
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
      dataSlot="context-menu-separator"
      className={cn("cn-context-menu-separator", props.className)}
    />
}

module Shortcut = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <span
      {...props}
      dataSlot="context-menu-shortcut"
      className={cn("cn-context-menu-shortcut", props.className)}
    />
}
