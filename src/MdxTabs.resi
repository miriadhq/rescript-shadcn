@react.component
let make: (
  ~className: string=?,
  ~children: React.element,
  ~value: 'value=?,
  ~defaultValue: 'value=?,
  ~onValueChange: (
    'value,
    BaseUi.Types.BaseUIChangeEventDetail.t<[ | #none], unknown>,
  ) => unit=?,
) => React.element
