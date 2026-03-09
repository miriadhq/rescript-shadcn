@@directive("'use client'")

@react.component
let make = (~className=?, ~children, ~value=?) =>
  <Tabs.Trigger
    ?value
    className={Commons.cn(
      "rounded-none border-0 border-b-2 border-transparent bg-transparent px-0 pb-3 text-base text-muted-foreground hover:text-primary data-[state=active]:border-primary data-[state=active]:bg-transparent data-[state=active]:text-foreground data-[state=active]:shadow-none! dark:data-[state=active]:border-primary dark:data-[state=active]:bg-transparent",
      className,
    )}
  >
    {children}
  </Tabs.Trigger>
