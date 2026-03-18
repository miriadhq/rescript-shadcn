@@directive("'use client'")

@react.component
let make = (~className=?, ~children) =>
  <Accordion.Content ?className> {children} </Accordion.Content>
