@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

type props = {
  ...ReactAria.Input.props,
  onValueChange?: (string, JSON.t) => unit,
}

let toAriaProps: props => ReactAria.Input.props = %raw(`props => {
  const {onValueChange, ...rest} = props;
  return {...rest, onChange: onValueChange == null ? rest.onChange : value => onValueChange(value, undefined)};
}`)

@react.componentWithProps(props)
let make = (props: props) =>
  <ReactAria.Input
    {...props->toAriaProps}
    dataSlot="input"
    className={cn(
      "cn-input file:text-foreground placeholder:text-muted-foreground w-full min-w-0 outline-none file:inline-flex file:border-0 file:bg-transparent disabled:pointer-events-none disabled:cursor-not-allowed disabled:opacity-50",
      props.className,
    )}
  />
