@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

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

@react.componentWithProps(props)
let make = (props: ReactAria.Tabs.props) =>
  <ReactAria.Tabs
    {...props}
    dataSlot="tabs"
    className={cn("cn-tabs group/tabs flex data-horizontal:flex-col", props.className)}
  />

module List = {
  type props<'item> = {variant?: Variant.t, ...ReactAria.Tabs.List.props<'item>}

  @react.componentWithProps(ReactAria.Tabs.List.props)
  let make = ({?variant, ...ReactAria.Tabs.List.props<'item> as props}) => {
    let variant = variant->Option.getOr(Default)
    <ReactAria.Tabs.List
      {...props}
      dataSlot="tabs-list"
      dataVariant={(variant :> string)}
      className={cn(tabsListVariants(~variant), props.className)}
    />
  }
}

module Trigger = {
  @react.componentWithProps(props)
  let make = (props: ReactAria.Tabs.Tab.props) =>
    <ReactAria.Tabs.Tab
      {...props}
      dataSlot="tabs-trigger"
      className={cn(
        "cn-tabs-trigger cn-tabs-trigger-aria relative inline-flex h-[calc(100%-1px)] flex-1 cursor-default items-center justify-center whitespace-nowrap text-foreground/60 transition-all group-data-vertical/tabs:w-full group-data-vertical/tabs:justify-start hover:text-foreground focus-visible:border-ring focus-visible:ring-[3px] focus-visible:ring-ring/50 focus-visible:outline-1 focus-visible:outline-ring disabled:pointer-events-none disabled:opacity-50 data-[disabled]:pointer-events-none data-[disabled]:opacity-50 dark:text-muted-foreground dark:hover:text-foreground [&_svg]:pointer-events-none [&_svg]:shrink-0 group-data-[variant=line]/tabs-list:bg-transparent group-data-[variant=line]/tabs-list:data-selected:bg-transparent dark:group-data-[variant=line]/tabs-list:data-selected:border-transparent dark:group-data-[variant=line]/tabs-list:data-selected:bg-transparent data-selected:bg-background data-selected:text-foreground dark:data-selected:border-input dark:data-selected:bg-input/30 dark:data-selected:text-foreground after:absolute after:bg-foreground after:opacity-0 after:transition-opacity group-data-horizontal/tabs:after:inset-x-0 group-data-horizontal/tabs:after:bottom-[-5px] group-data-horizontal/tabs:after:h-0.5 group-data-vertical/tabs:after:inset-y-0 group-data-vertical/tabs:after:-right-1 group-data-vertical/tabs:after:w-0.5 group-data-[variant=line]/tabs-list:data-selected:after:opacity-100",
        props.className,
      )}
    />
}

module Content = {
  @react.componentWithProps(props)
  let make = (props: ReactAria.Tabs.Panel.props) =>
    <ReactAria.Tabs.Panel
      {...props}
      dataSlot="tabs-content"
      className={cn("cn-tabs-content flex-1 outline-none", props.className)}
    />
}
