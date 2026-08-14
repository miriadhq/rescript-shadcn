@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Size = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("sm") Sm
    | @as("lg") Lg
}

type props = {size?: Size.t, ...ReactAria.Common.elementProps}
let domProps: props => ReactAria.Types.DomProps.t = %raw(`({size, ...props}) => props`)

@react.componentWithProps(props)
let make = (props: props) => {
  let size = props.size->Option.getOr(Default)
  <div
    {...props->domProps}
    dataSlot={props.dataSlot->Option.getOr("avatar")}
    dataSize={(size :> string)}
    className={cn(
      "cn-avatar group/avatar relative flex shrink-0 select-none after:absolute after:inset-0 after:border after:border-border after:mix-blend-darken dark:after:mix-blend-lighten",
      props.className,
    )}
  />
}

module Image = {
  @unboxed
  type state =
    | @as("loading") Loading
    | @as("loaded") Loaded
    | @as("error") Error

  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) => {
    let (state, setState) = React.useState(() => props.src->Option.mapOr(Error, _ => Loading))
    <img
      {...props}
      alt={props.alt->Option.getOr("")}
      dataSlot={props.dataSlot->Option.getOr("avatar-image")}
      dataState={props.dataState->Option.getOr((state :> string))}
      onLoad={props.onLoad->Option.getOr(_event => setState(_ => Loaded))}
      onError={props.onError->Option.getOr(_event => setState(_ => Error))}
      className={cn(
        "cn-avatar-image peer aspect-square size-full object-cover data-[state=error]:hidden",
        props.className,
      )}
    />
  }
}

module Fallback = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("avatar-fallback")}
      className={cn(
        "cn-avatar-fallback flex size-full items-center justify-center text-sm group-data-[size=sm]/avatar:text-xs peer-data-[state=error]:flex peer-[*]:hidden",
        props.className,
      )}
    />
}

module Group = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("avatar-group")}
      className={cn(
        "cn-avatar-group group/avatar-group flex -space-x-2 *:data-[slot=avatar]:ring-2 *:data-[slot=avatar]:ring-background",
        props.className,
      )}
    />
}

module GroupCount = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("avatar-group-count")}
      className={cn(
        "cn-avatar-group-count relative flex shrink-0 items-center justify-center ring-2 ring-background",
        props.className,
      )}
    />
}

module Badge = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <span
      {...props}
      dataSlot={props.dataSlot->Option.getOr("avatar-badge")}
      className={cn(
        "cn-avatar-badge absolute right-0 bottom-0 z-10 inline-flex items-center justify-center rounded-full bg-blend-color ring-2 select-none group-data-[size=sm]/avatar:size-2 group-data-[size=sm]/avatar:[&>svg]:hidden group-data-[size=default]/avatar:size-2.5 group-data-[size=default]/avatar:[&>svg]:size-2 group-data-[size=lg]/avatar:size-3 group-data-[size=lg]/avatar:[&>svg]:size-2",
        props.className,
      )}
    />
}
