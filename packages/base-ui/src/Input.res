type valueChangeDetails = Types.BaseUIChangeEventDetail.t<[#none], unknown>

type props = {
  @as("type") type_?: string,
  ...Types.BaseUIComponentProps.t,
  value?: string,
  onValueChange?: (string, valueChangeDetails) => unit,
  defaultValue?: string,
  min?: string,
  max?: string,
}
@module("@base-ui/react/input")
external make: React.component<props> = "Input"
