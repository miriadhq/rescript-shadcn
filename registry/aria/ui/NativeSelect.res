@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Size = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("sm") Sm
}

@react.component
let make = (
  ~className=?,
  ~children=?,
  ~id=?,
  ~name=?,
  ~value=?,
  ~defaultValue=?,
  ~disabled=?,
  ~required=?,
  ~onClick=?,
  ~onKeyDown=?,
  ~tabIndex=?,
  ~ariaLabel=?,
  ~invalid=false,
  ~dir=?,
  ~style=?,
  ~size=Size.Default,
) => {
  <div
    ?id
    ?style
    ?dir
    ?onClick
    ?onKeyDown
    dataSlot="native-select-wrapper"
    dataSize={(size :> string)}
    className={cn("cn-native-select-wrapper group/native-select relative w-fit has-[select:disabled]:opacity-50", className)}
  >
    <select
      ?id
      ?name
      ?value
      ?defaultValue
      ?disabled
      ?required
      ?onClick
      ?onKeyDown
      ?tabIndex
      ?ariaLabel
      ariaInvalid=?{invalid ? Some(#"true") : None}
      ?style
      ?children
      dataSlot="native-select"
      dataSize={(size :> string)}
      className="cn-native-select outline-none disabled:pointer-events-none disabled:cursor-not-allowed"
    />
    <Icons.ChevronDown
      className="cn-native-select-icon pointer-events-none absolute select-none"
      ariaHidden={true}
      dataSlot="native-select-icon"
    />
  </div>
}

module Option = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~id=?,
    ~value=?,
    ~disabled=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~style=?,
  ) =>
    <option
      ?id
      ?value
      ?disabled
      ?onClick
      ?onKeyDown
      ?style
      ?children
      ?className
      dataSlot="native-select-option"
    />
}

module OptGroup = {
  @react.component
  let make = (~className="", ~children=?, ~id=?, ~label=?, ~style=?) =>
    <optgroup
      ?id ?label ?style ?children dataSlot="native-select-optgroup" className={`${className}`}
    />
}
