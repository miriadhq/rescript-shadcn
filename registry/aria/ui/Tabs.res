@@directive("'use client'")

open ReactAria.Types

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Variant = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("line") Line
}

let tabsListVariants = (~variant=Variant.Default) => {
  let base = "cn-tabs-list group/tabs-list text-muted-foreground inline-flex w-fit items-center justify-center group-data-vertical/tabs:h-fit group-data-vertical/tabs:flex-col"
  let variantClass = switch variant {
  | Line => "cn-tabs-list-variant-line gap-1 bg-transparent"
  | Default => "cn-tabs-list-variant-default bg-muted"
  }
  `${base} ${variantClass}`
}

@react.component
let make = (
  ~className=?,
  ~children=?,
  ~id=?,
  ~value=?,
  ~defaultValue=?,
  ~onValueChange=?,
  ~orientation=Orientation.Horizontal,
  ~disabled=?,
  ~dir=?,
  ~onClick=?,
  ~onKeyDown=?,
  ~style=?,
) => {
  let onSelectionChange = onValueChange->Option.map(callback => value =>
    callback(value, %raw(`undefined`))
  )
  <ReactAria.Tabs
    ?id
    selectedKey=?value
    defaultSelectedKey=?defaultValue
    ?onSelectionChange
    isDisabled=?disabled
    ?dir
    ?onClick
    ?onKeyDown
    ?style
    ?children
    orientation
    dataSlot="tabs"
    className={cn("cn-tabs group/tabs flex data-horizontal:flex-col", className)}
  />
}

module List = {
  @react.component
  let make = (
    ~className=?,
    ~variant=Variant.Default,
    ~children=?,
    ~id=?,
    ~dir=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
  ) => {
    <ReactAria.Tabs.List
      ?id
      ?style
      ?dir
      ?onClick
      ?onKeyDown
      ?children
      dataSlot="tabs-list"
      dataVariant={(variant :> string)}
      className={cn(tabsListVariants(~variant), className)}
    />
  }
}

module Trigger = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~value,
    ~disabled=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~ariaLabel=?,
    ~style=?,
  ) =>
    <ReactAria.Tabs.Tab
      id=value
      isDisabled=?disabled
      ?onClick
      ?onKeyDown
      ?ariaLabel
      ?style
      ?children
      dataSlot="tabs-trigger"
      className={cn(
        "cn-tabs-trigger cn-tabs-trigger-aria focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:outline-ring text-foreground/60 hover:text-foreground dark:text-muted-foreground dark:hover:text-foreground relative inline-flex h-[calc(100%-1px)] flex-1 items-center justify-center gap-1.5 rounded-md border border-transparent px-1.5 py-0.5 font-medium whitespace-nowrap transition-all group-data-vertical/tabs:w-full group-data-vertical/tabs:justify-start focus-visible:ring-[3px] focus-visible:outline-1 disabled:pointer-events-none disabled:opacity-50 aria-disabled:pointer-events-none aria-disabled:opacity-50 group-data-[variant=default]/tabs-list:data-active:shadow-sm group-data-[variant=line]/tabs-list:data-active:shadow-none [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4 group-data-[variant=line]/tabs-list:bg-transparent group-data-[variant=line]/tabs-list:data-active:bg-transparent dark:group-data-[variant=line]/tabs-list:data-active:border-transparent dark:group-data-[variant=line]/tabs-list:data-active:bg-transparent data-active:bg-background dark:data-active:text-foreground dark:data-active:border-input dark:data-active:bg-input/30 data-active:text-foreground after:bg-foreground after:absolute after:opacity-0 after:transition-opacity group-data-horizontal/tabs:after:inset-x-0 group-data-horizontal/tabs:after:bottom-[-5px] group-data-horizontal/tabs:after:h-0.5 group-data-vertical/tabs:after:inset-y-0 group-data-vertical/tabs:after:-right-1 group-data-vertical/tabs:after:w-0.5 group-data-[variant=line]/tabs-list:data-active:after:opacity-100",
        className,
      )}
    />
}

module Content = {
  @react.component
  let make = (~className=?, ~children=?, ~value, ~onClick=?, ~onKeyDown=?, ~style=?) =>
    <ReactAria.Tabs.Panel
      id=value
      ?onClick
      ?onKeyDown
      ?style
      ?children
      dataSlot="tabs-content"
      className={cn("cn-tabs-content flex-1 outline-none", className)}
    />
}
