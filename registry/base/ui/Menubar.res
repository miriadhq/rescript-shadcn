@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Variant = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("destructive") Destructive
}

@react.componentWithProps(BaseUi.Menubar.props)
let make = (props: BaseUi.Menubar.props) =>
  <BaseUi.Menubar
    {...props}
    dataSlot="menubar"
    className={cn("flex h-8 items-center gap-0.5 rounded-lg border p-[3px]", props.className)}
  />

module Menu = {
  @react.component
  let make = (
    ~children=?,
    ~open_=?,
    ~defaultOpen=?,
    ~onOpenChange=?,
    ~onOpenChangeComplete=?,
    ~modal=?,
  ) =>
    <DropdownMenu
      ?children
      ?open_
      ?defaultOpen
      ?onOpenChange
      ?onOpenChangeComplete
      ?modal
      dataSlot="menubar-menu"
    />
}

module Group = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?) =>
    <BaseUi.Menu.Group ?id ?style ?children dataSlot="menubar-group" ?className />
}

module Portal = {
  @react.component
  let make = (~children=?, ~container=?) =>
    <BaseUi.Menu.Portal ?children ?container dataSlot="menubar-portal" />
}

module Trigger = {
  @react.componentWithProps(BaseUi.Menu.Trigger.props)
  let make = (props: BaseUi.Menu.Trigger.props) => {
    <DropdownMenu.Trigger
      {...props}
      dataSlot="menubar-trigger"
      className={cn(
        "flex items-center rounded-sm px-1.5 py-[2px] text-sm font-medium outline-hidden select-none hover:bg-muted aria-expanded:bg-muted",
        props.className,
      )}
    />
  }
}

module Content = {
  @react.componentWithProps(DropdownMenu.Content.contentProps)
  let make = (props: DropdownMenu.Content.contentProps) => {
    let align = props.align->Option.getOr(BaseUi.Types.Align.Start)
    let alignOffset = props.alignOffset->Option.getOr(-4.)
    let sideOffset = props.sideOffset->Option.getOr(8.)
    <DropdownMenu.Content
      {...props}
      dataSlot="menubar-content"
      align
      alignOffset
      sideOffset
      className={cn(
        "cn-menu-target cn-menu-translucent min-w-36 rounded-lg bg-popover p-1 text-popover-foreground shadow-md ring-1 ring-foreground/10 duration-100 data-[side=bottom]:slide-in-from-top-2 data-[side=inline-end]:slide-in-from-left-2 data-[side=inline-start]:slide-in-from-right-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 data-open:animate-in data-open:fade-in-0 data-open:zoom-in-95",
        props.className,
      )}
    />
  }
}

module Item = {
  @react.component
  let make = (
    ~inset=?,
    ~variant=Variant.Default,
    ~className=?,
    ~children=?,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~disabled=?,
    ~closeOnClick=?,
  ) => {
    <DropdownMenu.Item
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?disabled
      ?closeOnClick
      ?children
      dataSlot="menubar-item"
      ?inset
      variant={(variant :> DropdownMenu.Variant.t)}
      className={cn(
        "group/menubar-item gap-1.5 rounded-md px-1.5 py-1 text-sm focus:bg-accent focus:text-accent-foreground not-data-[variant=destructive]:focus:**:text-accent-foreground data-inset:pl-7 data-[variant=destructive]:text-destructive data-[variant=destructive]:focus:bg-destructive/10 data-[variant=destructive]:focus:text-destructive dark:data-[variant=destructive]:focus:bg-destructive/20 data-disabled:opacity-50 [&_svg:not([class*='size-'])]:size-4 data-[variant=destructive]:*:[svg]:text-destructive!",
        className,
      )}
    />
  }
}

module CheckboxItem = {
  @react.component
  let make = (
    ~className=?,
    ~children=React.null,
    ~id=?,
    ~style=?,
    ~checked=?,
    ~defaultChecked=?,
    ~onCheckedChange=?,
    ~disabled=?,
    ~closeOnClick=?,
    ~dataInset=?,
    ~onClick=?,
    ~onKeyDown=?,
  ) =>
    <BaseUi.Menu.CheckboxItem
      ?id
      ?style
      ?checked
      ?defaultChecked
      ?onCheckedChange
      ?disabled
      ?closeOnClick
      ?dataInset
      ?onClick
      ?onKeyDown
      dataSlot="menubar-checkbox-item"
      className={cn(
        "relative flex cursor-default items-center gap-1.5 rounded-md py-1 pr-1.5 pl-7 text-sm outline-hidden select-none focus:bg-accent focus:text-accent-foreground focus:**:text-accent-foreground data-inset:pl-7 data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0",
        className,
      )}
    >
      <span
        className="pointer-events-none absolute left-1.5 flex size-4 items-center justify-center [&_svg:not([class*='size-'])]:size-4"
      >
        <BaseUi.Menu.CheckboxItemIndicator>
          <Icons.Check />
        </BaseUi.Menu.CheckboxItemIndicator>
      </span>
      {children}
    </BaseUi.Menu.CheckboxItem>
}

