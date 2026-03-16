@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@@directive("'use client'")

open BaseUi.Types

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@react.component
let make = (
  ~children=?,
  ~open_=?,
  ~defaultOpen=?,
  ~onOpenChange=?,
  ~onOpenChangeComplete=?,
  ~value=?,
  ~defaultValue=?,
  ~onValueChange=?,
  ~items=?,
  ~itemToStringLabel=?,
  ~itemToStringValue=?,
  ~isItemEqualToValue=?,
  ~onItemHighlighted=?,
  ~inputValue=?,
  ~onInputValueChange=?,
  ~multiple=?,
  ~name=?,
  ~required=?,
  ~disabled=?,
  ~readOnly=?,
) =>
  <BaseUi.Combobox.Root
    ?children
    ?open_
    ?defaultOpen
    ?onOpenChange
    ?onOpenChangeComplete
    ?value
    ?defaultValue
    ?onValueChange
    ?items
    ?itemToStringLabel
    ?itemToStringValue
    ?isItemEqualToValue
    ?onItemHighlighted
    ?inputValue
    ?onInputValueChange
    ?multiple
    ?name
    ?required
    ?disabled
    ?readOnly
  />

module Value = {
  @react.component
  let make = (~className="", ~children=?, ~id=?, ~style=?, ~placeholder=?) =>
    <BaseUi.Combobox.Value ?id ?style ?placeholder ?children dataSlot="combobox-value" className />
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
    ~render=?,
    ~nativeButton=?,
    ~type_=?,
    ~ariaLabel=?,
  ) =>
    <BaseUi.Combobox.Clear
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?disabled
      ?nativeButton
      ?type_
      ?ariaLabel
      dataSlot="combobox-clear"
      render={switch render {
      | Some(value) => value
      | None => <Button variant=Ghost size=IconXs className />
      }}
    >
      <Icons.X className="pointer-events-none" />
    </BaseUi.Combobox.Clear>
}

