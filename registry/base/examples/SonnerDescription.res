@@directive("'use client'")

@react.component
let make = () =>
  <Button variant=Button.Variant.Outline className="w-fit" onClick={_ => ()}>
    {"Show Toast"->React.string}
  </Button>
