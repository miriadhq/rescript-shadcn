@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Size = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("sm") Sm
}

type props<'item, 'value> = {...ReactAria.Select.props<'item, 'value>}

@react.componentWithProps(props)
let make = ({...ReactAria.Select.props as props}) =>
  <ReactAria.Select {...props} dataSlot="select" className={cn("w-fit", props.className)} />

module Group = {
  type props<'item, 'children> = {...ReactAria.Select.Group.props<'item, 'children>}

  @react.componentWithProps(props)
  let make = ({...ReactAria.Select.Group.props as props}) =>
    <ReactAria.Select.Group
      {...props} dataSlot="select-group" className={cn("cn-select-group", props.className)}
    />
}

let selectValueChildren: option<React.element> => React.element = %raw(`children =>
  typeof children === "function"
    ? children
    : ({selectedItems, selectedText, defaultChildren}) =>
        selectedItems.length > 1 ? selectedText : defaultChildren
`)

module Value = {
  type props<'item> = {...ReactAria.Select.Value.props<'item>}

  @react.componentWithProps(props)
  let make = ({...ReactAria.Select.Value.props as props}) =>
    <ReactAria.Select.Value
      {...props}
      dataSlot="select-value"
      className={cn("cn-select-value cn-select-value-aria", props.className)}
      children={selectValueChildren(props.children)}
    />
}

module Trigger = {
  type props = {size?: Size.t, ...ReactAria.Button.props}

  @react.componentWithProps(props)
  let make = ({?size, ...ReactAria.Button.props as props}) => {
    let size = size->Option.getOr(Size.Default)
    <ReactAria.Button
      {...props}
      dataSlot="select-trigger"
      dataSize={(size :> string)}
      className={cn(
        "cn-select-trigger flex w-full items-center justify-between whitespace-nowrap outline-none disabled:cursor-not-allowed disabled:opacity-50 *:data-[slot=select-value]:line-clamp-1 *:data-[slot=select-value]:flex *:data-[slot=select-value]:items-center [&_svg]:pointer-events-none [&_svg]:shrink-0",
        props.className,
      )}
    >
      {props.children->Option.getOr(React.null)}
      <Icons.ChevronDown className="cn-select-trigger-icon pointer-events-none" />
    </ReactAria.Button>
  }
}

module Popover = {
  @react.componentWithProps(ReactAria.Popover.props)
  let make = (props: ReactAria.Popover.props) =>
    <ReactAria.Popover
      {...props}
      dataSlot="select-content"
      placement={props.placement->Option.getOr(ReactAria.Common.Placement.BottomStart)}
      offset={props.offset->Option.getOr(4.)}
      crossOffset={props.crossOffset->Option.getOr(0.)}
      className={cn(
        "cn-select-content-aria cn-menu-target cn-menu-translucent cn-menu-translucent-aria relative isolate z-50 w-(--trigger-width) origin-(--trigger-anchor-point) overflow-hidden",
        props.className,
      )}
    />
}

module List = {
  type props<'item> = {...ReactAria.Select.List.props<'item>}

  @react.componentWithProps(props)
  let make = ({...ReactAria.Select.List.props as props}) =>
    <ReactAria.Select.List
      {...props}
      dataSlot="select-list"
      className={cn(
        "group/select-list max-h-[inherit] overflow-x-hidden overflow-y-auto p-0 outline-hidden",
        props.className,
      )}
    />
}

module Content = {
  @react.componentWithProps(ReactAria.Popover.props)
  let make = (props: ReactAria.Popover.props) =>
    <Popover
      {...props}
      placement={props.placement->Option.getOr(ReactAria.Common.Placement.Bottom)}
      offset={props.offset->Option.getOr(4.)}
      crossOffset={props.crossOffset->Option.getOr(0.)}
    >
      <List> {props.children->Option.getOr(React.null)} </List>
    </Popover>
}

module Input = {
  @react.componentWithProps(ReactAria.SearchField.props)
  let make = (props: ReactAria.SearchField.props) =>
    <ReactAria.SearchField
      {...props}
      autoFocus=true
      dataSlot="select-input-wrapper"
      className={cn("p-1 pb-0", props.className)}
    >
      <InputGroup>
        <InputGroup.Input
          dataSlot="select-input"
          type_="search"
          className="[&::-webkit-search-cancel-button]:hidden"
        />
        <InputGroup.Addon>
          <Icons.Search className="cn-command-input-icon" />
        </InputGroup.Addon>
      </InputGroup>
    </ReactAria.SearchField>
}

module Label = {
  @react.componentWithProps(ReactAria.Header.props)
  let make = (props: ReactAria.Header.props) =>
    <ReactAria.Header
      {...props} dataSlot="select-label" className={cn("cn-select-label", props.className)}
    />
}

let textValueFromChildren: option<React.element> => option<string> = %raw(`children =>
  typeof children === "string" ? children : undefined
`)

module Item = {
  type props<'item, 'key> = {...ReactAria.Select.Item.props<'item, 'key>}

  @react.componentWithProps(props)
  let make = ({...ReactAria.Select.Item.props as props}) => {
    let textValue = props.textValue->Option.orElse(textValueFromChildren(props.children))
    let children = ReactAria.Common.composeItemRenderProps(props.children, (
      children,
      {isSelected},
    ) =>
      <>
        <span className="cn-select-item-text shrink-0 whitespace-nowrap"> {children} </span>
        <span className="cn-select-item-indicator">
          {isSelected
            ? <Icons.Check className="cn-select-item-indicator-icon pointer-events-none" />
            : React.null}
        </span>
      </>
    )
    <ReactAria.Select.Item
      {...props}
      ?textValue
      dataSlot="select-item"
      className={cn(
        "cn-select-item cn-select-item-aria relative flex w-full cursor-default items-center outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0",
        props.className,
      )}
      children
    />
  }
}

module Separator = {
  @react.componentWithProps(ReactAria.Separator.props)
  let make = (props: ReactAria.Separator.props) =>
    <ReactAria.Separator
      {...props}
      dataSlot="select-separator"
      className={cn("cn-select-separator pointer-events-none", props.className)}
    />
}

module Empty = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props} dataSlot="select-empty" className={cn("cn-select-empty-aria", props.className)}
    />
}
