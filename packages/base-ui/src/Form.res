module ValidationMode = {
  @unboxed
  type t =
    | @as("onSubmit") OnSubmit
    | @as("onBlur") OnBlur
    | @as("onChange") OnChange
}

module Actions = {
  type t = {
    validate: option<string> => unit,
  }
}

type props<'values> = {
  ...Types.BaseUIComponentProps.t,
  validationMode?: ValidationMode.t,
  errors?: Dict.t<array<string>>,
  onFormSubmit?: ('values, Types.BaseUIChangeEventDetail.t<[#none], unknown>) => unit,
  actionsRef?: React.ref<Actions.t>,
}
@module("@base-ui/react/form")
external make: React.component<props<'values>> = "Form"
