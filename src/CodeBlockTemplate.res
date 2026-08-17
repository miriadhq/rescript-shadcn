@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

module ElementProps = {
  type t = {children?: React.element}
}

@get
external getProps: React.element => ElementProps.t = "props"

let rec interpolateChildren = (children, libStyle) =>
  React.Children.map(children, child =>
    switch child->Type.Classify.classify {
    | String(value) => value->Config.LibStyle.interpolate(libStyle)->React.string
    | _ if React.isValidElement(child) =>
      let {?children} = child->getProps
      switch children {
      | Some(children) =>
        React.cloneElement(
          child,
          ({children: children->interpolateChildren(libStyle)}: ElementProps.t),
        )
      | None => child
      }
    | _ => child
    }
  )

@react.component
let make = (~raw, ~children, ~domProps, ~className=?) => {
  let (libStyle, _, _) = Config.LibStyle.use()
  let value = raw->Config.LibStyle.interpolate(libStyle)

  <>
    <CopyButton value />
    <code {...domProps} ?className> {children->interpolateChildren(libStyle)} </code>
  </>
}
