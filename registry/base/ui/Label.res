@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@react.component
let make = (
  ~className=?,
  ~children=?,
  ~id=?,
  ~dataSlot="label",
  ~htmlFor=?,
  ~dir=?,
  ~onClick=?,
  ~onKeyDown=?,
  ~style=?,
) => {
  <label
    ?id
    ?children
    ?htmlFor
    ?dir
    ?onClick
    ?onKeyDown
    ?style
    dataSlot
    className={cn(
      "cn-label flex items-center select-none group-data-[disabled=true]:pointer-events-none peer-disabled:cursor-not-allowed",
      className,
    )}
  />
}
