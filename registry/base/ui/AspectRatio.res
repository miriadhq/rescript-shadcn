@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@react.component
let make = (
  ~ratio,
  ~className=?,
  ~children=?,
  ~id=?,
  ~style=ReactDOM.Style.unsafeAddStyle({}, {"--ratio": ratio}),
  ~onClick=?,
  ~onKeyDown=?,
) => {
  <div
    ?id
    style
    ?children
    ?onClick
    ?onKeyDown
    dataSlot="aspect-ratio"
    className={cn("relative aspect-(--ratio)", className)}
  />
}
