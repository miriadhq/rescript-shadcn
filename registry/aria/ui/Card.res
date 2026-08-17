@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@module("react")
external createElement: (string, ReactAria.Common.ElementProps.t) => React.element = "createElement"

module Size = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("sm") Sm
}

type props = {size?: Size.t, ...ReactAria.Common.ElementProps.t}

@react.componentWithProps(props)
let make = ({?size, ...ReactAria.Common.ElementProps.t as props}) => {
  let size = size->Option.getOr(Default)
  createElement(
    "div",
    {
      ...props,
      dataSlot: props.dataSlot->Option.getOr("card"),
      dataSize: (size :> string),
      className: cn("cn-card group/card flex flex-col", props.className),
    },
  )
}

module Header = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) => {
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("card-header")}
      className={cn(
        "cn-card-header group/card-header @container/card-header grid auto-rows-min items-start has-data-[slot=card-action]:grid-cols-[1fr_auto] has-data-[slot=card-description]:grid-rows-[auto_auto]",
        props.className,
      )}
    />
  }
}

module Title = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) => {
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("card-title")}
      className={cn("cn-card-title cn-font-heading", props.className)}
    />
  }
}

module Description = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) => {
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("card-description")}
      className={cn("cn-card-description", props.className)}
    />
  }
}

module Action = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) => {
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("card-action")}
      className={cn(
        "cn-card-action col-start-2 row-span-2 row-start-1 self-start justify-self-end",
        props.className,
      )}
    />
  }
}

module Content = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) => {
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("card-content")}
      className={cn("cn-card-content", props.className)}
    />
  }
}

module Footer = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) => {
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("card-footer")}
      className={cn("cn-card-footer flex items-center", props.className)}
    />
  }
}
