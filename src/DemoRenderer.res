@@directive("'use client'")

@module("./demo-loader.js")
external getDemo: string => Nullable.t<React.component<{..}>> = "getDemo"

@react.component
let make = (~name: string) => {
  let component = getDemo(name)
  switch component->Nullable.toOption {
  | None => React.null
  | Some(comp) =>
    let createElement: React.component<{..}> => React.element = %raw(`function(c) { return require("react").createElement(c, {}) }`)
    <React.Suspense fallback={React.null}>
      {createElement(comp)}
    </React.Suspense>
  }
}