module Input = {
  @react.component
  let make = (
    ~className=?,
    ~children=React.null,
    ~id=?,
    ~style=?,
    ~name=?,
    ~placeholder=?,
    ~disabled=false,
    ~ariaLabel=?,
    ~ariaRoledescription=?,
    ~ariaInvalid=?,
    ~showTrigger=true,
    ~showClear=false,
  ) => {
    <InputGroup className={cn("w-auto", className)}>
      <BaseUi.Combobox.Input
        render={<InputGroup.Input disabled />}
        ?className
        ?id
        ?style
        ?name
        ?placeholder
        disabled
        ?ariaLabel
        ?ariaRoledescription
        ?ariaInvalid
      />
      <InputGroup.Addon align=InlineEnd>
        {showTrigger
          ? <InputGroup.Button
              size=IconXs
              variant=Ghost
              render={<Trigger />}
              dataSlot="input-group-button"
              className="group-has-data-[slot=combobox-clear]/input-group:hidden data-pressed:bg-transparent"
              disabled={disabled}
            />
          : React.null}
        {showClear ? <Clear disabled /> : React.null}
      </InputGroup.Addon>
      {children}
    </InputGroup>
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
    ~sideOffset=6.,
    ~align=Align.Start,
    ~alignOffset=0.,
    ~anchor=?,
    ~positionMethod=?,
    ~dir=?,
    ~dataLang=?,
  ) => {
    <BaseUi.Combobox.Portal>
      <BaseUi.Combobox.Positioner
        side sideOffset align alignOffset ?positionMethod ?anchor className="isolate z-50"
      >
        <BaseUi.Combobox.Popup
          ?id
          ?style
          ?onClick
          ?onKeyDown
          ?anchor
          ?dir
          ?dataLang
          dataSlot="combobox-content"
          dataChips={anchor->Option.isSome}
          className={cn(
            "bg-popover text-popover-foreground data-open:animate-in data-closed:animate-out data-closed:fade-out-0 data-open:fade-in-0 data-closed:zoom-out-95 data-open:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 ring-foreground/10 *:data-[slot=input-group]:bg-input/30 *:data-[slot=input-group]:border-input/30 data-[side=inline-start]:slide-in-from-right-2 data-[side=inline-end]:slide-in-from-left-2 cn-menu-target group/combobox-content relative max-h-(--available-height) w-(--anchor-width) max-w-(--available-width) min-w-[calc(var(--anchor-width)+--spacing(7))] origin-(--transform-origin) overflow-hidden rounded-lg shadow-md ring-1 duration-100 data-[chips=true]:min-w-(--anchor-width) *:data-[slot=input-group]:m-1 *:data-[slot=input-group]:mb-0 *:data-[slot=input-group]:h-8 *:data-[slot=input-group]:shadow-none",
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
  let make = (~className=?, ~children, ~nativeButton=?, ~style=?, ~render=?) =>
    <BaseUi.Combobox.List
      ?style
      ?nativeButton
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
  @react.component
  let make = (
    ~className=?,
    ~children=React.null,
    ~id=?,
    ~style=?,
    ~value=?,
    ~label=?,
    ~disabled=?,
    ~onClick=?,
    ~onKeyDown=?,
  ) =>
    <BaseUi.Combobox.Item
      ?id
      ?style
      ?value
      ?label
      ?disabled
      ?onClick
      ?onKeyDown
      dataSlot="combobox-item"
      className={cn(
        "data-highlighted:bg-accent data-highlighted:text-accent-foreground not-data-[variant=destructive]:data-highlighted:**:text-accent-foreground relative flex w-full cursor-default items-center gap-2 rounded-md py-1 pr-8 pl-1.5 text-sm outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4",
        className,
      )}
    >
      {children}
      <BaseUi.Combobox.ItemIndicator
        render={<span
          className="pointer-events-none absolute right-2 flex size-4 items-center justify-center"
        >
          <Icons.Check className="pointer-events-none" />
        </span>}
      />
    </BaseUi.Combobox.Item>
}

module Group = {
  @react.component
  let make = (~className="", ~children=?, ~id=?, ~style=?, ~label=?) =>
    <BaseUi.Combobox.Group ?id ?style ?label ?children dataSlot="combobox-group" className />
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
  let make = (~children=?, ~items=?) =>
    <BaseUi.Combobox.Collection ?children ?items dataSlot="combobox-collection" />
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
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <BaseUi.Combobox.Chips
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?children
      dataSlot="combobox-chips"
      className={cn(
        "dark:bg-input/30 border-input focus-within:border-ring focus-within:ring-ring/50 has-aria-invalid:ring-destructive/20 dark:has-aria-invalid:ring-destructive/40 has-aria-invalid:border-destructive dark:has-aria-invalid:border-destructive/50 flex min-h-8 flex-wrap items-center gap-1 rounded-lg border bg-transparent bg-clip-padding px-2.5 py-1 text-sm transition-colors focus-within:ring-3 has-aria-invalid:ring-3 has-data-[slot=combobox-chip]:px-1",
        className,
      )}
    />
}

module Chip = {
  @react.component
  let make = (
    ~className=?,
    ~children=React.null,
    ~showRemove=true,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~disabled=?,
  ) =>
    <BaseUi.Combobox.Chip
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?disabled
      dataSlot="combobox-chip"
      className={cn(
        "bg-muted text-foreground flex h-[calc(--spacing(5.25))] w-fit items-center justify-center gap-1 rounded-sm px-1.5 text-xs font-medium whitespace-nowrap has-disabled:pointer-events-none has-disabled:cursor-not-allowed has-disabled:opacity-50 has-data-[slot=combobox-chip-remove]:pr-0",
        className,
      )}
    >
      {children}
      {showRemove
        ? <BaseUi.Combobox.ChipRemove
            render={<Button variant=Ghost size=IconXs>
              <Icons.X className="pointer-events-none" />
            </Button>}
            className="-ml-1 opacity-50 hover:opacity-100"
            dataSlot="combobox-chip-remove"
          />
        : React.null}
    </BaseUi.Combobox.Chip>
}

module ChipsInput = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~id=?,
    ~style=?,
    ~name=?,
    ~placeholder=?,
    ~disabled=?,
    ~ariaLabel=?,
    ~ariaRoledescription=?,
  ) =>
    <BaseUi.Combobox.Input
      ?id
      ?style
      ?name
      ?placeholder
      ?disabled
      ?ariaLabel
      ?ariaRoledescription
      ?children
      dataSlot="combobox-chip-input"
      className={cn("min-w-16 flex-1 outline-none", className)}
    />
}

let useComboboxAnchor = () => React.useRef(null)
