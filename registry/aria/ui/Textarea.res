@@directive("'use client'")

@module("cn")
external cn: (string, option<string>) => string = "cn"

@react.componentWithProps(ReactAria.Input.TextArea.props)
let make = (props: ReactAria.Input.TextArea.props) =>
  <ReactAria.Input.TextArea
    {...props}
    dataSlot={props.dataSlot->Option.getOr("textarea")}
    className={cn(
      "cn-textarea flex field-sizing-content min-h-16 w-full outline-none placeholder:text-muted-foreground disabled:cursor-not-allowed disabled:opacity-50",
      props.className,
    )}
  />
