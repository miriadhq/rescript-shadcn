@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => <Calendar mode=Single className="rounded-lg border" />
