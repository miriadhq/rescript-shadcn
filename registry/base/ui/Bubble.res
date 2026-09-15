@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@module("cn")
external cn: (string, option<string>) => string = "cn"

module Variant = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("secondary") Secondary
    | @as("muted") Muted
    | @as("tinted") Tinted
    | @as("outline") Outline
    | @as("ghost") Ghost
    | @as("destructive") Destructive
}

module Align = {
  @unboxed
  type t =
    | @as("start") Start
    | @as("end") End
}

module Side = {
  @unboxed
  type t =
    | @as("top") Top
    | @as("bottom") Bottom
}

let variantClass = (~variant: Variant.t) =>
  switch variant {
  | Default => "cn-bubble-variant-default"
  | Secondary => "cn-bubble-variant-secondary"
  | Muted => "cn-bubble-variant-muted"
  | Tinted => "cn-bubble-variant-tinted"
  | Outline => "cn-bubble-variant-outline"
  | Ghost => "cn-bubble-variant-ghost"
  | Destructive => "cn-bubble-variant-destructive"
  }

type props = {
  variant?: Variant.t,
  align?: Align.t,
  ...BaseUi.Types.DomProps.t,
}
let domProps: props => BaseUi.Types.DomProps.t = %raw(`({variant, align, ...props}) => props`)

@react.componentWithProps(props)
let make = (props: props) => {
  let variant = props.variant->Option.getOr(Default)
  let align = props.align->Option.getOr(Start)
  <div
    {...props->domProps}
    dataSlot={props.dataSlot->Option.getOr("bubble")}
    dataVariant={props.dataVariant->Option.getOr((variant :> string))}
    dataAlign={props.dataAlign->Option.getOr((align :> string))}
    className={cn(
      `cn-bubble group/bubble relative flex w-fit min-w-0 flex-col ${variantClass(~variant)}`,
      props.className,
    )}
  />
}

module Group = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("bubble-group")}
      className={cn("cn-bubble-group flex min-w-0 flex-col", props.className)}
    />
}

module Content = {
  type renderState = {slot: string}
  let toDomProps: BaseUi.Types.BaseUIComponentProps.t => BaseUi.Types.DomProps.t = %raw(`({className, render, ...props}) => props`)
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    BaseUi.Render.use({
      defaultTagName: "div",
      props: BaseUi.Render.mergeProps(
        {
          className: cn(
            "cn-bubble-content w-fit max-w-full min-w-0 overflow-hidden wrap-break-word [button]:text-left [button,a]:transition-colors",
            props.className,
          ),
        },
        toDomProps(props),
      ),
      render: ?props.render,
      state: {slot: "bubble-content"},
    })
}

module Reactions = {
  let sideClass = (~side: Side.t) =>
    switch side {
    | Top => "cn-bubble-reactions-side-top"
    | Bottom => "cn-bubble-reactions-side-bottom"
    }

  let alignClass = (~align: Align.t) =>
    switch align {
    | Start => "cn-bubble-reactions-align-start"
    | End => "cn-bubble-reactions-align-end"
    }

  type props = {side?: Side.t, align?: Align.t, ...BaseUi.Types.DomProps.t}
  let domProps: props => BaseUi.Types.DomProps.t = %raw(`({side, align, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let side = props.side->Option.getOr(Bottom)
    let align = props.align->Option.getOr(End)
    <div
      {...props->domProps}
      dataSlot={props.dataSlot->Option.getOr("bubble-reactions")}
      dataSide={props.dataSide->Option.getOr((side :> string))}
      dataAlign={props.dataAlign->Option.getOr((align :> string))}
      className={cn(
        `cn-bubble-reactions absolute z-10 flex w-fit items-center justify-center ${sideClass(
            ~side,
          )} ${alignClass(~align)}`,
        props.className,
      )}
    />
  }
}
