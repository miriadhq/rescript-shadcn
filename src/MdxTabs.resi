@react.component
let make: (
  ~className: string=?,
  ~children: React.element,
  ~value: string=?,
  ~defaultValue: string=?,
  ~onValueChange: (string, BaseUi.Types.BaseUIChangeEventDetail.t<[#none], unknown>) => unit=?,
) => React.element
