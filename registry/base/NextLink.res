@module("next/link") @react.component
external make: (
  ~href: string,
  ~className: string=?,
  ~children: React.element=?,
  ~target: string=?,
  ~rel: string=?,
) => React.element = "default"
