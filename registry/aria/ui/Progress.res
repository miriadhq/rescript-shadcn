@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@react.component
let make = (
  ~className=?,
  ~children=React.null,
  ~id=?,
  ~value=?,
  ~max=?,
  ~min=?,
  ~dir=?,
  ~style=?,
  ~onClick=?,
  ~onKeyDown=?,
) => {
  <ReactAria.ProgressBar
    ?id
    ?value
    maxValue=?{max->Option.map(Int.toFloat)}
    minValue=?{min->Option.map(Int.toFloat)}
    ?dir
    ?style
    ?onClick
    ?onKeyDown
    dataSlot="progress"
    className={cn("cn-progress-root flex flex-wrap gap-3", className)}
  >
    {children}
    <div
      dataSlot="progress-track"
      className="cn-progress-track relative flex w-full items-center overflow-x-hidden"
    >
      <div
        dataSlot="progress-indicator" className="cn-progress-indicator h-full transition-all"
      />
    </div>
  </ReactAria.ProgressBar>
}

module Track = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <div
      ?id
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="progress-track"
      className={cn(
        "cn-progress-track relative flex w-full items-center overflow-x-hidden",
        className,
      )}
      ?children
    />
}

module Indicator = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <div
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?children
      dataSlot="progress-indicator"
      className={cn("cn-progress-indicator h-full transition-all", className)}
    />
}

module Label = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <ReactAria.Label
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?children
      dataSlot="progress-label"
      className={cn("cn-progress-label", className)}
    />
}

module Value = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <span
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?children
      dataSlot="progress-value"
      className={cn("cn-progress-value", className)}
    />
}
