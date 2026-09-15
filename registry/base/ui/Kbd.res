@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@module("cn")
external cn: (string, option<string>) => string = "cn"

@react.componentWithProps(BaseUi.Types.DomProps.t)
let make = (props: BaseUi.Types.DomProps.t) => {
  <kbd
    {...props}
    dataSlot={props.dataSlot->Option.getOr("kbd")}
    className={cn(
      "cn-kbd pointer-events-none inline-flex items-center justify-center select-none",
      props.className,
    )}
  />
}

module Group = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <kbd
      {...props}
      dataSlot={props.dataSlot->Option.getOr("kbd-group")}
      className={cn("cn-kbd-group inline-flex items-center", props.className)}
    />
}
