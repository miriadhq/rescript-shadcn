@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Direction.Provider>
    <div className="rounded-md border px-3 py-2"> {"Direction context"->React.string} </div>
  </Direction.Provider>
