module Root = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    invalid?: bool,
    dirty?: bool,
    touched?: bool,
    validationMode?: [#onSubmit | #onBlur | #onChange],
    validationDebounceTime?: float,
  }
  @module("@base-ui/react/field") @scope("Field")
  external make: React.component<props> = "Root"
}

module Label = {
  @module("@base-ui/react/field") @scope("Field")
  external make: React.component<Types.BaseUIComponentProps.t> = "Label"
}

module Description = {
  @module("@base-ui/react/field") @scope("Field")
  external make: React.component<Types.BaseUIComponentProps.t> = "Description"
}

module Error = {
  @module("@base-ui/react/field") @scope("Field")
  external make: React.component<Types.BaseUIComponentProps.t> = "Error"
}

module Control = {
  type props = {...Types.BaseUIComponentProps.t, @as("type") type_?: string}
  @module("@base-ui/react/field") @scope("Field")
  external make: React.component<props> = "Control"
}

module Validity = {
  @module("@base-ui/react/field") @scope("Field")
  external make: React.component<Types.BaseUIComponentProps.t> = "Validity"
}

module Item = {
  @module("@base-ui/react/field") @scope("Field")
  external make: React.component<Types.BaseUIComponentProps.t> = "Item"
}
