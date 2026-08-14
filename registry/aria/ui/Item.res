@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

open ReactAria.Types

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

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

type props = {
  ...ReactAria.Button.Link.props,
  variant?: Variant.t,
  size?: Size.t,
}

let linkProps: props => ReactAria.Button.Link.props = %raw(`({variant, size, ...props}) => props`)

let divProps: props => ReactAria.Common.elementProps = %raw(`({
  variant,
  size,
  href,
  target,
  rel,
  download,
  isDisabled,
  render,
  ...props
}) => props`)

@module("react")
external createElement: (string, ReactAria.Common.elementProps) => React.element = "createElement"

@react.componentWithProps(props)
let make = (props: props) => {
  let variant = props.variant->Option.getOr(Variant.Default)
  let size = props.size->Option.getOr(Size.Default)
  let className = cn(itemVariants(~variant, ~size), props.className)
  switch props.href {
  | Some(_) =>
    <ReactAria.Button.Link
      {...props->linkProps}
      dataSlot="item"
      dataVariant={(variant :> string)}
      dataSize={(size :> string)}
      className
    />
  | None =>
    createElement("div", {
      ...props->divProps,
      dataSlot: "item",
      dataVariant: (variant :> string),
      dataSize: (size :> string),
      className,
    })
  }
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

  type props = {variant?: Variant.t, ...DomProps.t}
  let domProps: props => DomProps.t = %raw(`({variant, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let variant = props.variant->Option.getOr(Variant.Default)
    <div
      {...props->domProps}
      dataSlot="item-media"
      dataVariant={(variant :> string)}
      className={cn(itemMediaVariants(~variant), props.className)}
    />
  }
}

module Content = {
  @react.componentWithProps(DomProps.t)
  let make = (props: DomProps.t) =>
    <div
      {...props}
      dataSlot="item-content"
      className={cn(
        "cn-item-content flex flex-1 flex-col [&+[data-slot=item-content]]:flex-none",
        props.className,
      )}
    />
}

module Actions = {
  @react.componentWithProps(DomProps.t)
  let make = (props: DomProps.t) =>
    <div
      {...props}
      dataSlot="item-actions"
      className={cn("cn-item-actions flex items-center", props.className)}
    />
}

module Group = {
  @react.componentWithProps(DomProps.t)
  let make = (props: DomProps.t) =>
    <div
      {...props}
      role="list"
      dataSlot="item-group"
      className={cn(
        "cn-item-group group/item-group flex w-full flex-col",
        props.className,
      )}
    />
}

module Separator = {
  @react.componentWithProps(ReactAria.Separator.props)
  let make = (props: ReactAria.Separator.props) =>
    <ReactAria.Separator
      {...props}
      dataSlot="item-separator"
      orientation={Orientation.Horizontal}
      className={cn("cn-item-separator", props.className)}
    />
}

module Title = {
  @react.componentWithProps(DomProps.t)
  let make = (props: DomProps.t) =>
    <div
      {...props}
      dataSlot="item-title"
      className={cn(
        "cn-item-title line-clamp-1 flex w-fit items-center",
        props.className,
      )}
    />
}

module Description = {
  @react.componentWithProps(DomProps.t)
  let make = (props: DomProps.t) =>
    <p
      {...props}
      dataSlot="item-description"
      className={cn(
        "cn-item-description [&>a:hover]:text-primary line-clamp-2 font-normal [&>a]:underline [&>a]:underline-offset-4",
        props.className,
      )}
    />
}

module Header = {
  @react.componentWithProps(DomProps.t)
  let make = (props: DomProps.t) =>
    <div
      {...props}
      dataSlot="item-header"
      className={cn(
        "cn-item-header flex basis-full items-center justify-between",
        props.className,
      )}
    />
}

module Footer = {
  @react.componentWithProps(DomProps.t)
  let make = (props: DomProps.t) =>
    <div
      {...props}
      dataSlot="item-footer"
      className={cn(
        "cn-item-footer flex basis-full items-center justify-between",
        props.className,
      )}
    />
}
