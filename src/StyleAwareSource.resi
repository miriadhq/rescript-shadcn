module StyleSource: {
  type t = {
    style: Config.Style.t,
    children: React.element,
  }
}

@react.component
let make: (~sources: array<StyleSource.t>, ~className: string=?) => React.element
