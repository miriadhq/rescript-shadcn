@@directive("'use client'")

@react.component
let make = (~className=?, ~children, ~value=?) =>
  <Accordion.Item ?className ?value> {children} </Accordion.Item>
