@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Variant = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("icon") Icon
}

let emptyMediaVariantClass = (~variant: Variant.t) =>
  switch variant {
  | Icon => "cn-empty-media-icon"
  | Default => "cn-empty-media-default"
  }

let emptyMediaVariants = (~variant=Variant.Default) => {
  let base = "cn-empty-media flex shrink-0 items-center justify-center [&_svg]:pointer-events-none [&_svg]:shrink-0"
  `${base} ${emptyMediaVariantClass(~variant)}`
}

@react.componentWithProps(ReactAria.Types.DomProps.t)
let make = (props: ReactAria.Types.DomProps.t) => {
  <div
    {...props}
    dataSlot={props.dataSlot->Option.getOr("empty")}
    className={cn(
      "cn-empty flex w-full min-w-0 flex-1 flex-col items-center justify-center text-center text-balance",
      props.className,
    )}
  />
}

module Header = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("empty-header")}
      className={cn("cn-empty-header flex max-w-sm flex-col items-center", props.className)}
    />
}

module Media = {
  type props = {variant?: Variant.t, ...ReactAria.Types.DomProps.t}
  let domProps: props => ReactAria.Types.DomProps.t = %raw(`({variant, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let variant = props.variant->Option.getOr(Default)
    <div
      {...props->domProps}
      dataSlot={props.dataSlot->Option.getOr("empty-icon")}
      dataVariant={(variant :> string)}
      className={cn(emptyMediaVariants(~variant), props.className)}
    />
  }
}

module Title = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("empty-title")}
      className={cn("cn-empty-title cn-font-heading", props.className)}
    />
}

module Description = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("empty-description")}
      className={cn(
        "cn-empty-description text-muted-foreground [&>a]:underline [&>a]:underline-offset-4 [&>a:hover]:text-primary",
        props.className,
      )}
    />
}

module Content = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("empty-content")}
      className={cn(
        "cn-empty-content flex w-full max-w-sm min-w-0 flex-col items-center text-balance",
        props.className,
      )}
    />
}
