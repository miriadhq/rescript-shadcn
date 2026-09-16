@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("cn")
external cn: (string, option<string>) => string = "cn"

@react.componentWithProps(props)
let make = (props: ReactAria.Keyboard.props) => {
  let dataSlot = props.dataSlot->Option.getOr("kbd")
  <ReactAria.Keyboard
    {...props}
    dataSlot
    className={cn(
      "cn-kbd pointer-events-none inline-flex items-center justify-center select-none",
      props.className,
    )}
  />
}

module Group = {
  @react.componentWithProps(props)
  let make = (props: ReactAria.Keyboard.props) => {
    let dataSlot = props.dataSlot->Option.getOr("kbd-group")
    <ReactAria.Keyboard
      {...props} dataSlot className={cn("cn-kbd-group inline-flex items-center", props.className)}
    />
  }
}
