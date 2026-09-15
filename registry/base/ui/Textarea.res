@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@module("cn")
external cn: (string, option<string>) => string = "cn"

@react.componentWithProps(BaseUi.Types.DomProps.t)
let make = (props: BaseUi.Types.DomProps.t) => {
  <textarea
    {...props}
    dataSlot={props.dataSlot->Option.getOr("textarea")}
    className={cn(
      "cn-textarea flex field-sizing-content min-h-16 w-full outline-none placeholder:text-muted-foreground disabled:cursor-not-allowed disabled:opacity-50",
      props.className,
    )}
  />
}
