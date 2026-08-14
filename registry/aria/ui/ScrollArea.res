@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@react.componentWithProps(ReactAria.Types.DomProps.t)
let make = (props: ReactAria.Types.DomProps.t) =>
  <div
    {...props}
    dataSlot={props.dataSlot->Option.getOr("scroll-area")}
    className={cn(
      "cn-scroll-area relative [scrollbar-width:thin] [scrollbar-color:var(--color-border)_transparent] overflow-auto outline-none focus-visible:ring-[3px] focus-visible:ring-ring/50 focus-visible:outline-1",
      props.className,
    )}
  />
