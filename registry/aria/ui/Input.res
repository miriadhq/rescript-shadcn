@@directive("'use client'")

@module("cn")
external cn: (string, option<string>) => string = "cn"

@react.componentWithProps(ReactAria.Input.props)
let make = (props: ReactAria.Input.props) => {
  let dataSlot = props.dataSlot->Option.getOr("input")
  <ReactAria.Input
    {...props}
    dataSlot
    className={cn(
      "cn-input w-full min-w-0 outline-none file:inline-flex file:border-0 file:bg-transparent file:text-foreground placeholder:text-muted-foreground disabled:pointer-events-none disabled:cursor-not-allowed disabled:opacity-50",
      props.className,
    )}
  />
}
