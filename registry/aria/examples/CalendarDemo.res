@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let date = Date.make()

  <Calendar mode=Single selected=date className="rounded-lg border" captionLayout=Dropdown />
}
