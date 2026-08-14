@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@react.componentWithProps(ReactAria.Input.props)
let make = (props: ReactAria.Input.props) =>
  <ReactAria.Input
    {...props}
    dataSlot="input"
    className={cn(
      "cn-input w-full min-w-0 outline-none file:inline-flex file:border-0 file:bg-transparent file:text-foreground placeholder:text-muted-foreground disabled:pointer-events-none disabled:cursor-not-allowed disabled:opacity-50",
      props.className,
    )}
  />
