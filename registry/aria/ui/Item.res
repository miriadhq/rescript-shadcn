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

type state = {
  slot: string,
  variant: Variant.t,
  size: Size.t,
}

@react.component
let make = (
  ~className=?,
  ~variant=Variant.Default,
  ~size=Size.Default,
  ~children=?,
  ~id=?,
  ~dir=?,
  ~style=?,
  ~onClick=?,
  ~render=?,
) => {
  Render.use({
    defaultTagName: "div",
    props: {
      className: cn(itemVariants(~variant, ~size), className),
      ?id,
      ?dir,
      ?style,
      ?children,
      ?onClick,
    },
    ?render,
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

  @react.component
  let make = (
    ~className=?,
    ~variant=Variant.Default,
    ~children=?,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
  ) => {
    <div
      ?id
      ?style
      ?children
      ?onClick
      ?onKeyDown
      dataSlot="item-media"
      dataVariant={(variant :> string)}
      className={cn(itemMediaVariants(~variant), className)}
    />
  }
}

module Content = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <div
      ?id
      ?style
      ?children
      ?onClick
      ?onKeyDown
      dataSlot="item-content"
      className={cn(
        "cn-item-content flex flex-1 flex-col [&+[data-slot=item-content]]:flex-none",
        className,
      )}
    />
}

module Actions = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <div
      ?id
      ?style
      ?children
      ?onClick
      ?onKeyDown
      dataSlot="item-actions"
      className={cn("cn-item-actions flex items-center", className)}
    />
}

module Group = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <div
      ?id
      ?style
      ?children
      ?onClick
      ?onKeyDown
      role="list"
      dataSlot="item-group"
      className={cn(
        "cn-item-group group/item-group flex w-full flex-col",
        className,
      )}
    />
}

module Separator = {
  @react.component
  let make = (~className=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <ReactAria.Separator
      ?id
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="item-separator"
      orientation={Orientation.Horizontal}
      className={cn("cn-item-separator", className)}
    />
}

module Title = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <div
      ?id
      ?style
      ?children
      ?onClick
      ?onKeyDown
      dataSlot="item-title"
      className={cn(
        "cn-item-title line-clamp-1 flex w-fit items-center",
        className,
      )}
    />
}

module Description = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <p
      ?id
      ?style
      ?children
      ?onClick
      ?onKeyDown
      dataSlot="item-description"
      className={cn(
        "cn-item-description [&>a:hover]:text-primary line-clamp-2 font-normal [&>a]:underline [&>a]:underline-offset-4",
        className,
      )}
    />
}

module Header = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <div
      ?id
      ?style
      ?children
      ?onClick
      ?onKeyDown
      dataSlot="item-header"
      className={cn("cn-item-header flex basis-full items-center justify-between", className)}
    />
}

module Footer = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <div
      ?id
      ?style
      ?children
      ?onClick
      ?onKeyDown
      dataSlot="item-footer"
      className={cn("cn-item-footer flex basis-full items-center justify-between", className)}
    />
}
