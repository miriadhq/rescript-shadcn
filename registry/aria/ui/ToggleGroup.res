@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@module("tailwind-merge")
external cn3: (string, string, option<string>) => string = "twMerge"

module Variant = Toggle.Variant
module Size = Toggle.Size

module Orientation = {
  @unboxed
  type t = ReactAria.Common.orientation =
    | @as("horizontal") Horizontal
    | @as("vertical") Vertical
}

type context = {
  variant?: Variant.t,
  size?: Size.t,
  spacing?: float,
  orientation?: Orientation.t,
}

let toggleGroupContext = React.createContext({
  variant: Variant.Default,
  size: Size.Default,
  spacing: 2.0,
  orientation: Orientation.Horizontal,
})

module ContextProvider = {
  let make = React.Context.provider(toggleGroupContext)
}

type props = {
  variant?: Variant.t,
  size?: Size.t,
  spacing?: float,
  children?: React.element,
  ...ReactAria.ToggleButtonGroup.componentProps,
}

let groupProps: props => ReactAria.ToggleButtonGroup.componentProps = %raw(`({variant, size, spacing, children, ...props}) => props`)

@react.componentWithProps(props)
let make = (props: props) => {
  let spacing = props.spacing->Option.getOr(2.)
  let orientation = props.orientation->Option.getOr(Horizontal)
  <ReactAria.ToggleButtonGroup
    {...props->groupProps->ReactAria.ToggleButtonGroup.toProps}
    dataSlot="toggle-group"
    dataVariant=?{(props.variant :> option<string>)}
    dataSize=?{(props.size :> option<string>)}
    dataSpacing={spacing}
    dataOrientation={(orientation :> string)}
    style={ReactDOM.Style._dictToStyle(
      dict{"--gap": "calc(var(--spacing) * " ++ spacing->Float.toString ++ ")"},
    )}
    className={cn(
      "cn-toggle-group group/toggle-group flex w-fit flex-row items-center gap-(--gap) data-vertical:flex-col data-vertical:items-stretch",
      props.className,
    )}
  >
    <ContextProvider
      value={{
        variant: ?props.variant,
        size: ?props.size,
        spacing,
        orientation: (orientation :> Orientation.t),
      }}
    >
      {props.children->Option.getOr(React.null)}
    </ContextProvider>
  </ReactAria.ToggleButtonGroup>
}

module Item = {
  type props = {
    variant?: Variant.t,
    size?: Size.t,
    ...ReactAria.ToggleButton.props,
  }

  let itemProps: props => ReactAria.ToggleButton.props = %raw(`({variant, size, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let context = React.useContext(toggleGroupContext)
    let variant = context.variant->Option.orElse(props.variant)->Option.getOr(Default)
    let size = context.size->Option.orElse(props.size)->Option.getOr(Default)
    <ReactAria.ToggleButton
      {...props->itemProps}
      dataSlot="toggle-group-item"
      dataVariant={(variant :> string)}
      dataSize={(size :> string)}
      dataSpacing=?context.spacing
      className={cn3(
        "cn-toggle-group-item shrink-0 focus:z-10 focus-visible:z-10 group-data-horizontal/toggle-group:data-[spacing=0]:data-[variant=outline]:border-l-0 group-data-vertical/toggle-group:data-[spacing=0]:data-[variant=outline]:border-t-0 group-data-horizontal/toggle-group:data-[spacing=0]:data-[variant=outline]:first:border-l group-data-vertical/toggle-group:data-[spacing=0]:data-[variant=outline]:first:border-t",
        Toggle.toggleVariants(~variant, ~size),
        props.className,
      )}
    />
  }
}
