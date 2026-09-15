@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@module("cn")
external cn: (string, option<string>) => string = "cn"

@react.componentWithProps(BaseUi.Types.DomProps.t)
let make = (props: BaseUi.Types.DomProps.t) => {
  <div
    {...props}
    dataSlot={props.dataSlot->Option.getOr("skeleton")}
    className={cn("cn-skeleton animate-pulse", props.className)}
  />
}
