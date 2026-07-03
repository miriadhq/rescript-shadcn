@@directive("'use client'")

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
  let maxStr = max->Option.map(i => i->Int.toString)
  let minStr = min->Option.map(i => i->Int.toString)
  <BaseUi.Progress.Root
    ?id
    ?value
    max=?maxStr
    min=?minStr
    ?dir
    ?style
    ?onClick
    ?onKeyDown
    dataSlot="progress"
    className={cn("cn-progress-root flex flex-wrap gap-3", className)}
  >
    {children}
    <BaseUi.Progress.Track
      dataSlot="progress-track"
      className="cn-progress-track relative flex w-full items-center overflow-x-hidden"
    >
      <BaseUi.Progress.Indicator
        dataSlot="progress-indicator" className="cn-progress-indicator h-full transition-all"
      />
    </BaseUi.Progress.Track>
  </BaseUi.Progress.Root>
}

module Track = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <BaseUi.Progress.Track
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
    <BaseUi.Progress.Indicator
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
    <BaseUi.Progress.Label
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
    <BaseUi.Progress.Value
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?children
      dataSlot="progress-value"
      className={cn("cn-progress-value", className)}
    />
}
