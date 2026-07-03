@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Variant = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("outline") Outline
}

module Size = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("sm") Sm
    | @as("lg") Lg
}

let toggleVariantClass = (~variant: Variant.t) =>
  switch variant {
  | Outline => "cn-toggle-variant-outline"
  | Default => "cn-toggle-variant-default"
  }

let toggleSizeClass = (~size: Size.t) =>
  switch size {
  | Sm => "cn-toggle-size-sm"
  | Lg => "cn-toggle-size-lg"
  | Default => "cn-toggle-size-default"
  }

let toggleVariants = (~variant=Variant.Default, ~size=Size.Default) => {
  let base = "cn-toggle group/toggle hover:bg-muted inline-flex items-center justify-center whitespace-nowrap outline-none focus-visible:ring-[3px] disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0"
  `${base} ${toggleVariantClass(~variant)} ${toggleSizeClass(~size)}`
}

@react.component
let make = (
  ~className=?,
  ~children=?,
  ~id=?,
  ~name=?,
  ~dir=?,
  ~disabled=?,
  ~pressed=?,
  ~defaultPressed=?,
  ~onPressedChange=?,
  ~onClick=?,
  ~onKeyDown=?,
  ~tabIndex=0,
  ~ariaLabel=?,
  ~type_=?,
  ~render=?,
  ~variant=Variant.Default,
  ~size=Size.Default,
) => {
  <BaseUi.Toggle
    ?id
    ?name
    ?dir
    ?disabled
    ?pressed
    ?defaultPressed
    ?onPressedChange
    ?onClick
    ?onKeyDown
    tabIndex
    ?ariaLabel
    ?type_
    ?render
    ?children
    dataSlot="toggle"
    className={cn(toggleVariants(~variant, ~size), className)}
  />
}
