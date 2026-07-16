@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

module StyleSource = {
  type t = {
    style: Config.Style.t,
    children: React.element,
  }
}

@react.component
let make = (~sources, ~className=?) => {
  let (selectedStyle, _) = Config.Style.use()

  let children =
    sources
    ->Array.find(item => item.StyleSource.style === selectedStyle)
    ->Option.map(item => item.children)
    ->Option.getOr(React.null)

  <div className=?className> {children} </div>
}
