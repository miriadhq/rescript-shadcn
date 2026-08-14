@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Orientation = ReactAria.Types.Orientation

let buttonGroupVariants = (~orientation=Orientation.Horizontal) => {
  let orientationClass = switch orientation {
  | Horizontal =>
    "cn-button-group-orientation-horizontal **:data-slot:rounded-r-none [&_[data-slot]~[data-slot]]:rounded-l-none [&_[data-slot]~[data-slot]]:border-l-0"
  | Vertical =>
    "cn-button-group-orientation-vertical flex-col **:data-slot:rounded-b-none [&_[data-slot]~[data-slot]]:rounded-t-none [&_[data-slot]~[data-slot]]:border-t-0"
  }
  cn(
    "cn-button-group flex w-fit items-stretch *:focus-visible:relative *:focus-visible:z-10 [&>[data-slot=select-trigger]:not([class*='w-'])]:w-fit [&>input]:flex-1",
    Some(orientationClass),
  )
}

type props = {orientation?: Orientation.t, ...ReactAria.Common.elementProps}
let domProps: props => ReactAria.Types.DomProps.t = %raw(`({orientation, ...props}) => props`)

@react.componentWithProps(props)
let make = (props: props) => {
  let orientation = props.orientation->Option.getOr(Horizontal)
  <div
    {...props->domProps}
    role={props.role->Option.getOr("group")}
    dataSlot={props.dataSlot->Option.getOr("button-group")}
    dataOrientation={(orientation :> string)}
    className={cn(buttonGroupVariants(~orientation), props.className)}
  />
}

module Text = {
  type props = {render?: ReactAria.Types.DomProps.t => React.element, ...ReactAria.Types.DomProps.t}
  let domProps: props => ReactAria.Types.DomProps.t = %raw(`({render, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let renderProps = props->domProps
    let renderProps = {
      ...renderProps,
      className: cn(
        "cn-button-group-text flex items-center [&_svg]:pointer-events-none",
        props.className,
      ),
      dataSlot: props.dataSlot->Option.getOr("button-group-text"),
    }
    switch props.render {
    | Some(render) => render(renderProps)
    | None =>
      <div
        {...renderProps}
      />
    }
  }
}

module Separator = {
  @react.componentWithProps(ReactAria.Separator.props)
  let make = (props: ReactAria.Separator.props) =>
    <Separator
      {...props}
      dataSlot={props.dataSlot->Option.getOr("button-group-separator")}
      orientation={props.orientation->Option.getOr(Orientation.Vertical)}
      className={cn(
        "cn-button-group-separator relative self-stretch data-horizontal:mx-px data-horizontal:w-auto data-vertical:my-px data-vertical:h-auto",
        props.className,
      )}
    />
}
