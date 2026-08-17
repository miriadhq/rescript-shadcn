module Kind: {
  type t =
    | Example
    | Component
}

@react.component
let make: (
  ~name: string=?,
  ~src: string=?,
  ~title: string=?,
  ~language: string=?,
  ~collapsible: bool=?,
  ~className: string=?,
  ~maxLines: int=?,
  ~kind: Kind.t=?,
  ~lib: Config.Lib.t=?,
  ~style: Config.Style.t=?,
) => Jsx.element
