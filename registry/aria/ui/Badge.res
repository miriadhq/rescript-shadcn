@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, string, option<string>) => string = "twMerge"

@module("react")
external createElement: (string, ReactAria.Types.DomProps.t) => React.element = "createElement"

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

let variantClass = variant =>
  switch variant {
  | Variant.Default => "cn-badge-variant-default"
  | Secondary => "cn-badge-variant-secondary"
  | Destructive => "cn-badge-variant-destructive"
  | Outline => "cn-badge-variant-outline"
  | Ghost => "cn-badge-variant-ghost"
  | Link => "cn-badge-variant-link"
  }

let badgeClass = "cn-badge group/badge inline-flex w-fit shrink-0 items-center justify-center overflow-hidden whitespace-nowrap focus-visible:border-ring focus-visible:ring-[3px] focus-visible:ring-ring/50 aria-invalid:border-destructive aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 [&>svg]:pointer-events-none"

type props = {
  ...ReactAria.Types.DomProps.t,
  variant?: Variant.t,
  render?: ReactAria.Types.DomProps.t => React.element,
}

@react.componentWithProps(props)
let make = ({?variant, ?render, ...ReactAria.Types.DomProps.t as props}) => {
  let variant = variant->Option.getOr(Variant.Default)
  let domProps = {
    ...props,
    dataSlot: "badge",
    dataVariant: (variant :> string),
    className: cn(badgeClass, variant->variantClass, props.className),
  }
  switch render {
  | Some(render) => render(domProps)
  | None => createElement("span", domProps)
  }
}
