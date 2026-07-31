@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@@directive("'use client'")

open ReactAria.Types

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Size = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("sm") Sm
}

type rootProps<'value> = {
  ...ReactAria.Common.baseProps,
  value?: 'value,
  defaultValue?: 'value,
  onValueChange?: ('value, JSON.t) => unit,
  disabled?: bool,
  required?: bool,
  readOnly?: bool,
  name?: string,
  items?: array<ReactAria.Select.item<'value>>,
  inputRef?: ReactDOM.domRef,
  highlightItemOnHover?: bool,
  itemToStringLabel?: 'value => string,
  itemToStringValue?: 'value => string,
  isItemEqualToValue?: ('value, 'value) => bool,
}

let toAriaProps: rootProps<'value> => ReactAria.Select.props<ReactAria.Select.item<'value>, 'value> = %raw(`props => {
  const {value, defaultValue, onValueChange, disabled, required, readOnly, inputRef,
    highlightItemOnHover, itemToStringLabel, itemToStringValue, isItemEqualToValue, ...rest} = props;
  return {...rest, value, defaultValue,
    onChange: onValueChange == null ? undefined : value => onValueChange(value, undefined),
    isDisabled: disabled, isRequired: required};
}`)

@react.componentWithProps(rootProps)
let make = (props: rootProps<'value>) => <ReactAria.Select {...props->toAriaProps} />

module Multiple = {
  @react.componentWithProps(rootProps)
  let make = (props: rootProps<array<'value>>) => <ReactAria.Select {...props->toAriaProps} />
}

module Group = {
  @react.componentWithProps(ReactAria.Select.Group.props)
  let make = (props: ReactAria.Select.Group.props<'item>) =>
    <ReactAria.Select.Group
      {...props}
      dataSlot={props.dataSlot->Option.getOr("select-group")}
      className={cn("cn-select-group", props.className)}
    />
}

module Value = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~placeholder=?) =>
    <ReactAria.Select.Value
      ?id
      ?style
      ?placeholder
      ?children
      dataSlot="select-value"
      className={cn("cn-select-value cn-select-value-aria", className)}
    />
}

module ScrollUpButton = {
  @react.component
  let make = (~className=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <span
      ?id
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="select-scroll-up-button"
      className={cn(
        "cn-select-scroll-up-button top-0 w-full",
        className,
      )}
    >
      <Icons.ChevronUp />
    </span>
}

module ScrollDownButton = {
  @react.component
  let make = (~className=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <span
      ?id
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="select-scroll-down-button"
      className={cn(
        "cn-select-scroll-down-button bottom-0 w-full",
        className,
      )}
    >
      <Icons.ChevronDown />
    </span>
}

module Trigger = {
  type triggerProps = {
    size?: Size.t,
    ...ReactAria.Types.BaseUIComponentProps.t,
  }
  let toAriaProps: triggerProps => ReactAria.Button.props = %raw(`props => {
    const {size, disabled, render, nativeButton, focusableWhenDisabled, onClick, ...rest} = props;
    return {...rest, isDisabled: disabled, allowFocusWhenDisabled: focusableWhenDisabled, onPress: onClick};
  }`)
  @react.componentWithProps(triggerProps)
  let make = (props: triggerProps) => {
    let size = props.size->Option.getOr(Default)
    let ariaProps = props->toAriaProps
    <ReactAria.Button
      {...ariaProps}
      dataSlot={props.dataSlot->Option.getOr("select-trigger")}
      dataSize={(size :> string)}
      className={cn(
        "cn-select-trigger flex w-fit items-center justify-between whitespace-nowrap outline-none disabled:cursor-not-allowed disabled:opacity-50 *:data-[slot=select-value]:line-clamp-1 *:data-[slot=select-value]:items-center [&_svg]:pointer-events-none [&_svg]:shrink-0",
        props.className,
      )}
    >
      {props.children->Option.getOr(React.null)}
      <Icons.ChevronDown className="cn-select-trigger-icon pointer-events-none" />
    </ReactAria.Button>
  }
}

module Content = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~side=Side.Bottom,
    ~sideOffset=4.,
    ~align=Align.Center,
    ~alignOffset=0.,
    ~dataAlignTrigger=true,
  ) => {
    let alignItemWithTrigger = dataAlignTrigger
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
    <ReactAria.Popover
          ?id
          ?style
          ?onClick
          ?onKeyDown
          dataSlot="select-content"
          dataAlignTrigger={alignItemWithTrigger}
          placement
          offset={sideOffset}
          crossOffset={alignOffset}
          className={cn(
            "cn-select-content-logical cn-select-content cn-select-content-aria cn-menu-target cn-menu-translucent cn-menu-translucent-aria relative isolate z-50 max-h-(--available-height) w-(--anchor-width) origin-(--transform-origin) overflow-x-hidden overflow-y-auto data-[align-trigger=true]:animate-none",
            className,
          )}
        >
          <ScrollUpButton />
          <ReactAria.Select.List ?children />
          <ScrollDownButton />
        </ReactAria.Popover>
  }
}

module Label = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <ReactAria.Select.GroupLabel
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?children
      dataSlot="select-label"
      className={cn("cn-select-label", className)}
    />
}

module Input = {
  @react.component
  let make = (~className=?, ~value=?, ~defaultValue=?, ~onChange=?, ~id=?, ~style=?) =>
    <ReactAria.SearchField
      ?id
      ?style
      ?value
      ?defaultValue
      ?onChange
      autoFocus=true
      dataSlot="select-input-wrapper"
      className={cn("p-1 pb-0", className)}
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

module Item = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~disabled=?,
    ~value=?,
    ~label=?,
  ) => {
    let renderedChildren = ReactAria.Common.itemRenderChildren(state =>
      <>
        <span className="cn-select-item-text shrink-0 whitespace-nowrap" ?children />
        <span className="cn-select-item-indicator">
          {state.isSelected
            ? <Icons.Check className="cn-select-item-indicator-icon pointer-events-none" />
            : React.null}
        </span>
      </>
    )

    <ReactAria.Select.Item
      ?id
      ?style
      ?onClick
      ?onKeyDown
      isDisabled=?disabled
      ?value
      textValue=?label
      dataSlot="select-item"
      className={cn(
        "cn-select-item cn-select-item-aria relative flex w-full cursor-default items-center outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0",
        className,
      )}
    >
      {renderedChildren}
    </ReactAria.Select.Item>
  }
}

module Separator = {
  @react.component
  let make = (~className=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <ReactAria.Separator
      ?id
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="select-separator"
      className={cn("cn-select-separator pointer-events-none", className)}
    />
}

module Empty = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?) =>
    <div
      ?id
      ?style
      ?children
      dataSlot="select-empty"
      className={cn("cn-select-empty-aria", className)}
    />
}
