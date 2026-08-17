@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@@directive("'use client'")

open BaseUi.Types

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

let make = BaseUi.Combobox.Root.make

module Multiple = {
  type props = {...BaseUi.Combobox.Root.Multiple.props<string>}

  @react.componentWithProps(props)
  let make = ({...BaseUi.Combobox.Root.Multiple.props<string> as props}) =>
    <BaseUi.Combobox.Root.Multiple {...props} multiple=True />
}

module Value = {
  type props<'value> = {...BaseUi.Combobox.Value.props<'value>}

  @react.componentWithProps(props)
  let make = ({...BaseUi.Combobox.Value.props as props}) =>
    <BaseUi.Combobox.Value {...props} dataSlot="combobox-value" />
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
    <BaseUi.Combobox.Trigger
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
    </BaseUi.Combobox.Trigger>
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
    <BaseUi.Combobox.Clear
      dataSlot="combobox-clear"
      render={<InputGroup.Button
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
      />}
    >
      <Icons.X className="cn-combobox-clear-icon pointer-events-none" />
    </BaseUi.Combobox.Clear>
}

module Input = {
  type props = {
    showTrigger?: bool,
    showClear?: bool,
    ...BaseUi.Combobox.Input.props,
  }
  @warning("-112") @react.componentWithProps(props)
  let make = ({
    ?className,
    ?children,
    ?disabled,
    ?showTrigger,
    ?showClear,
    ...BaseUi.Combobox.Input.props as props,
  }) => {
    let disabled = disabled->Option.getOr(false)
    let showTrigger = showTrigger->Option.getOr(true)
    let showClear = showClear->Option.getOr(false)
    <InputGroup className={cn("cn-combobox-input w-auto", className)}>
      <BaseUi.Combobox.Input {...props} render={<InputGroup.Input disabled />} />
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
      {children->Option.getOr(React.null)}
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
    <BaseUi.Combobox.Portal>
      <BaseUi.Combobox.Positioner
        side
        sideOffset={Const(sideOffset)}
        align
        alignOffset={Const(alignOffset)}
        ?anchor
        className="isolate z-50"
      >
        <BaseUi.Combobox.Popup
          ?id
          ?style
          ?onClick
          ?onKeyDown
          ?dir
          ?dataLang
          dataSlot="combobox-content"
          dataChips={anchor->Option.isSome}
          className={cn(
            "cn-combobox-content cn-combobox-content-logical cn-menu-target cn-menu-translucent group/combobox-content relative max-h-(--available-height) w-(--anchor-width) max-w-(--available-width) min-w-[calc(var(--anchor-width)+--spacing(7))] origin-(--transform-origin) overflow-hidden rounded-lg bg-popover text-popover-foreground shadow-md ring-1 ring-foreground/10 duration-100 data-[chips=true]:min-w-(--anchor-width) data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 *:data-[slot=input-group]:m-1 *:data-[slot=input-group]:mb-0 *:data-[slot=input-group]:h-8 *:data-[slot=input-group]:border-input/30 *:data-[slot=input-group]:bg-input/30 *:data-[slot=input-group]:shadow-none data-open:animate-in data-open:fade-in-0 data-open:zoom-in-95 data-closed:animate-out data-closed:fade-out-0 data-closed:zoom-out-95",
            className,
          )}
          ?children
        />
      </BaseUi.Combobox.Positioner>
    </BaseUi.Combobox.Portal>
  }
}

module List = {
  type props<'item> = {...BaseUi.Combobox.List.props<'item>}

  @react.componentWithProps(props)
  let make = ({...BaseUi.Combobox.List.props as props}) =>
    <BaseUi.Combobox.List
      {...props}
      dataSlot="combobox-list"
      className={cn("cn-combobox-list overscroll-contain", props.className)}
    />
}

module Item = {
  type props<'value> = {...BaseUi.Combobox.Item.props<'value>}

  @react.componentWithProps(props)
  let make = ({...BaseUi.Combobox.Item.props as props}) =>
    <BaseUi.Combobox.Item
      {...props}
      dataSlot="combobox-item"
      className={cn(
        "cn-combobox-item relative flex w-full cursor-default items-center outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0",
        props.className,
      )}
    >
      {props.children->Option.getOr(React.null)}
      <BaseUi.Combobox.ItemIndicator render={<span className="cn-combobox-item-indicator" />}>
        <Icons.Check className="cn-combobox-item-indicator-icon pointer-events-none" />
      </BaseUi.Combobox.ItemIndicator>
    </BaseUi.Combobox.Item>
}

module Group = {
  type props<'value> = {...BaseUi.Combobox.Group.props<'value>}

  @react.componentWithProps(props)
  let make = ({...BaseUi.Combobox.Group.props as props}) =>
    <BaseUi.Combobox.Group
      {...props} dataSlot="combobox-group" className={cn("cn-combobox-group", props.className)}
    />
}

module Label = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <BaseUi.Combobox.GroupLabel
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
  type props<'item> = {...BaseUi.Combobox.Collection.props<'item>}

  @react.componentWithProps(props)
  let make = ({...BaseUi.Combobox.Collection.props as props}) =>
    <BaseUi.Combobox.Collection {...props} dataSlot="combobox-collection" />
}

module Empty = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?) =>
    <BaseUi.Combobox.Empty
      ?id ?style ?children dataSlot="combobox-empty" className={cn("cn-combobox-empty", className)}
    />
}

module Separator = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?) =>
    <BaseUi.Combobox.Separator
      ?id
      ?style
      ?children
      dataSlot="combobox-separator"
      className={cn("cn-combobox-separator", className)}
    />
}

module Chips = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Combobox.Chips
      {...props} dataSlot="combobox-chips" className={cn("cn-combobox-chips", props.className)}
    />
}

module Chip = {
  type props = {
    ...BaseUi.Types.BaseUIComponentProps.t,
    showRemove?: bool,
  }

  @react.componentWithProps(props)
  let make = ({?showRemove, ...BaseUi.Types.BaseUIComponentProps.t as props}) => {
    let showRemove = showRemove->Option.getOr(true)
    <BaseUi.Combobox.Chip
      {...props}
      dataSlot="combobox-chip"
      className={cn(
        "cn-combobox-chip has-disabled:pointer-events-none has-disabled:cursor-not-allowed has-disabled:opacity-50",
        props.className,
      )}
    >
      {props.children->Option.getOr(React.null)}
      {showRemove
        ? <BaseUi.Combobox.ChipRemove
            render={<Button variant=Ghost size=IconXs />}
            className="cn-combobox-chip-remove"
            dataSlot="combobox-chip-remove"
          >
            <Icons.X className="cn-combobox-chip-indicator-icon pointer-events-none" />
          </BaseUi.Combobox.ChipRemove>
        : React.null}
    </BaseUi.Combobox.Chip>
  }
}

module ChipsInput = {
  @react.componentWithProps(BaseUi.Combobox.Input.props)
  let make = (props: BaseUi.Combobox.Input.props) =>
    <BaseUi.Combobox.Input
      {...props}
      dataSlot="combobox-chip-input"
      className={cn("cn-combobox-chip-input min-w-16 flex-1 outline-none", props.className)}
    />
}

let useAnchor = () => React.useRef(null)->ReactDOM.Ref.domRef
