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

type props<'children> = {size?: Size.t, children?: 'children, ...ReactAria.Switch.componentProps}

let switchProps: props<'children> => ReactAria.Switch.componentProps = %raw(`({size, children, ...props}) => props`)

@react.componentWithProps(props)
let make = (props: props<'children>) => {
  let size = props.size->Option.getOr(Default)
  <ReactAria.Switch
    {...props->switchProps->ReactAria.Switch.toProps}
    dataSlot="switch"
    dataSize={(size :> string)}
    className={cn(
      "cn-switch cn-switch-aria peer group/switch relative inline-flex items-center transition-all outline-none after:absolute after:-inset-x-3 after:-inset-y-2 data-disabled:cursor-not-allowed data-disabled:opacity-50",
      props.className,
    )}
  >
    {ReactAria.Common.composeRenderProps(props.children, (children, state: ReactAria.Switch.renderProps) =>
      <>
        <span
          dataSlot="switch-thumb"
          dataSelected=?{state.isSelected ? Some(true) : None}
          className="cn-switch-thumb cn-switch-thumb-aria pointer-events-none block ring-0 transition-transform"
        />
        {children}
      </>
    )}
  </ReactAria.Switch>
}
