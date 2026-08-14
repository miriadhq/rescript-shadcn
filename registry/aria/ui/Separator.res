@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@react.componentWithProps(ReactAria.Separator.props)
let make = (props: ReactAria.Separator.props) =>
  <ReactAria.Separator
    {...props}
    dataSlot="separator"
    orientation={props.orientation->Option.getOr(ReactAria.Types.Orientation.Horizontal)}
    className={cn(
      "block shrink-0 border-0 bg-border aria-[orientation=horizontal]:h-px aria-[orientation=horizontal]:w-full aria-[orientation=vertical]:w-px aria-[orientation=vertical]:self-stretch [:is(hr)]:h-px [:is(hr)]:w-full",
      props.className,
    )}
  />
