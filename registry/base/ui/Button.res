@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Variant = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("secondary") Secondary
    | @as("destructive") Destructive
    | @as("outline") Outline
    | @as("ghost") Ghost
    | @as("link") Link
}

module Size = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("xs") Xs
    | @as("sm") Sm
    | @as("lg") Lg
    | @as("icon") Icon
    | @as("icon-xs") IconXs
    | @as("icon-sm") IconSm
    | @as("icon-lg") IconLg
}

let buttonVariantClass = (~variant: Variant.t) =>
  switch variant {
  | Outline => "border-border bg-background hover:bg-muted hover:text-foreground dark:bg-input/30 dark:border-input dark:hover:bg-input/50 aria-expanded:bg-muted aria-expanded:text-foreground"
  | Secondary => "bg-secondary text-secondary-foreground hover:bg-secondary/80 aria-expanded:bg-secondary aria-expanded:text-secondary-foreground"
  | Ghost => "hover:bg-muted hover:text-foreground dark:hover:bg-muted/50 aria-expanded:bg-muted aria-expanded:text-foreground"
  | Destructive => "bg-destructive/10 hover:bg-destructive/20 focus-visible:ring-destructive/20 dark:focus-visible:ring-destructive/40 dark:bg-destructive/20 text-destructive focus-visible:border-destructive/40 dark:hover:bg-destructive/30"
  | Link => "text-primary underline-offset-4 hover:underline"
  | Default => "bg-primary text-primary-foreground [a]:hover:bg-primary/80"
  }

let buttonSizeClass = (~size: Size.t) =>
  switch size {
  | Xs => "h-6 gap-1 rounded-[min(var(--radius-md),10px)] px-2 text-xs in-data-[slot=button-group]:rounded-lg has-data-[icon=inline-end]:pr-1.5 has-data-[icon=inline-start]:pl-1.5 [&_svg:not([class*='size-'])]:size-3"
  | Sm => "h-7 gap-1 rounded-[min(var(--radius-md),12px)] px-2.5 text-[0.8rem] in-data-[slot=button-group]:rounded-lg has-data-[icon=inline-end]:pr-1.5 has-data-[icon=inline-start]:pl-1.5 [&_svg:not([class*='size-'])]:size-3.5"
  | Lg => "h-9 gap-1.5 rounded-lg px-2.5 has-data-[icon=inline-end]:pr-3 has-data-[icon=inline-start]:pl-3"
  | Icon => "size-8 rounded-lg"
  | IconXs => "size-6 rounded-[min(var(--radius-md),10px)] in-data-[slot=button-group]:rounded-lg [&_svg:not([class*='size-'])]:size-3"
  | IconSm => "size-7 rounded-[min(var(--radius-md),12px)] in-data-[slot=button-group]:rounded-lg"
  | IconLg => "size-9 rounded-lg"
  | Default => "h-8 gap-1.5 rounded-lg px-2.5 has-data-[icon=inline-end]:pr-2 has-data-[icon=inline-start]:pl-2"
  }

let buttonVariants = (~variant=Variant.Default, ~size=Size.Default) => {
  `focus-visible:border-ring focus-visible:ring-ring/50 aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive dark:aria-invalid:border-destructive/50 border border-transparent bg-clip-padding text-sm font-medium focus-visible:ring-3 aria-invalid:ring-3 [&_svg:not([class*='size-'])]:size-4 inline-flex items-center justify-center whitespace-nowrap transition-all disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none shrink-0 [&_svg]:shrink-0 outline-none group/button select-none 
  ${buttonVariantClass(~variant)} ${buttonSizeClass(~size)}`
}

@react.component
let make = (
  ~className=?,
  ~variant=Variant.Default,
  ~size=Size.Default,
  ~id=?,
  ~tabIndex=?,
  ~nativeButton=?,
  ~disabled=?,
  ~style=?,
  ~children=?,
  ~onClick=?,
  ~onKeyDown=?,
  ~onBlur=?,
  ~onFocus=?,
  ~onMouseEnter=?,
  ~onMouseLeave=?,
  ~ref=?,
  ~type_=?,
  ~ariaLabel=?,
  ~ariaDisabled=?,
  ~dataSidebar=?,
  ~dataDay=?,
  ~dataSelectedSingle=?,
  ~dataRangeStart=?,
  ~dataRangeEnd=?,
  ~dataRangeMiddle=?,
  ~render=?,
  ~dataSlot=?,
  ~ariaControls=?,
  ~ariaExpanded=?,
  ~ariaHaspopup=?,
  ~dataState=?,
  ~dataEmpty=?,
  ~dir=?,
  ~suppressHydrationWarning=?,
) => {
  <BaseUi.Button
    dataSlot={dataSlot->Option.getOr("button")}
    className={cn(buttonVariants(~variant, ~size), className)}
    ?id
    ?ariaControls
    ?ariaExpanded
    ?ariaHaspopup
    ?dataState
    tabIndex=?{switch tabIndex {
    | Some(v) => Some(v)
    | None => Some(0)
    }}
    ?nativeButton
    ?disabled
    ?style
    ?children
    ?onClick
    ?onKeyDown
    ?onBlur
    ?onFocus
    ?onMouseEnter
    ?onMouseLeave
    ?ref
    type_=?{switch (type_, nativeButton, render) {
    | (None, None, None) => Some("button")
    | _ => type_
    }}
    ?ariaLabel
    ?ariaDisabled
    ?dataSidebar
    ?dataDay
    ?dataSelectedSingle
    ?dataRangeStart
    ?dataRangeEnd
    ?dataRangeMiddle
    ?dataEmpty
    ?dir
    ?render
    ?suppressHydrationWarning
  />
}
