@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

open BaseUi.Types

@module("cn")
external cn: (string, option<string>) => string = "cn"

module Variant = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("outline") Outline
    | @as("muted") Muted
}

module Size = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("sm") Sm
    | @as("xs") Xs
}

let itemVariants = (~variant=Variant.Default, ~size=Size.Default) => {
  let base = "cn-item w-full group/item focus-visible:border-ring focus-visible:ring-ring/50 flex items-center flex-wrap outline-none transition-colors duration-100 focus-visible:ring-[3px] [a]:transition-colors"
  let variantClass = switch variant {
  | Outline => "cn-item-variant-outline"
  | Muted => "cn-item-variant-muted"
  | Default => "cn-item-variant-default"
  }
  let sizeClass = switch size {
  | Sm => "cn-item-size-sm"
  | Xs => "cn-item-size-xs"
  | Default => "cn-item-size-default"
  }
  `${base} ${variantClass} ${sizeClass}`
}

type state = {
  slot: string,
  variant: Variant.t,
  size: Size.t,
}

type props = {
  variant?: Variant.t,
  size?: Size.t,
  ...BaseUi.Types.BaseUIComponentProps.t,
}

let toDomProps: props => BaseUi.Types.DomProps.t = %raw(`({className, render, variant, size, ...props}) => props`)

@react.componentWithProps(props)
let make = (props: props) => {
  let variant = props.variant->Option.getOr(Variant.Default)
  let size = props.size->Option.getOr(Size.Default)

  BaseUi.Render.use({
    defaultTagName: "div",
    render: ?props.render,
    props: BaseUi.Render.mergeProps(
      {className: cn(itemVariants(~variant, ~size), props.className)},
      toDomProps(props),
    ),
    state: {
      slot: "item",
      variant,
      size,
    },
  })
}

module Media = {
  module Variant = {
    @unboxed
    type t =
      | @as("default") Default
      | @as("icon") Icon
      | @as("image") Image
  }

  let itemMediaVariants = (~variant=Variant.Default) => {
    let base = "cn-item-media flex shrink-0 items-center justify-center [&_svg]:pointer-events-none"
    let variantClass = switch variant {
    | Icon => "cn-item-media-variant-icon"
    | Image => "cn-item-media-variant-image"
    | Default => "cn-item-media-variant-default"
    }
    `${base} ${variantClass}`
  }

  type props = {
    ...BaseUi.Types.DomProps.t,
    variant?: Variant.t,
  }

  let toBaseUiProps: props => BaseUi.Types.DomProps.t = %raw(`({variant, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let variant = props.variant->Option.getOr(Variant.Default)
    <div
      {...props->toBaseUiProps}
      dataSlot={props.dataSlot->Option.getOr("item-media")}
      dataVariant={props.dataVariant->Option.getOr((variant :> string))}
      className={cn(itemMediaVariants(~variant), props.className)}
    />
  }
}

module Content = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("item-content")}
      className={cn(
        "cn-item-content flex flex-1 flex-col [&+[data-slot=item-content]]:flex-none",
        props.className,
      )}
    />
}

module Actions = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("item-actions")}
      className={cn("cn-item-actions flex items-center", props.className)}
    />
}

module Group = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) => {
    let role = props.role->Option.getOr("list")
    <div
      {...props}
      role
      dataSlot={props.dataSlot->Option.getOr("item-group")}
      className={cn("cn-item-group group/item-group flex w-full flex-col", props.className)}
    />
  }
}

module Separator = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Separator
      {...props}
      dataSlot={props.dataSlot->Option.getOr("item-separator")}
      orientation={props.orientation->Option.getOr(Orientation.Horizontal)}
      className={cn("cn-item-separator", props.className)}
    />
}

module Title = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("item-title")}
      className={cn("cn-item-title line-clamp-1 flex w-fit items-center", props.className)}
    />
}

module Description = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <p
      {...props}
      dataSlot={props.dataSlot->Option.getOr("item-description")}
      className={cn(
        "cn-item-description [&>a:hover]:text-primary line-clamp-2 font-normal [&>a]:underline [&>a]:underline-offset-4",
        props.className,
      )}
    />
}

module Header = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("item-header")}
      className={cn("cn-item-header flex basis-full items-center justify-between", props.className)}
    />
}

module Footer = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("item-footer")}
      className={cn("cn-item-footer flex basis-full items-center justify-between", props.className)}
    />
}
