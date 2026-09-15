@@directive("'use client'")

open BaseUi.Types

@module("cn")
external cn: (string, option<string>) => string = "cn"

module Variant = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("line") Line
}

let tabsListVariants = (~variant=Variant.Default) => {
  let base = "cn-tabs-list group/tabs-list text-muted-foreground inline-flex w-fit items-center justify-center group-data-vertical/tabs:h-fit group-data-vertical/tabs:flex-col"
  let variantClass = switch variant {
  | Line => "cn-tabs-list-variant-line gap-1 bg-transparent"
  | Default => "cn-tabs-list-variant-default bg-muted"
  }
  `${base} ${variantClass}`
}

@react.componentWithProps(BaseUi.Tabs.Root.props)
let make = (props: BaseUi.Tabs.Root.props<'value>) => {
  let orientation = props.orientation->Option.getOr(Orientation.Horizontal)
  <BaseUi.Tabs.Root
    {...props}
    orientation
    dataOrientation={props.dataOrientation->Option.getOr((orientation :> string))}
    dataSlot={props.dataSlot->Option.getOr("tabs")}
    className={cn("cn-tabs group/tabs flex data-horizontal:flex-col", props.className)}
  />
}

module List = {
  type props = {
    ...BaseUi.Tabs.List.props,
    variant?: Variant.t,
  }

  let toBaseUiProps: props => BaseUi.Tabs.List.props = %raw(`({variant, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let variant = props.variant->Option.getOr(Variant.Default)
    <BaseUi.Tabs.List
      {...props->toBaseUiProps}
      dataSlot={props.dataSlot->Option.getOr("tabs-list")}
      dataVariant={props.dataVariant->Option.getOr((variant :> string))}
      className={cn(tabsListVariants(~variant), props.className)}
    />
  }
}

module Trigger = {
  @react.componentWithProps(BaseUi.Tabs.Tab.props)
  let make = (props: BaseUi.Tabs.Tab.props<'value>) =>
    <BaseUi.Tabs.Tab
      {...props}
      dataSlot={props.dataSlot->Option.getOr("tabs-trigger")}
      className={cn(
        "cn-tabs-trigger relative inline-flex h-[calc(100%-1px)] flex-1 items-center justify-center whitespace-nowrap text-foreground/60 transition-all group-data-vertical/tabs:w-full group-data-vertical/tabs:justify-start hover:text-foreground focus-visible:border-ring focus-visible:ring-[3px] focus-visible:ring-ring/50 focus-visible:outline-1 focus-visible:outline-ring disabled:pointer-events-none disabled:opacity-50 aria-disabled:pointer-events-none aria-disabled:opacity-50 dark:text-muted-foreground dark:hover:text-foreground [&_svg]:pointer-events-none [&_svg]:shrink-0 group-data-[variant=line]/tabs-list:bg-transparent group-data-[variant=line]/tabs-list:data-active:bg-transparent dark:group-data-[variant=line]/tabs-list:data-active:border-transparent dark:group-data-[variant=line]/tabs-list:data-active:bg-transparent data-active:bg-background data-active:text-foreground dark:data-active:border-input dark:data-active:bg-input/30 dark:data-active:text-foreground after:absolute after:bg-foreground after:opacity-0 after:transition-opacity group-data-horizontal/tabs:after:inset-x-0 group-data-horizontal/tabs:after:bottom-[-5px] group-data-horizontal/tabs:after:h-0.5 group-data-vertical/tabs:after:inset-y-0 group-data-vertical/tabs:after:-right-1 group-data-vertical/tabs:after:w-0.5 group-data-[variant=line]/tabs-list:data-active:after:opacity-100",
        props.className,
      )}
    />
}

module Content = {
  @react.componentWithProps(BaseUi.Tabs.Panel.props)
  let make = (props: BaseUi.Tabs.Panel.props<'value>) =>
    <BaseUi.Tabs.Panel
      {...props}
      dataSlot={props.dataSlot->Option.getOr("tabs-content")}
      className={cn("cn-tabs-content flex-1 outline-none", props.className)}
    />
}
