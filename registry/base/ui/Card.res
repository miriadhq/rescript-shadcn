@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Size = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("sm") Sm
}

@react.component
let make = (
  ~className=?,
  ~children=?,
  ~id=?,
  ~dir=?,
  ~style=?,
  ~onClick=?,
  ~onKeyDown=?,
  ~size=Size.Default,
) => {
  <div
    ?id
    ?children
    ?style
    ?dir
    ?onClick
    ?onKeyDown
    dataSlot="card"
    dataSize={(size :> string)}
    className={cn(
      "cn-card group/card flex flex-col",
      className,
    )}
  />
}

module Header = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) => {
    <div
      ?id
      ?children
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="card-header"
      className={cn(
        "cn-card-header group/card-header @container/card-header grid auto-rows-min items-start has-data-[slot=card-action]:grid-cols-[1fr_auto] has-data-[slot=card-description]:grid-rows-[auto_auto]",
        className,
      )}
    />
  }
}

module Title = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) => {
    <div
      ?id
      ?children
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="card-title"
      className={cn(
        "cn-card-title cn-font-heading",
        className,
      )}
    />
  }
}

module Description = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) => {
    <div
      ?id
      ?children
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="card-description"
      className={cn("cn-card-description", className)}
    />
  }
}

module Action = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) => {
    <div
      ?id
      ?children
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="card-action"
      className={cn("cn-card-action col-start-2 row-span-2 row-start-1 self-start justify-self-end", className)}
    />
  }
}

module Content = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) => {
    <div
      ?id
      ?children
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="card-content"
      className={cn("cn-card-content", className)}
    />
  }
}

module Footer = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) => {
    <div
      ?id
      ?children
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="card-footer"
      className={cn(
        "cn-card-footer flex items-center",
        className,
      )}
    />
  }
}
