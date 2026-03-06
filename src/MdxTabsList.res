@@directive("'use client'")

@react.component
let make = (~className=?, ~children=?) => {
  <Tabs.List
    className={Commons.cn("justify-start gap-4 rounded-none bg-transparent px-0", className)}
  >
    {children->Option.getOr(React.null)}
  </Tabs.List>
}
