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

type props = {
  variant?: Variant.t,
  render?: ReactAria.Types.DomProps.t => React.element,
  ...ReactAria.Types.DomProps.t,
}
@react.componentWithProps(props)
let make = ({?variant, ?render, ...ReactAria.Types.DomProps.t as props}) => {
  let variant = variant->Option.getOr(Default)
  let renderProps = {
    ...props,
    dataSlot: props.dataSlot->Option.getOr("marker"),
    dataVariant: (variant :> string),
    className: cn(
      `cn-marker group/marker relative flex w-full items-center ${variantClass(~variant)}`,
      props.className,
    ),
  }
  switch render {
  | Some(render) => render(renderProps)
  | None => <div {...renderProps} />
  }
}

module Icon = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <span
      {...props}
      dataSlot={props.dataSlot->Option.getOr("marker-icon")}
      ariaHidden={props.ariaHidden->Option.getOr(true)}
      className={cn("cn-marker-icon shrink-0", props.className)}
    />
}

module Content = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <span
      {...props}
      dataSlot={props.dataSlot->Option.getOr("marker-content")}
      className={cn("cn-marker-content min-w-0 wrap-break-word", props.className)}
    />
}
