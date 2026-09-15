@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@module("cn")
external cn: (string, string, option<string>) => string = "cn"

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

type state = {slot: string, variant: Variant.t}

type props = {
  ...BaseUi.Types.BaseUIComponentProps.t,
  variant?: Variant.t,
}

let toDomProps: props => BaseUi.Types.DomProps.t = %raw(`({className, render, variant, ...props}) => props`)

@react.componentWithProps(props)
let make = (props: props) => {
  let variant = props.variant->Option.getOr(Variant.Default)

  BaseUi.Render.use({
    defaultTagName: "span",
    props: BaseUi.Render.mergeProps(
      {className: cn(base, badgeVariantClass(~variant), props.className)},
      toDomProps(props),
    ),
    render: ?props.render,
    state: {slot: "badge", variant},
  })
}
