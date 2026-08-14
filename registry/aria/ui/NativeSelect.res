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
  ~multiple=?,
  ~autoComplete=?,
  ~onChange=?,
  ~onClick=?,
  ~onKeyDown=?,
  ~tabIndex=?,
  ~ariaLabel=?,
  ~ariaInvalid=?,
  ~dir=?,
  ~style=?,
  ~size=Size.Default,
) => {
  <div
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
      ?multiple
      ?autoComplete
      ?onChange
      ?onClick
      ?onKeyDown
      ?tabIndex
      ?ariaLabel
      ?ariaInvalid
      ?style
      ?dir
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
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <option
      {...props}
      dataSlot={props.dataSlot->Option.getOr("native-select-option")}
      className={cn("bg-[Canvas] text-[CanvasText]", props.className)}
    />
}

module OptGroup = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <optgroup
      {...props}
      dataSlot={switch props.dataSlot {
      | Some(dataSlot) => dataSlot
      | None => "native-select-optgroup"
      }}
      className={cn("bg-[Canvas] text-[CanvasText]", props.className)}
    />
}
