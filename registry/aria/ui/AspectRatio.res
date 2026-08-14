@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

type props = {ratio: float, ...ReactAria.Types.DomProps.t}
let domProps: props => ReactAria.Types.DomProps.t = %raw(`({ratio, ...props}) => props`)

@react.componentWithProps(props)
let make = (props: props) => {
  <div
    {...props->domProps}
    style={props.style->Option.getOr(
      ReactDOM.Style.unsafeAddStyle({}, {"--ratio": props.ratio}),
    )}
    dataSlot={props.dataSlot->Option.getOr("aspect-ratio")}
    className={cn("relative aspect-(--ratio)", props.className)}
  />
}
