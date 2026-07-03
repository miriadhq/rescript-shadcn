@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@@directive("'use client'")

open BaseUi.Types

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

let make = BaseUi.Combobox.Root.make

module Multiple = {
  @react.componentWithProps(BaseUi.Combobox.Root.Multiple.props)
  let make = (props: BaseUi.Combobox.Root.Multiple.props<'item>) =>
    <BaseUi.Combobox.Root.Multiple {...props} multiple=True />
}

module Value = {
  @react.componentWithProps(BaseUi.Combobox.Value.props)
  let make = (props: BaseUi.Combobox.Value.props<'value>) =>
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
  type inputProps = {
    showTrigger?: bool,
    showClear?: bool,
    ...BaseUi.Combobox.Input.props,
  }
  let toBaseUiProps: inputProps => BaseUi.Combobox.Input.props = %raw(`({className, children, disabled, showTrigger, showClear,...rest}) => rest`)
  @react.componentWithProps(inputProps)
  let make = (props: inputProps) => {
    let disabled = props.disabled->Option.getOr(false)
    let showTrigger = props.showTrigger->Option.getOr(true)
    let showClear = props.showClear->Option.getOr(false)
    let baseUiProps = toBaseUiProps(props)
    <InputGroup className={cn("cn-combobox-input w-auto", props.className)}>
      <BaseUi.Combobox.Input {...baseUiProps} render={<InputGroup.Input disabled />} />
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
  @react.component
  let make = (~className=?, ~children, ~style=?, ~render=?) =>
    <BaseUi.Combobox.List
      ?style
      ?render
      dataSlot="combobox-list"
      className={cn(
        "cn-combobox-list overscroll-contain",
        className,
      )}
    >
      {children}
    </BaseUi.Combobox.List>
}

module Item = {
  @react.componentWithProps(BaseUi.Combobox.Item.props)
  let make = (props: BaseUi.Combobox.Item.props<'value>) =>
    <BaseUi.Combobox.Item
      {...props}
      dataSlot="combobox-item"
      className={cn(
        "cn-combobox-item relative flex w-full cursor-default items-center outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0",
        props.className,
      )}
    >
      {props.children->Option.getOr(React.null)}
      <BaseUi.Combobox.ItemIndicator
        render={<span
          className="cn-combobox-item-indicator"
        />}
      >
        <Icons.Check className="cn-combobox-item-indicator-icon pointer-events-none" />
      </BaseUi.Combobox.ItemIndicator>
    </BaseUi.Combobox.Item>
}

module Group = {
  @react.component
  let make = (~children, ~items=?, ~className=?, ~style=?, ~render=?) =>
    <BaseUi.Combobox.Group
      ?items
      ?style
      ?render
      dataSlot="combobox-group"
      className={cn("cn-combobox-group", className)}
    >
      {children}
    </BaseUi.Combobox.Group>
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
  @react.component
  let make = (~children) =>
    <BaseUi.Combobox.Collection dataSlot="combobox-collection">
      {children}
    </BaseUi.Combobox.Collection>
}

module Empty = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?) =>
    <BaseUi.Combobox.Empty
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
      {...props}
      dataSlot="combobox-chips"
      className={cn(
        "cn-combobox-chips",
        props.className,
      )}
    />
}

type chipProps = {
  ...BaseUi.Types.BaseUIComponentProps.t,
  showRemove?: bool,
}

let comboboxChipToBase: chipProps => BaseUi.Types.BaseUIComponentProps.t = %raw(`({ showRemove, ...rest }) => rest`)

module Chip = {
  @react.componentWithProps(chipProps)
  let make = (props: chipProps) => {
    let showRemove = props.showRemove->Option.getOr(true)
    <BaseUi.Combobox.Chip
      {...props->comboboxChipToBase}
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
