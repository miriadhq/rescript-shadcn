@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

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

@react.component
let make = (~className=?, ~children=?, ~id=?, ~dir=?, ~style=?, ~onClick=?, ~onKeyDown=?) => {
  <div
    ?id
    ?children
    ?style
    ?dir
    ?onClick
    ?onKeyDown
    dataSlot="empty"
    className={cn(
      "cn-empty flex w-full min-w-0 flex-1 flex-col items-center justify-center text-center text-balance",
      className,
    )}
  />
}

module Header = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <div
      ?id
      ?children
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="empty-header"
      className={cn("cn-empty-header flex max-w-sm flex-col items-center", className)}
    />
}

module Media = {
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
      ?children
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="empty-icon"
      dataVariant={(variant :> string)}
      className={cn(emptyMediaVariants(~variant), className)}
    />
  }
}

module Title = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <div
      ?id
      ?children
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="empty-title"
      className={cn("cn-empty-title cn-font-heading", className)}
    />
}

module Description = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <div
      ?id
      ?children
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="empty-description"
      className={cn(
        "cn-empty-description text-muted-foreground [&>a:hover]:text-primary [&>a]:underline [&>a]:underline-offset-4",
        className,
      )}
    />
}

module Content = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <div
      ?id
      ?children
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="empty-content"
      className={cn(
        "cn-empty-content flex w-full max-w-sm min-w-0 flex-col items-center text-balance",
        className,
      )}
    />
}