module RadioGroup = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~value=?, ~onValueChange=?) =>
    <DropdownMenu.RadioGroup
      dataSlot="menubar-radio-group" ?id ?style ?value ?onValueChange ?children ?className
    />
}

module RadioItem = {
  @react.component
  let make = (
    ~className=?,
    ~children=React.null,
    ~inset=?,
    ~id=?,
    ~style=?,
    ~value,
    ~disabled=?,
    ~closeOnClick=?,
    ~onClick=?,
    ~onKeyDown=?,
  ) =>
    <BaseUi.Menu.RadioItem
      ?id
      ?style
      value
      ?disabled
      ?closeOnClick
      dataInset=?inset
      ?onClick
      ?onKeyDown
      dataSlot="menubar-radio-item"
      className={cn(
        "relative flex cursor-default items-center gap-1.5 rounded-md py-1 pr-1.5 pl-7 text-sm outline-hidden select-none focus:bg-accent focus:text-accent-foreground focus:**:text-accent-foreground data-inset:pl-7 data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4",
        className,
      )}
    >
      <span
        className="pointer-events-none absolute left-1.5 flex size-4 items-center justify-center [&_svg:not([class*='size-'])]:size-4"
      >
        <BaseUi.Menu.RadioItemIndicator>
          <Icons.Check />
        </BaseUi.Menu.RadioItemIndicator>
      </span>
      {children}
    </BaseUi.Menu.RadioItem>
}

module Label = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?, ~inset=?) =>
    <DropdownMenu.Label
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?inset
      ?children
      dataSlot="menubar-label"
      className={cn("px-1.5 py-1 text-sm font-medium data-inset:pl-7", className)}
    />
}

module Separator = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?) =>
    <DropdownMenu.Separator
      ?id
      ?style
      ?children
      dataSlot="menubar-separator"
      className={cn("-mx-1 my-1 h-px bg-border", className)}
    />
}

module Shortcut = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~dataSlot="menubar-shortcut",
  ) =>
    <DropdownMenu.Shortcut
      ?id
      ?style
      ?onClick
      ?onKeyDown
      dataSlot
      className={cn(
        "ml-auto text-xs tracking-widest text-muted-foreground group-focus/menubar-item:text-accent-foreground",
        className,
      )}
      ?children
    />
}

module Sub = {
  @react.component
  let make = (~className=?, ~children=?, ~open_=?, ~defaultOpen=?, ~onOpenChange=?) =>
    <DropdownMenu.Sub
      dataSlot="menubar-sub" ?className ?children ?open_ ?defaultOpen ?onOpenChange
    />
}

module SubTrigger = {
  type subTriggerProps = {
    inset?: bool,
    ...BaseUi.Types.BaseUIComponentProps.t,
  }
  let toBaseUiProps: subTriggerProps => BaseUi.Types.BaseUIComponentProps.t = %raw(`({inset, ...props}) => props`)

  @react.componentWithProps(subTriggerProps)
  let make = (props: subTriggerProps) => {
    let baseUiProps = toBaseUiProps(props)
    <DropdownMenu.SubTrigger
      {...baseUiProps}
      dataSlot="menubar-sub-trigger"
      dataInset=?props.inset
      className={cn(
        "gap-1.5 rounded-md px-1.5 py-1 text-sm focus:bg-accent focus:text-accent-foreground data-inset:pl-7 data-open:bg-accent data-open:text-accent-foreground [&_svg:not([class*='size-'])]:size-4",
        props.className,
      )}
    />
  }
}

module SubContent = {
  @react.componentWithProps(DropdownMenu.Content.contentProps)
  let make = (props: DropdownMenu.Content.contentProps) =>
    <DropdownMenu.SubContent
      {...props}
      dataSlot="menubar-sub-content"
      className={cn(
        "cn-menu-target cn-menu-translucent min-w-32 rounded-lg bg-popover p-1 text-popover-foreground shadow-lg ring-1 ring-foreground/10 duration-100 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 data-open:animate-in data-open:fade-in-0 data-open:zoom-in-95 data-closed:animate-out data-closed:fade-out-0 data-closed:zoom-out-95",
        props.className,
      )}
    />
}
