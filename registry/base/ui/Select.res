@@directive("'use client'")

open BaseUi.Types

@module("cn")
external cn: (string, option<string>) => string = "cn"

module Size = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("sm") Sm
}

let make = BaseUi.Select.Root.make

module Multiple = {
  @react.componentWithProps(BaseUi.Select.Root.Multiple.props)
  let make = (props: BaseUi.Select.Root.Multiple.props<'value>) =>
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
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Select.Value
      {...props}
      dataSlot={props.dataSlot->Option.getOr("select-value")}
      className={cn("cn-select-value", props.className)}
    />
}

module ScrollUpButton = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Select.ScrollUpArrow
      {...props}
      dataSlot={props.dataSlot->Option.getOr("select-scroll-up-button")}
      className={cn("cn-select-scroll-up-button top-0 w-full", props.className)}
    >
      <Icons.ChevronUp />
    </BaseUi.Select.ScrollUpArrow>
}

module ScrollDownButton = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Select.ScrollDownArrow
      {...props}
      dataSlot={props.dataSlot->Option.getOr("select-scroll-down-button")}
      className={cn("cn-select-scroll-down-button bottom-0 w-full", props.className)}
    >
      <Icons.ChevronDown />
    </BaseUi.Select.ScrollDownArrow>
}

module Trigger = {
  type triggerProps = {
    size?: Size.t,
    ...BaseUi.Select.Trigger.props,
  }
  let toBaseUiProps: triggerProps => BaseUi.Select.Trigger.props = %raw(`({size, ...rest}) => rest`)
  @react.componentWithProps(triggerProps)
  let make = (props: triggerProps) => {
    let size = props.size->Option.getOr(Default)
    let baseUiProps = props->toBaseUiProps
    <BaseUi.Select.Trigger
      {...baseUiProps}
      dataSlot={props.dataSlot->Option.getOr("select-trigger")}
      dataSize={props.dataSize->Option.getOr((size :> string))}
      className={cn(
        "cn-select-trigger flex w-fit items-center justify-between whitespace-nowrap outline-none disabled:cursor-not-allowed disabled:opacity-50 *:data-[slot=select-value]:line-clamp-1 *:data-[slot=select-value]:flex *:data-[slot=select-value]:items-center [&_svg]:pointer-events-none [&_svg]:shrink-0",
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
  type props = {
    align?: Align.t,
    alignOffset?: float,
    side?: Side.t,
    sideOffset?: float,
    ...BaseUi.Types.BaseUIComponentProps.t,
  }

  let toBaseUiProps: props => BaseUi.Types.BaseUIComponentProps.t = %raw(`({align, alignOffset, side, sideOffset, "data-align-trigger": dataAlignTrigger, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let alignItemWithTrigger = props.dataAlignTrigger->Option.getOr(true)
    <BaseUi.Select.Portal>
      <BaseUi.Select.Positioner
        side={props.side->Option.getOr(Side.Bottom)}
        sideOffset={Const(props.sideOffset->Option.getOr(4.))}
        align={props.align->Option.getOr(Align.Center)}
        alignOffset={Const(props.alignOffset->Option.getOr(0.))}
        alignItemWithTrigger
        className="isolate z-50"
      >
        <BaseUi.Select.Popup
          {...toBaseUiProps(props)}
          dataSlot={props.dataSlot->Option.getOr("select-content")}
          dataAlignTrigger={alignItemWithTrigger}
          className={cn(
            "cn-select-content-logical cn-select-content cn-menu-target cn-menu-translucent relative isolate z-50 max-h-(--available-height) w-(--anchor-width) origin-(--transform-origin) overflow-x-hidden overflow-y-auto data-[align-trigger=true]:animate-none",
            props.className,
          )}
        >
          <ScrollUpButton />
          <BaseUi.Select.List children=?props.children />
          <ScrollDownButton />
        </BaseUi.Select.Popup>
      </BaseUi.Select.Positioner>
    </BaseUi.Select.Portal>
  }
}

module Label = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Select.GroupLabel
      {...props}
      dataSlot={props.dataSlot->Option.getOr("select-label")}
      className={cn("cn-select-label", props.className)}
    />
}

module Item = {
  @react.componentWithProps(BaseUi.Select.Item.props)
  let make = (props: BaseUi.Select.Item.props<'value>) => {
    let children = props.children
    <BaseUi.Select.Item
      {...props}
      dataSlot={props.dataSlot->Option.getOr("select-item")}
      className={cn(
        "cn-select-item relative flex w-full cursor-default items-center outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0",
        props.className,
      )}
    >
      <BaseUi.Select.ItemText
        className="cn-select-item-text shrink-0 whitespace-nowrap" ?children
      />
      <BaseUi.Select.ItemIndicator render={<span className="cn-select-item-indicator" />}>
        <Icons.Check className="cn-select-item-indicator-icon pointer-events-none" />
      </BaseUi.Select.ItemIndicator>
    </BaseUi.Select.Item>
  }
}

module Separator = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Select.Separator
      {...props}
      dataSlot={props.dataSlot->Option.getOr("select-separator")}
      className={cn("cn-select-separator pointer-events-none", props.className)}
    />
}
