@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@module("tailwind-merge")
external cn3: (string, string, option<string>) => string = "twMerge"

module Variant = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("destructive") Destructive
}

let alertVariantClass = (~variant: Variant.t) =>
  switch variant {
  | Default => "cn-alert-variant-default"
  | Destructive => "cn-alert-variant-destructive"
  }

let base = "cn-alert group/alert relative w-full"

type props = {variant?: Variant.t, ...ReactAria.Types.DomProps.t}
let domProps: props => ReactAria.Types.DomProps.t = %raw(`({variant, ...props}) => props`)

@react.componentWithProps(props)
let make = (props: props) => {
  let variant = props.variant->Option.getOr(Default)
  <div
    {...props->domProps}
    role={props.role->Option.getOr("alert")}
    dataSlot={props.dataSlot->Option.getOr("alert")}
    className={cn3(base, alertVariantClass(~variant), props.className)}
  />
}

module Title = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("alert-title")}
      className={cn(
        "cn-alert-title [&_a]:underline [&_a]:underline-offset-3 [&_a]:hover:text-foreground",
        props.className,
      )}
    />
}

module Description = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("alert-description")}
      className={cn(
        "cn-alert-description [&_a]:underline [&_a]:underline-offset-3 [&_a]:hover:text-foreground",
        props.className,
      )}
    />
}

module Action = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("alert-action")}
      className={cn("cn-alert-action", props.className)}
    />
}
