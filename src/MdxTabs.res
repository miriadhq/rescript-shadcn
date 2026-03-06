@@directive("'use client'")

@react.component
let make = (~className=?, ~children=?, ~value=?, ~defaultValue=?, ~onValueChange=?) => {
  <Tabs
    ?value ?defaultValue ?onValueChange className={Commons.cn("relative mt-6 w-full", className)}
  >
    {children->Option.getOr(React.null)}
  </Tabs>
}
