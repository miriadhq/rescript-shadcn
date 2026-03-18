@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@@directive("'use client'")

open BaseUi.Types

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

let make = BaseUi.Combobox.Root.make

module Multiple = {
  @react.componentWithProps(BaseUi.Combobox.Root.Multiple.props)
  let make = (props: BaseUi.Combobox.Root.Multiple.props<'value, 'checked>) =>
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
      className={cn("[&_svg:not([class*='size-'])]:size-4", className)}
    >
      {children}
      <Icons.ChevronDown className="text-muted-foreground pointer-events-none size-4" />
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
        className
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
      <Icons.X className="pointer-events-none" />
    </BaseUi.Combobox.Clear>
}

module Input = {
  type inputProps<'value, 'checked> = {
    showTrigger?: bool,
    showClear?: bool,
    ...BaseUi.Input.props<'value, 'checked>,
  }
  let toBaseUiProps: inputProps<'value, 'checked> => BaseUi.Types.props<
    'selected,
    'checked,
  > = %raw(`({className, children, disabled, showTrigger, showClear,...rest}) => rest`)
  @react.componentWithProps(inputProps)
  let make = (props: inputProps<'value, 'checked>) => {
    let disabled = props.disabled->Option.getOr(false)
    let showTrigger = props.showTrigger->Option.getOr(true)
    let showClear = props.showClear->Option.getOr(false)
    let baseUiProps = toBaseUiProps(props)
    <InputGroup className={cn("w-auto", props.className)}>
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
        side sideOffset align alignOffset ?anchor className="isolate z-50"
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
            "cn-menu-target cn-menu-translucent group/combobox-content relative max-h-(--available-height) w-(--anchor-width) max-w-(--available-width) min-w-[calc(var(--anchor-width)+--spacing(7))] origin-(--transform-origin) overflow-hidden rounded-lg bg-popover text-popover-foreground shadow-md ring-1 ring-foreground/10 duration-100 data-[chips=true]:min-w-(--anchor-width) data-[side=bottom]:slide-in-from-top-2 data-[side=inline-end]:slide-in-from-left-2 data-[side=inline-start]:slide-in-from-right-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 *:data-[slot=input-group]:m-1 *:data-[slot=input-group]:mb-0 *:data-[slot=input-group]:h-8 *:data-[slot=input-group]:border-input/30 *:data-[slot=input-group]:bg-input/30 *:data-[slot=input-group]:shadow-none data-open:animate-in data-open:fade-in-0 data-open:zoom-in-95 data-closed:animate-out data-closed:fade-out-0 data-closed:zoom-out-95",
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
        "no-scrollbar max-h-[min(calc(--spacing(72)---spacing(9)),calc(var(--available-height)---spacing(9)))] scroll-py-1 overflow-y-auto overscroll-contain p-1 data-empty:p-0",
        className,
      )}
    >
      {children}
    </BaseUi.Combobox.List>
}

module Item = {
  @react.componentWithProps(BaseUi.Types.props)
  let make = (props: BaseUi.Types.props<'value, 'checked>) =>
    <BaseUi.Combobox.Item
      {...props}
      dataSlot="combobox-item"
      className={cn(
        "relative flex w-full cursor-default items-center gap-2 rounded-md py-1 pr-8 pl-1.5 text-sm outline-hidden select-none data-highlighted:bg-accent data-highlighted:text-accent-foreground not-data-[variant=destructive]:data-highlighted:**:text-accent-foreground data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4",
        props.className,
      )}
    >
      {props.children->Option.getOr(React.null)}
      <BaseUi.Combobox.ItemIndicator
        render={<span
          className="pointer-events-none absolute right-2 flex size-4 items-center justify-center"
        />}
      >
        <Icons.Check className="pointer-events-none" />
      </BaseUi.Combobox.ItemIndicator>
    </BaseUi.Combobox.Item>
}

module Group = {
  @react.component
  let make = (~children, ~items=?, ~className=?, ~style=?, ~render=?) =>
    <BaseUi.Combobox.Group ?items ?style ?render dataSlot="combobox-group" ?className>
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
      className={cn("text-muted-foreground px-2 py-1.5 text-xs", className)}
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
        "text-muted-foreground hidden w-full justify-center py-2 text-center text-sm group-data-empty/combobox-content:flex",
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
      className={cn("bg-border -mx-1 my-1 h-px", className)}
    />
}

module Chips = {
  @react.componentWithProps(BaseUi.Types.props)
  let make = (props: BaseUi.Types.props<'value, 'checked>) =>
    <BaseUi.Combobox.Chips
      {...props}
      dataSlot="combobox-chips"
      className={cn(
        "flex min-h-8 flex-wrap items-center gap-1 rounded-lg border border-input bg-transparent bg-clip-padding px-2.5 py-1 text-sm transition-colors focus-within:border-ring focus-within:ring-3 focus-within:ring-ring/50 has-aria-invalid:border-destructive has-aria-invalid:ring-3 has-aria-invalid:ring-destructive/20 has-data-[slot=combobox-chip]:px-1 dark:bg-input/30 dark:has-aria-invalid:border-destructive/50 dark:has-aria-invalid:ring-destructive/40",
        props.className,
      )}
    />
}

module Chip = {
  @react.componentWithProps(BaseUi.Types.props)
  let make = (props: BaseUi.Types.props<'value, 'checked>) => {
    let showRemove = props.showRemove->Option.getOr(true)
    <BaseUi.Combobox.Chip
      {...props}
      dataSlot="combobox-chip"
      className={cn(
        "bg-muted text-foreground flex h-[calc(--spacing(5.25))] w-fit items-center justify-center gap-1 rounded-sm px-1.5 text-xs font-medium whitespace-nowrap has-disabled:pointer-events-none has-disabled:cursor-not-allowed has-disabled:opacity-50 has-data-[slot=combobox-chip-remove]:pr-0",
        props.className,
      )}
    >
      {props.children->Option.getOr(React.null)}
      {showRemove
        ? <BaseUi.Combobox.ChipRemove
            render={<Button variant=Ghost size=IconXs />}
            className="-ml-1 opacity-50 hover:opacity-100"
            dataSlot="combobox-chip-remove"
          >
            <Icons.X className="pointer-events-none" />
          </BaseUi.Combobox.ChipRemove>
        : React.null}
    </BaseUi.Combobox.Chip>
  }
}

module ChipsInput = {
  @react.componentWithProps(BaseUi.Types.props)
  let make = (props: BaseUi.Types.props<'value, 'checked>) =>
    <BaseUi.Combobox.Input
      {...props}
      dataSlot="combobox-chip-input"
      className={cn("min-w-16 flex-1 outline-none", props.className)}
    />
}

let useAnchor = () => React.useRef(null)->ReactDOM.Ref.domRef
