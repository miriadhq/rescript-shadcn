@@directive("'use client'")

open BaseUi.Types

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Size = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("sm") Sm
}

let make = BaseUi.Select.Root.make

module Multiple = {
  type props<'value> = {...BaseUi.Select.Root.Multiple.props<'value>}

  @react.componentWithProps(props)
  let make = ({...BaseUi.Select.Root.Multiple.props as props}) =>
    <BaseUi.Select.Root.Multiple {...props} multiple=True />
}

module Group = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Select.Group
      {...props}
      dataSlot={props.dataSlot->Option.getOr("select-group")}
      className={cn("cn-select-group", props.className)}
    />
}

module Value = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~placeholder=?) =>
    <BaseUi.Select.Value
      ?id
      ?style
      ?placeholder
      ?children
      dataSlot="select-value"
      className={cn("cn-select-value", className)}
    />
}

module ScrollUpButton = {
  @react.component
  let make = (~className=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <BaseUi.Select.ScrollUpArrow
      ?id
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="select-scroll-up-button"
      className={cn("cn-select-scroll-up-button top-0 w-full", className)}
    >
      <Icons.ChevronUp />
    </BaseUi.Select.ScrollUpArrow>
}

module ScrollDownButton = {
  @react.component
  let make = (~className=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <BaseUi.Select.ScrollDownArrow
      ?id
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="select-scroll-down-button"
      className={cn("cn-select-scroll-down-button bottom-0 w-full", className)}
    >
      <Icons.ChevronDown />
    </BaseUi.Select.ScrollDownArrow>
}

module Trigger = {
  type props = {
    size?: Size.t,
    ...BaseUi.Types.BaseUIComponentProps.t,
  }
  @react.componentWithProps(props)
  let make = ({?size, ...BaseUi.Types.BaseUIComponentProps.t as props}) => {
    let size = size->Option.getOr(Default)
    <BaseUi.Select.Trigger
      {...props}
      dataSlot={props.dataSlot->Option.getOr("select-trigger")}
      dataSize={(size :> string)}
      className={cn(
        "cn-select-trigger flex w-fit items-center justify-between whitespace-nowrap outline-none disabled:cursor-not-allowed disabled:opacity-50 *:data-[slot=select-value]:line-clamp-1 *:data-[slot=select-value]:items-center [&_svg]:pointer-events-none [&_svg]:shrink-0",
        props.className,
      )}
    >
      {props.children->Option.getOr(React.null)}
      <BaseUi.Select.Icon
        render={<Icons.ChevronDown className="cn-select-trigger-icon pointer-events-none" />}
      />
    </BaseUi.Select.Trigger>
  }
}

module Content = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~side=Side.Bottom,
    ~sideOffset=4.,
    ~align=Align.Center,
    ~alignOffset=0.,
    ~dataAlignTrigger=true,
  ) => {
    let alignItemWithTrigger = dataAlignTrigger
    <BaseUi.Select.Portal>
      <BaseUi.Select.Positioner
        side
        sideOffset={Const(sideOffset)}
        align
        alignOffset={Const(alignOffset)}
        alignItemWithTrigger
        className="isolate z-50"
      >
        <BaseUi.Select.Popup
          ?id
          ?style
          ?onClick
          ?onKeyDown
          dataSlot="select-content"
          dataAlignTrigger={alignItemWithTrigger}
          className={cn(
            "cn-select-content-logical cn-select-content cn-menu-target cn-menu-translucent relative isolate z-50 max-h-(--available-height) w-(--anchor-width) origin-(--transform-origin) overflow-x-hidden overflow-y-auto data-[align-trigger=true]:animate-none",
            className,
          )}
        >
          <ScrollUpButton />
          <BaseUi.Select.List ?children />
          <ScrollDownButton />
        </BaseUi.Select.Popup>
      </BaseUi.Select.Positioner>
    </BaseUi.Select.Portal>
  }
}

module Label = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <BaseUi.Select.GroupLabel
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?children
      dataSlot="select-label"
      className={cn("cn-select-label", className)}
    />
}

module Item = {
  type props<'value> = {...BaseUi.Select.Item.props<'value>}

  @react.componentWithProps(props)
  let make = ({...BaseUi.Select.Item.props as props}) =>
    <BaseUi.Select.Item
      {...props}
      dataSlot="select-item"
      className={cn(
        "cn-select-item relative flex w-full cursor-default items-center outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0",
        props.className,
      )}
    >
      <BaseUi.Select.ItemText
        className="cn-select-item-text shrink-0 whitespace-nowrap" children=?props.children
      />
      <BaseUi.Select.ItemIndicator render={<span className="cn-select-item-indicator" />}>
        <Icons.Check className="cn-select-item-indicator-icon pointer-events-none" />
      </BaseUi.Select.ItemIndicator>
    </BaseUi.Select.Item>
}

module Separator = {
  @react.component
  let make = (~className=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <BaseUi.Select.Separator
      ?id
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="select-separator"
      className={cn("cn-select-separator pointer-events-none", className)}
    />
}
