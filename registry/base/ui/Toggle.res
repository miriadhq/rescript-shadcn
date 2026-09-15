@@directive("'use client'")

@module("cn")
external cn: (string, option<string>) => string = "cn"

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

type props<'value> = {...BaseUi.Toggle.props<'value>, variant?: Variant.t, size?: Size.t}

let toBaseUiProps: props<'value> => BaseUi.Toggle.props<
  'value,
> = %raw(`({className, variant, size, ...props}) => props`)

@react.componentWithProps(props)
let make = (props: props<'value>) => {
  let variant = props.variant->Option.getOr(Variant.Default)
  let size = props.size->Option.getOr(Size.Default)
  <BaseUi.Toggle
    {...toBaseUiProps(props)}
    dataSlot="toggle"
    className={cn(toggleVariants(~variant, ~size), props.className)}
  />
}
