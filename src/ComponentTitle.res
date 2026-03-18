@@directive("'use client'")

@react.component
let make = (~title) => {
  <h1 className="scroll-m-24 text-3xl font-semibold tracking-tight sm:text-3xl">
    {title->React.string}
  </h1>
}
