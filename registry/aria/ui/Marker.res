@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Variant = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("separator") Separator
    | @as("border") Border
}

let variantClass = (~variant: Variant.t) =>
  switch variant {
  | Default => "cn-marker-variant-default"
  | Separator => "cn-marker-variant-separator"
  | Border => "cn-marker-variant-border"
  }

@react.component
let make = (
  ~className=?,
  ~variant=Variant.Default,
  ~children=?,
  ~role=?,
  ~ariaLabel=?,
  ~id=?,
  ~style=?,
  ~onClick=?,
  ~onKeyDown=?,
) =>
  <div
    ?id
    ?style
    ?onClick
    ?onKeyDown
    ?role
    ?ariaLabel
    ?children
    dataSlot="marker"
    dataVariant={(variant :> string)}
    className={cn(
      `cn-marker group/marker relative flex w-full items-center ${variantClass(~variant)}`,
      className,
    )}
  />

module Icon = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <span
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?children
      dataSlot="marker-icon"
      ariaHidden=true
      className={cn("cn-marker-icon shrink-0", className)}
    />
}

module Content = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <span
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?children
      dataSlot="marker-content"
      className={cn("cn-marker-content min-w-0 wrap-break-word", className)}
    />
}
