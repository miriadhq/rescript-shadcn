@@directive("'use client'")

@module("cn")
external cn: (string, option<string>) => string = "cn"

@module("cn")
external cn3: (string, string, option<string>) => string = "cn"

module Variant = Toggle.Variant
module Size = Toggle.Size

module Orientation = BaseUi.Types.Orientation

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

type props<'value> = {
  ...BaseUi.ToggleGroup.props<'value>,
  variant?: Variant.t,
  size?: Size.t,
  spacing?: float,
}

let toBaseUiProps: props<'value> => BaseUi.ToggleGroup.props<
  'value,
> = %raw(`({className, variant, size, spacing, orientation, children, ...props}) => props`)

@react.componentWithProps(props)
let make = (props: props<'value>) => {
  let variant = props.variant
  let size = props.size
  let spacing = props.spacing->Option.getOr(2.)
  let orientation = props.orientation->Option.getOr(Orientation.Horizontal)

  <BaseUi.ToggleGroup
    {...toBaseUiProps(props)}
    orientation
    dataSlot={props.dataSlot->Option.getOr("toggle-group")}
    dataVariant=?{props.dataVariant->Option.orElse((variant :> option<string>))}
    dataSize=?{props.dataSize->Option.orElse((size :> option<string>))}
    dataSpacing={props.dataSpacing->Option.getOr(spacing)}
    dataOrientation={props.dataOrientation->Option.getOr((orientation :> string))}
    style={ReactDOM.Style.combine(
      ReactDOM.Style.unsafeAddStyle({}, {"--gap": spacing}),
      props.style->Option.getOr({}),
    )}
    className={cn(
      "cn-toggle-group group/toggle-group flex w-fit flex-row items-center gap-[--spacing(var(--gap))] data-vertical:flex-col data-vertical:items-stretch",
      props.className,
    )}
  >
    <ContextProvider value={{?variant, ?size, spacing, orientation}}>
      {props.children->Option.getOr(React.null)}
    </ContextProvider>
  </BaseUi.ToggleGroup>
}

module Item = {
  type props<'value> = Toggle.props<'value>

  @react.componentWithProps(props)
  let make = (props: props<'value>) => {
    let variant = props.variant->Option.getOr(Variant.Default)
    let size = props.size->Option.getOr(Size.Default)
    let context = React.useContext(toggleGroupContext)
    let variant = context.variant->Option.getOr(variant)
    let size = context.size->Option.getOr(size)

    <BaseUi.Toggle
      {...Toggle.toBaseUiProps(props)}
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
