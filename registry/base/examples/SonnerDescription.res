@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Button variant=Button.Variant.Outline className="w-fit" onClick={_ => ()}>
    {"Show Toast"->React.string}
  </Button>
