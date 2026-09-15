@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("cn")
external cn: (string, option<string>) => string = "cn"

module Size = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("sm") Sm
}

type props = {
  ...ReactAria.Common.inputProps,
  multiple?: bool,
  autoComplete?: string,
  autoFocus?: bool,
  form?: string,
  onPointerDown?: JsxEvent.Pointer.t => unit,
  size?: Size.t,
}
let toDomProps: props => ReactAria.Types.DomProps.t = %raw(`({className, size, ...props}) => props`)

@react.componentWithProps(props)
let make = (props: props) => {
  let size = props.size->Stdlib.Option.getOr(Default)
  <div
    dataSlot="native-select-wrapper"
    dataSize={(size :> string)}
    className={cn(
      "cn-native-select-wrapper group/native-select relative w-fit has-[select:disabled]:opacity-50",
      props.className,
    )}
  >
    <select
      {...toDomProps(props)}
      dataSlot={props.dataSlot->Stdlib.Option.getOr("native-select")}
      dataSize={props.dataSize->Stdlib.Option.getOr((size :> string))}
      className="cn-native-select outline-none disabled:pointer-events-none disabled:cursor-not-allowed"
    />
    <Icons.ChevronDown
      className="cn-native-select-icon pointer-events-none absolute select-none"
      ariaHidden=true
      dataSlot="native-select-icon"
    />
  </div>
}

module Option = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <option
      {...props}
      dataSlot={props.dataSlot->Stdlib.Option.getOr("native-select-option")}
      className={cn("bg-[Canvas] text-[CanvasText]", props.className)}
    />
}

module OptGroup = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <optgroup
      {...props}
      dataSlot={props.dataSlot->Stdlib.Option.getOr("native-select-optgroup")}
      className={cn("bg-[Canvas] text-[CanvasText]", props.className)}
    />
}
