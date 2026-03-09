@@directive("'use client'")

@react.component
let make = () => {
  let date = Date.make()

  <Calendar mode=Single selected=date className="rounded-lg border" captionLayout=Dropdown />
}
