@@directive("'use client'")

@react.component
let make = (~className=?, ~children=?) =>
  <Accordion.Trigger ?className> {children->Option.getOr(React.null)} </Accordion.Trigger>
