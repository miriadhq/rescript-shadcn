@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@module("cn")
external cn: (string, option<string>) => string = "cn"

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

type props = {variant?: Variant.t, ...BaseUi.Types.BaseUIComponentProps.t}
type renderState = {slot: string, variant: Variant.t}
let toDomProps: props => BaseUi.Types.DomProps.t = %raw(`({variant, className, render, ...props}) => props`)

@react.componentWithProps(props)
let make = (props: props) => {
  let variant = props.variant->Option.getOr(Default)
  BaseUi.Render.use({
    defaultTagName: "div",
    props: BaseUi.Render.mergeProps(
      {
        className: cn(
          `cn-marker group/marker relative flex w-full items-center ${variantClass(~variant)}`,
          props.className,
        ),
      },
      toDomProps(props),
    ),
    render: ?props.render,
    state: {slot: "marker", variant},
  })
}

module Icon = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <span
      {...props}
      dataSlot={props.dataSlot->Option.getOr("marker-icon")}
      ariaHidden={props.ariaHidden->Option.getOr(true)}
      className={cn("cn-marker-icon shrink-0", props.className)}
    />
}

module Content = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <span
      {...props}
      dataSlot={props.dataSlot->Option.getOr("marker-content")}
      className={cn("cn-marker-content min-w-0 wrap-break-word", props.className)}
    />
}
