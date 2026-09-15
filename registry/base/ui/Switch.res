@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Size = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("sm") Sm
}

type props = {...BaseUi.Switch.Root.props, size?: Size.t}

let toBaseUiProps: props => BaseUi.Switch.Root.props = %raw(`({className, size, ...props}) => props`)

@react.componentWithProps(props)
let make = (props: props) => {
  let size = props.size->Option.getOr(Size.Default)
  <BaseUi.Switch.Root
    {...toBaseUiProps(props)}
    dataSlot="switch"
    dataSize={(size :> string)}
    className={cn(
      "cn-switch peer group/switch relative inline-flex items-center transition-all outline-none after:absolute after:-inset-x-3 after:-inset-y-2 data-disabled:cursor-not-allowed data-disabled:opacity-50",
      props.className,
    )}
  >
    <BaseUi.Switch.Thumb
      dataSlot="switch-thumb"
      className="cn-switch-thumb pointer-events-none block ring-0 transition-transform"
    />
  </BaseUi.Switch.Root>
}
