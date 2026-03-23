@react.component
let make: (
  ~className: string=?,
  ~children: React.element,
  ~value: 'a=?,
  ~defaultValue: 'a=?,
  ~onValueChange: ('a, BaseUi.Types.eventDetails) => unit=?,
) => React.element
