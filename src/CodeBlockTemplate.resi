@react.component
let make: (
  ~raw: string,
  ~children: React.element,
  ~domProps: BaseUi.Types.DomProps.t,
  ~className: string=?,
) => React.element
