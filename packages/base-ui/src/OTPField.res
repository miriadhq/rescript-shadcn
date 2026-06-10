module ValidationType = {
  @unboxed
  type t =
    | @as("numeric") Numeric
    | @as("alphanumeric") Alphanumeric
    | @as("none") None
}

module Root = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    length: int,
    autoSubmit?: bool,
    validationType?: ValidationType.t,
    normalizeValue?: string => string,
    defaultValue?: string,
    onValueChange?: (
      string,
      Types.BaseUIChangeEventDetail.t<[#"input-change" | #"input-clear" | #"input-paste" | #keyboard], unknown>,
    ) => unit,
    onValueInvalid?: (
      string,
      Types.BaseUIChangeEventDetail.t<[#"input-change" | #"input-paste"], unknown>,
    ) => unit,
    onValueComplete?: (
      string,
      Types.BaseUIChangeEventDetail.t<[#"input-change" | #"input-paste"], unknown>,
    ) => unit,
  }
  @module("@base-ui/react/otp-field") @scope("OTPFieldPreview")
  external make: React.component<props> = "Root"
}

module Input = {
  @module("@base-ui/react/otp-field") @scope("OTPFieldPreview")
  external make: React.component<Types.BaseUIComponentProps.t> = "Input"
}
