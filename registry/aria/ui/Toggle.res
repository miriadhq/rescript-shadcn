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
  let base = "cn-toggle cn-toggle-aria group/toggle inline-flex items-center justify-center whitespace-nowrap outline-none hover:bg-muted focus-visible:ring-[3px] disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0"
  `${base} ${toggleVariantClass(~variant)} ${toggleSizeClass(~size)}`
}

type props = {
  variant?: Variant.t,
  size?: Size.t,
  ...ReactAria.ToggleButton.props,
}

let toggleProps: props => ReactAria.ToggleButton.props = %raw(`({variant, size, ...props}) => props`)

@react.componentWithProps(props)
let make = (props: props) => {
  let variant = props.variant->Option.getOr(Default)
  let size = props.size->Option.getOr(Default)
  <ReactAria.ToggleButton
    {...props->toggleProps}
    dataSlot={props.dataSlot->Option.getOr("toggle")}
    className={cn(toggleVariants(~variant, ~size), props.className)}
  />
}
