@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, string, option<string>) => string = "twMerge"

@unboxed
type dataIcon =
  | @as("inline-start") InlineStart
  | @as("inline-end") InlineEnd

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

let badgeVariantClass = (~variant: Variant.t) =>
  switch variant {
  | Default => "cn-badge-variant-default"
  | Secondary => "cn-badge-variant-secondary"
  | Destructive => "cn-badge-variant-destructive"
  | Outline => "cn-badge-variant-outline"
  | Ghost => "cn-badge-variant-ghost"
  | Link => "cn-badge-variant-link"
  }

let base = "cn-badge group/badge inline-flex w-fit shrink-0 items-center justify-center overflow-hidden whitespace-nowrap focus-visible:border-ring focus-visible:ring-[3px] focus-visible:ring-ring/50 aria-invalid:border-destructive aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 [&>svg]:pointer-events-none"

@react.component
let make = (
  ~className=?,
  ~children=?,
  ~variant=Variant.Default,
  ~id=?,
  ~onClick=?,
  ~onKeyDown=?,
  ~style=?,
  ~render=?,
  ~dataIcon: option<dataIcon>=?,
) => {
  let props: ReactAria.Types.BaseUIComponentProps.t = {
    ?id,
    ?style,
    ?onClick,
    ?onKeyDown,
    ?children,
    dataIcon: ?{(dataIcon :> option<string>)},
    dataSlot: "badge",
    dataVariant: (variant :> string),
    className: cn(base, badgeVariantClass(~variant), className),
  }
  Render.use({defaultTagName: "span", props, ?render})
}
