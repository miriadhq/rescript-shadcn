@@directive("'use client'")

@react.component
let make = (~className=?, ~children, ~value) =>
  <Tabs.Trigger
    value
    className={Commons.cn(
      "rounded-none border-0 border-b-2 border-transparent bg-transparent px-0 pb-3 text-base text-muted-foreground hover:text-primary data-active:border-primary data-active:bg-transparent data-active:text-foreground data-active:shadow-none! dark:data-active:border-primary dark:data-active:bg-transparent",
      className,
    )}
  >
    {children}
  </Tabs.Trigger>
