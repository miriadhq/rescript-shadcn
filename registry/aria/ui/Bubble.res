@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

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
  ...ReactAria.Types.DomProps.t,
}
@react.componentWithProps(props)
let make = ({?variant, ?align, ...ReactAria.Types.DomProps.t as props}) => {
  let variant = variant->Option.getOr(Default)
  let align = align->Option.getOr(Start)
  <div
    {...props}
    dataSlot={props.dataSlot->Option.getOr("bubble")}
    dataVariant={(variant :> string)}
    dataAlign={(align :> string)}
    className={cn(
      `cn-bubble group/bubble relative flex w-fit min-w-0 flex-col ${variantClass(~variant)}`,
      props.className,
    )}
  />
}

module Group = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("bubble-group")}
      className={cn("cn-bubble-group flex min-w-0 flex-col", props.className)}
    />
}

module Content = {
  type props = {render?: ReactAria.Types.DomProps.t => React.element, ...ReactAria.Types.DomProps.t}

  @react.componentWithProps(props)
  let make = ({?render, ...ReactAria.Types.DomProps.t as props}) => {
    let renderProps = {
      ...props,
      dataSlot: props.dataSlot->Option.getOr("bubble-content"),
      className: cn(
        "cn-bubble-content w-fit max-w-full min-w-0 overflow-hidden wrap-break-word [button]:text-left [button,a]:transition-colors",
        props.className,
      ),
    }
    switch render {
    | Some(render) => render(renderProps)
    | None => <div {...renderProps} />
    }
  }
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

  type props = {side?: Side.t, align?: Align.t, ...ReactAria.Types.DomProps.t}

  @react.componentWithProps(props)
  let make = ({?side, ?align, ...ReactAria.Types.DomProps.t as props}) => {
    let side = side->Option.getOr(Bottom)
    let align = align->Option.getOr(End)
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("bubble-reactions")}
      dataSide={(side :> string)}
      dataAlign={(align :> string)}
      className={cn(
        `cn-bubble-reactions absolute z-10 flex w-fit items-center justify-center ${sideClass(
            ~side,
          )} ${alignClass(~align)}`,
        props.className,
      )}
    />
  }
}
