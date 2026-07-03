@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@react.componentWithProps(BaseUi.Input.props)
let make = (props: BaseUi.Input.props) =>
  <BaseUi.Input
    {...props}
    dataSlot="input"
    className={cn(
      "cn-input file:text-foreground placeholder:text-muted-foreground w-full min-w-0 outline-none file:inline-flex file:border-0 file:bg-transparent disabled:pointer-events-none disabled:cursor-not-allowed disabled:opacity-50",
      props.className,
    )}
  />
