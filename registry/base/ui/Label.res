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
      "flex items-center gap-2 text-sm leading-none font-medium select-none group-data-[disabled=true]:pointer-events-none group-data-[disabled=true]:opacity-50 peer-disabled:cursor-not-allowed peer-disabled:opacity-50",
      className,
    )}
  />
}
