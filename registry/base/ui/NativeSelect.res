@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@module("cn")
external cn: (string, option<string>) => string = "cn"

module Size = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("sm") Sm
}

type props = {
  ...BaseUi.Types.BaseDomProps.t,
  ...BaseUi.Types.ExtraDomProps.t,
  children?: React.element,
  onChange?: JsxEvent.Form.t => unit,
  multiple?: bool,
  value?: string,
  defaultValue?: string,
  size?: Size.t,
  invalid?: bool,
}
let toDomProps: props => BaseUi.Types.DomProps.t = %raw(`({className, size, invalid, ...props}) => props`)

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
      ariaInvalid=?{props.ariaInvalid->Stdlib.Option.orElse(
        props.invalid == Some(true) ? Some(#"true") : None,
      )}
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
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <option
      {...props}
      dataSlot={props.dataSlot->Stdlib.Option.getOr("native-select-option")}
      className={cn("bg-[Canvas] text-[CanvasText]", props.className)}
    />
}

module OptGroup = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <optgroup
      {...props}
      dataSlot={props.dataSlot->Stdlib.Option.getOr("native-select-optgroup")}
      className={cn("bg-[Canvas] text-[CanvasText]", props.className)}
    />
}
