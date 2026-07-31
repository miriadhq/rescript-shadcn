@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@react.component
let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?, ~dataIcon=?) => {
  <kbd
    ?id
    ?style
    ?onClick
    ?onKeyDown
    ?children
    ?dataIcon
    dataSlot="kbd"
    className={cn(
      "cn-kbd pointer-events-none inline-flex items-center justify-center select-none",
      className,
    )}
  />
}

module Group = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <kbd
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?children
      dataSlot="kbd-group"
      className={cn("cn-kbd-group inline-flex items-center", className)}
    />
}
