@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

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

@react.component
let make = (
  ~className=?,
  ~variant=Variant.Default,
  ~align=Align.Start,
  ~children=?,
  ~id=?,
  ~style=?,
  ~onClick=?,
  ~onKeyDown=?,
) =>
  <div
    ?id
    ?style
    ?onClick
    ?onKeyDown
    ?children
    dataSlot="bubble"
    dataVariant={(variant :> string)}
    dataAlign={(align :> string)}
    className={cn(
      `cn-bubble group/bubble relative flex w-fit min-w-0 flex-col ${variantClass(~variant)}`,
      className,
    )}
  />

module Group = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <div
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?children
      dataSlot="bubble-group"
      className={cn("cn-bubble-group flex min-w-0 flex-col", className)}
    />
}

module Content = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <div
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?children
      dataSlot="bubble-content"
      className={cn(
        "cn-bubble-content w-fit max-w-full min-w-0 overflow-hidden wrap-break-word [button]:text-left [button,a]:transition-colors",
        className,
      )}
    />
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

  @react.component
  let make = (
    ~className=?,
    ~side=Side.Bottom,
    ~align=Align.End,
    ~children=?,
    ~role=?,
    ~ariaLabel=?,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
  ) =>
    <div
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?role
      ?ariaLabel
      ?children
      dataSlot="bubble-reactions"
      dataSide={(side :> string)}
      dataAlign={(align :> string)}
      className={cn(
        `cn-bubble-reactions absolute z-10 flex w-fit items-center justify-center ${sideClass(
            ~side,
          )} ${alignClass(~align)}`,
        className,
      )}
    />
}
