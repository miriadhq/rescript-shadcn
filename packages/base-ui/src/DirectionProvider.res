@module("@base-ui/react/direction-provider") @react.component
external make: (~children: React.element=?, ~direction: Types.TextDirection.t=?) => React.element =
  "DirectionProvider"

@module("@base-ui/react/direction-provider")
external useDirection: unit => Types.TextDirection.t = "useDirection"
