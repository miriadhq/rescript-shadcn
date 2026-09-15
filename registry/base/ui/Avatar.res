@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@module("cn")
external cn: (string, option<string>) => string = "cn"

@module("cn")
external cn5: (string, string, string, string, option<string>) => string = "cn"

module Size = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("sm") Sm
    | @as("lg") Lg
}

type props = {
  ...BaseUi.Types.BaseUIComponentProps.t,
  size?: Size.t,
}

let toBaseUiProps: props => BaseUi.Types.BaseUIComponentProps.t = %raw(`({size, ...props}) => props`)

@react.componentWithProps(props)
let make = (props: props) => {
  let size = props.size->Option.getOr(Size.Default)
  <BaseUi.Avatar.Root
    {...props->toBaseUiProps}
    dataSlot={props.dataSlot->Option.getOr("avatar")}
    dataSize={props.dataSize->Option.getOr((size :> string))}
    className={cn(
      "cn-avatar after:border-border group/avatar relative flex shrink-0 select-none after:absolute after:inset-0 after:border after:mix-blend-darken dark:after:mix-blend-lighten",
      props.className,
    )}
  />
}

module Image = {
  type props = BaseUi.Avatar.Image.props

  let toBaseUiProps: props => props = %raw(`({className, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) =>
    <BaseUi.Avatar.Image
      {...toBaseUiProps(props)}
      dataSlot={props.dataSlot->Option.getOr("avatar-image")}
      className={cn("cn-avatar-image aspect-square size-full object-cover", props.className)}
    />
}

module Fallback = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Avatar.Fallback
      {...props}
      dataSlot={props.dataSlot->Option.getOr("avatar-fallback")}
      className={cn(
        "cn-avatar-fallback flex size-full items-center justify-center text-sm group-data-[size=sm]/avatar:text-xs",
        props.className,
      )}
    />
}

module Group = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("avatar-group")}
      className={cn(
        "cn-avatar-group *:data-[slot=avatar]:ring-background group/avatar-group flex -space-x-2 *:data-[slot=avatar]:ring-2",
        props.className,
      )}
    />
}

module GroupCount = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("avatar-group-count")}
      className={cn(
        "cn-avatar-group-count ring-background relative flex shrink-0 items-center justify-center ring-2",
        props.className,
      )}
    />
}

module Badge = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <span
      {...props}
      dataSlot={props.dataSlot->Option.getOr("avatar-badge")}
      className={cn5(
        "cn-avatar-badge absolute right-0 bottom-0 z-10 inline-flex items-center justify-center rounded-full bg-blend-color ring-2 select-none",
        "group-data-[size=sm]/avatar:size-2 group-data-[size=sm]/avatar:[&>svg]:hidden",
        "group-data-[size=default]/avatar:size-2.5 group-data-[size=default]/avatar:[&>svg]:size-2",
        "group-data-[size=lg]/avatar:size-3 group-data-[size=lg]/avatar:[&>svg]:size-2",
        props.className,
      )}
    />
}
