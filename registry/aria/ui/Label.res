@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module LabelContextProvider = {
  let make = React.Context.provider(ReactAria.Label.context)
}

@react.componentWithProps(ReactAria.Label.props)
let make = (props: ReactAria.Label.props) => {
  let label =
    <ReactAria.Label
      {...props}
      dataSlot={props.dataSlot->Option.getOr("label")}
      className={cn(
        "cn-label cn-label-aria flex items-center select-none group-data-[disabled=true]:pointer-events-none peer-disabled:cursor-not-allowed",
        props.className,
      )}
    />
  if props.htmlFor->Option.isSome && props.slot->Option.isNone {
    <LabelContextProvider value={Null}> {label} </LabelContextProvider>
  } else {
    label
  }
}
