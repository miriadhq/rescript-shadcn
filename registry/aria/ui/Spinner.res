@module("cn")
external cn: (string, option<string>) => string = "cn"

@unboxed
type dataIcon =
  | @as("inline-start") InlineStart
  | @as("inline-end") InlineEnd

type props = {
  ...JsxDOM.domProps,
  @as("data-icon") dataIcon?: dataIcon,
  @as("data-slot") dataSlot?: string,
}

external toIconProps: props => Icons.props = "%identity"

@react.componentWithProps(props)
let make = (props: props) =>
  <Icons.Loader2
    {...props->toIconProps}
    dataSlot={props.dataSlot->Option.getOr("spinner")}
    role={props.role->Option.getOr("status")}
    ariaLabel={props.ariaLabel->Option.getOr("Loading")}
    className={cn("size-4 animate-spin", props.className)}
  />
