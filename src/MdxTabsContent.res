@@directive("'use client'")

@react.component
let make = (~className=?, ~children=?, ~value=?) =>
  <Tabs.Content
    ?value
    className={Commons.cn(
      "relative [&_h3.font-heading]:text-base [&_h3.font-heading]:font-medium *:[figure]:first:mt-0 [&>.steps]:mt-6",
      className,
    )}
  >
    {children->Option.getOr(React.null)}
  </Tabs.Content>
