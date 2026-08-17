module ValueChangeDetails = {
  type t = Types.BaseUIChangeEventDetail.t<[#none], unknown>
}

type props = {
  ...Types.BaseUIComponentProps.t,
  value?: string,
  onValueChange?: (string, ValueChangeDetails.t) => unit,
  defaultValue?: string,
}
@module("@base-ui/react/input")
external make: React.component<props> = "Input"
