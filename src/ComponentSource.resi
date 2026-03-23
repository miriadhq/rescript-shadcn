@react.component
let make: (
  ~name: string=?,
  ~src: string=?,
  ~title: string=?,
  ~language: string=?,
  ~collapsible: bool=?,
  ~className: string=?,
  ~maxLines: int=?,
) => Jsx.element
