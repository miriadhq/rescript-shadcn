@@directive("'use client'")

@react.component
let make = (~className=?, ~variant=?, ~children) => {
  <Tabs.List
    ?variant
    className={Commons.cn("justify-start gap-4 rounded-none bg-transparent px-0", className)}
  >
    {children}
  </Tabs.List>
}
