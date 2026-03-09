@@directive("'use client'")

@react.component
let make = (~className=?, ~children) =>
  <Accordion.Trigger ?className> {children} </Accordion.Trigger>
