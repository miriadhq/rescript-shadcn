@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@@directive("'use client'")

open ReactAria.Types

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

type rootProps<'item, 'value> = {
  ...ReactAria.Common.baseProps,
  items?: array<'item>,
  value?: 'value,
  defaultValue?: 'value,
  onValueChange?: ('value, JSON.t) => unit,
  inputValue?: string,
  defaultInputValue?: string,
  onInputValueChange?: (string, JSON.t) => unit,
  disabled?: bool,
  required?: bool,
  readOnly?: bool,
  name?: string,
  openOnInputClick?: bool,
  grid?: bool,
  filteredItems?: array<'item>,
  virtualized?: bool,
  inline?: bool,
  limit?: float,
  locale?: string,
  autoHighlight?: bool,
  highlightItemOnHover?: bool,
  itemToStringLabel?: 'item => string,
  itemToStringValue?: 'item => string,
  isItemEqualToValue?: ('item, 'item) => bool,
  allowsEmptyCollection?: bool,
}

let toAriaProps: rootProps<'item, 'value> => ReactAria.Combobox.props<'item, 'value> = %raw(`props => {
  const {value, defaultValue, onValueChange, onInputValueChange, disabled, required, readOnly,
    openOnInputClick, grid, filteredItems, virtualized, inline, limit, locale, autoHighlight,
    highlightItemOnHover, itemToStringLabel, itemToStringValue, isItemEqualToValue, ...rest} = props;
  return {...rest, value, defaultValue,
    onChange: onValueChange == null ? undefined : value => onValueChange(value, undefined),
    onInputChange: onInputValueChange == null ? undefined : value => onInputValueChange(value, undefined),
    isDisabled: disabled, isRequired: required, isReadOnly: readOnly};
}`)

@react.componentWithProps(rootProps)
let make = (props: rootProps<'item, 'value>) => <ReactAria.Combobox {...props->toAriaProps} />

module Multiple = {
  type props<'item> = rootProps<'item, array<'item>>

  let toMultipleProps: props<'item> => ReactAria.Combobox.props<'item, array<'item>> = %raw(`props => {
    const {value, defaultValue, onValueChange, onInputValueChange, disabled, required, readOnly,
      openOnInputClick, grid, filteredItems, virtualized, inline, limit, locale, autoHighlight,
      highlightItemOnHover, itemToStringLabel, itemToStringValue, isItemEqualToValue, ...rest} = props;
    return {...rest, value, defaultValue, selectionMode: "multiple",
      onChange: onValueChange == null ? undefined : value => onValueChange(value, undefined),
      onInputChange: onInputValueChange == null ? undefined : value => onInputValueChange(value, undefined),
      isDisabled: disabled, isRequired: required, isReadOnly: readOnly};
  }`)

  @react.componentWithProps(props)
  let make = (props: props<'item>) => <ReactAria.Combobox {...props->toMultipleProps} />
}

module Value = {
  type props<'value> = {
    children?: array<'value> => React.element,
    placeholder?: React.element,
    className?: string,
    id?: string,
    style?: ReactDOM.Style.t,
  }

  let toAriaProps: props<'value> => ReactAria.Combobox.Value.props<'value> = %raw(`props => ({
    ...props,
    children: props.children == null ? undefined : state => props.children(state.selectedItems.filter(value => value != null))
  })`)

  @react.componentWithProps(props)
  let make = (props: props<'value>) =>
    <ReactAria.Combobox.Value {...props->toAriaProps} dataSlot="combobox-value" />
}

module Trigger = {
  @react.component
  let make = (
    ~className=?,
    ~children=React.null,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~disabled=?,
    ~render=?,
    ~nativeButton=?,
    ~type_=?,
    ~ariaLabel=?,
    ~tabIndex=?,
  ) =>
    <Button.Primitive
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?disabled
      ?render
      ?nativeButton
      ?type_
      ?ariaLabel
      ?tabIndex
      dataSlot="combobox-trigger"
      className={cn("cn-combobox-trigger", className)}
    >
      {children}
      <Icons.ChevronDown className="cn-combobox-trigger-icon pointer-events-none" />
    </Button.Primitive>
}

module Clear = {
  @react.component
  let make = (
    ~className="",
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~disabled=?,
    ~nativeButton=?,
    ~type_=?,
    ~ariaLabel=?,
  ) =>
    <InputGroup.Button
      dataSlot="combobox-clear"
      variant=Ghost
      size=IconXs
      className={cn("cn-combobox-clear", Some(className))}
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?disabled
      ?nativeButton
      ?type_
      ?ariaLabel
      slot="clear"
    >
      <Icons.X className="cn-combobox-clear-icon pointer-events-none" />
    </InputGroup.Button>
}

module Input = {
  type inputProps = {
    showTrigger?: bool,
    showClear?: bool,
    ...Aria.Input.props,
  }
  let toInputProps: inputProps => Aria.Input.props = %raw(`({className, children, showTrigger, showClear,...rest}) => rest`)
  @react.componentWithProps(inputProps)
  let make = (props: inputProps) => {
    let disabled = props.disabled->Option.getOr(false)
    let showTrigger = props.showTrigger->Option.getOr(true)
    let showClear = props.showClear->Option.getOr(false)
    let inputProps = toInputProps(props)
    <InputGroup className={cn("cn-combobox-input w-auto", props.className)}>
      <InputGroup.Input {...inputProps} disabled />
      <InputGroup.Addon align=InlineEnd>
        {showTrigger
          ? <InputGroup.Button
              size=IconXs
              variant=Ghost
              render={<Trigger />}
              dataSlot="input-group-button"
              className="group-has-data-[slot=combobox-clear]/input-group:hidden data-pressed:bg-transparent"
              disabled
            />
          : React.null}
        {showClear ? <Clear disabled /> : React.null}
      </InputGroup.Addon>
      {props.children->Option.getOr(React.null)}
    </InputGroup>
  }
}

module Content = {
  @react.component
  let make = (
    ~className=?,
    ~side=Side.Bottom,
    ~sideOffset=6.,
    ~align=Align.Start,
    ~alignOffset=0.,
    ~anchor=?,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~dir=?,
    ~dataLang=?,
    ~children=?,
  ) => {
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
          ?dir
          ?dataLang
          dataSlot="combobox-content"
          dataChips={anchor->Option.isSome}
          triggerRef=?anchor
          placement
          offset={sideOffset}
          crossOffset={alignOffset}
          className={cn(
            "cn-combobox-content cn-combobox-content-aria cn-combobox-content-logical cn-menu-target cn-menu-translucent cn-menu-translucent-aria group/combobox-content relative max-h-(--available-height) w-(--anchor-width) max-w-(--available-width) min-w-[calc(var(--anchor-width)+--spacing(7))] origin-(--transform-origin) overflow-hidden rounded-lg bg-popover text-popover-foreground shadow-md ring-1 ring-foreground/10 duration-100 data-[chips=true]:min-w-(--anchor-width) data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 *:data-[slot=input-group]:m-1 *:data-[slot=input-group]:mb-0 *:data-[slot=input-group]:h-8 *:data-[slot=input-group]:border-input/30 *:data-[slot=input-group]:bg-input/30 *:data-[slot=input-group]:shadow-none data-open:animate-in data-open:fade-in-0 data-open:zoom-in-95 data-closed:animate-out data-closed:fade-out-0 data-closed:zoom-out-95",
            className,
          )}
          ?children
        />
  }
}

module List = {
  @react.componentWithProps(ReactAria.Combobox.List.props)
  let make = (props: ReactAria.Combobox.List.props<'item>) => {
    <ReactAria.Combobox.List
      {...props}
      dataSlot="combobox-list"
      className={cn(
        "cn-combobox-list overscroll-contain",
        props.className,
      )}
    />
  }
}

module Item = {
  @react.componentWithProps(ReactAria.Combobox.Item.props)
  let make = (props: ReactAria.Combobox.Item.props<'value>) => {
    let renderedChildren = ReactAria.Common.itemRenderChildren(state =>
      <span className="contents">
        {props.children->Option.getOr(React.null)}
        <span className="cn-combobox-item-indicator">
          {state.isSelected
            ? <Icons.Check className="cn-combobox-item-indicator-icon pointer-events-none" />
            : React.null}
        </span>
      </span>
    )

    <ReactAria.Combobox.Item
      {...props}
      dataSlot="combobox-item"
      className={cn(
        "cn-combobox-item cn-combobox-item-aria relative flex w-full cursor-default items-center outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0",
        props.className,
      )}
    >
      {renderedChildren}
    </ReactAria.Combobox.Item>
  }
}

module Group = {
  @react.componentWithProps(ReactAria.Combobox.Group.props)
  let make = (props: ReactAria.Combobox.Group.props<'item>) => {
    <ReactAria.Combobox.Group
      {...props}
      dataSlot="combobox-group"
      className={cn("cn-combobox-group", props.className)}
    />
  }
}

module Label = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <ReactAria.Combobox.GroupLabel
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?children
      dataSlot="combobox-label"
      className={cn("cn-combobox-label", className)}
    />
}

module Collection = {
  @react.component
  let make = (~children) =>
    <ReactAria.Combobox.Collection>
      {children}
    </ReactAria.Combobox.Collection>
}

module Empty = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?) =>
    <div
      ?id
      ?style
      ?children
      dataSlot="combobox-empty"
      className={cn(
        "cn-combobox-empty",
        className,
      )}
    />
}

module Separator = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?) =>
    <ReactAria.Separator
      ?id
      ?style
      ?children
      dataSlot="combobox-separator"
      className={cn("cn-combobox-separator", className)}
    />
}

module Chips = {
  @react.componentWithProps(ReactAria.Types.BaseUIComponentProps.t)
  let make = (props: ReactAria.Types.BaseUIComponentProps.t) =>
    <ReactAria.Combobox.Chips
      {...props}
      dataSlot="combobox-chips"
      className={cn(
        "cn-combobox-chips",
        props.className,
      )}
    />
}

type chipProps = {
  ...ReactAria.Types.BaseUIComponentProps.t,
  showRemove?: bool,
}

let comboboxChipToBase: chipProps => ReactAria.Types.BaseUIComponentProps.t = %raw(`({ showRemove, ...rest }) => rest`)

module Chip = {
  @react.componentWithProps(chipProps)
  let make = (props: chipProps) => {
    let showRemove = props.showRemove->Option.getOr(true)
    <ReactAria.Combobox.Chip
      {...props->comboboxChipToBase}
      dataSlot="combobox-chip"
      className={cn(
        "cn-combobox-chip has-disabled:pointer-events-none has-disabled:cursor-not-allowed has-disabled:opacity-50",
        props.className,
      )}
    >
      {props.children->Option.getOr(React.null)}
      {showRemove
        ? <Button
            variant=Ghost
            size=IconXs
            slot="remove"
            className="cn-combobox-chip-remove"
            dataSlot="combobox-chip-remove"
          >
            <Icons.X className="cn-combobox-chip-indicator-icon pointer-events-none" />
          </Button>
        : React.null}
    </ReactAria.Combobox.Chip>
  }
}

module ChipsInput = {
  @react.componentWithProps(Aria.Input.props)
  let make = (props: Aria.Input.props) =>
    <Aria.Input
      {...props}
      dataSlot="combobox-chip-input"
      className={cn("cn-combobox-chip-input min-w-16 flex-1 outline-none", props.className)}
    />
}

let useAnchor = () => React.useRef(null)->ReactDOM.Ref.domRef
