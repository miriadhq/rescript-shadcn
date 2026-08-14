@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@react.componentWithProps(ReactAria.Types.DomProps.t)
let make = (props: ReactAria.Types.DomProps.t) => {
  <div
    {...props}
    dataSlot={props.dataSlot->Option.getOr("skeleton")}
    className={cn("cn-skeleton animate-pulse", props.className)}
  />
}
