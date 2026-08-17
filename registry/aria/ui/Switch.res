@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Size = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("sm") Sm
}

type props = {size?: Size.t, ...ReactAria.Switch.props}

@react.componentWithProps(props)
let make = ({?size, ...ReactAria.Switch.props as props}) => {
  let size = size->Option.getOr(Default)
  let children = ReactAria.Common.composeRenderElement(props.children, (
    children,
    state: ReactAria.Switch.RenderProps.t,
  ) =>
    <>
      <span
        dataSlot="switch-thumb"
        dataSelected=?{state.isSelected ? Some(true) : None}
        className="cn-switch-thumb cn-switch-thumb-aria pointer-events-none block ring-0 transition-transform"
      />
      {children}
    </>
  )
  <ReactAria.Switch
    {...props}
    dataSlot="switch"
    dataSize={(size :> string)}
    className={cn(
      "cn-switch cn-switch-aria peer group/switch relative inline-flex items-center transition-all outline-none after:absolute after:-inset-x-3 after:-inset-y-2 data-disabled:cursor-not-allowed data-disabled:opacity-50",
      props.className,
    )}
    children
  />
}
