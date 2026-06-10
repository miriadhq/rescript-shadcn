type props = {
  ...Types.BaseUIComponentProps.t,
  value?: array<string>,
  defaultValue?: array<string>,
  onValueChange?: (array<string>, Types.BaseUIChangeEventDetail.t<[#none], unknown>) => unit,
  allValues?: array<string>,
}
@module("@base-ui/react/checkbox-group")
external make: React.component<props> = "CheckboxGroup"
