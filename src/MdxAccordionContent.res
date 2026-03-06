@@directive("'use client'")

@react.component
let make = (~className=?, ~children=?) =>
  <Accordion.Content ?className> {children->Option.getOr(React.null)} </Accordion.Content>
