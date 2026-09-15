open BaseUi.Types

@module("cn")
external cn: (string, option<string>) => string = "cn"

let navigationMenuTriggerStyle = () =>
  "cn-navigation-menu-trigger group/navigation-menu-trigger inline-flex h-9 w-max items-center justify-center disabled:pointer-events-none outline-none"

type props<'value> = {
  ...BaseUi.NavigationMenu.Root.props<'value>,
  align?: Align.t,
}

let toBaseUiProps: props<'value> => BaseUi.NavigationMenu.Root.props<
  'value,
> = %raw(`({align, ...props}) => props`)

@react.componentWithProps(props)
let make = (props: props<'value>) => {
  let children = props.children->Option.getOr(React.null)
  let align = props.align->Option.getOr(Align.Start)
  <BaseUi.NavigationMenu.Root
    {...props->toBaseUiProps}
    dataSlot={props.dataSlot->Option.getOr("navigation-menu")}
    className={cn(
      "cn-navigation-menu group/navigation-menu relative flex max-w-max flex-1 items-center justify-center",
      props.className,
    )}
  >
    {children}
    <BaseUi.NavigationMenu.Portal>
      <BaseUi.NavigationMenu.Positioner
        side={Side.Bottom}
        sideOffset={Const(8.)}
        align
        alignOffset={Const(0.)}
        className="cn-navigation-menu-positioner isolate z-50 h-(--positioner-height) w-(--positioner-width) max-w-(--available-width) transition-[top,left,right,bottom] duration-[0.35s] ease-[cubic-bezier(0.22,1,0.36,1)] data-instant:transition-none data-[side=bottom]:before:top-[-10px] data-[side=bottom]:before:right-0 data-[side=bottom]:before:left-0"
      >
        <BaseUi.NavigationMenu.Popup
          className="cn-navigation-menu-popup bg-popover text-popover-foreground ring-foreground/10 data-[ending-style]:easing-[ease] xs:w-(--popup-width) relative h-(--popup-height) w-(--popup-width) origin-(--transform-origin) rounded-lg shadow ring-1 transition-[opacity,transform,width,height,scale,translate] duration-[0.35s] ease-[cubic-bezier(0.22,1,0.36,1)] outline-none data-ending-style:scale-90 data-ending-style:opacity-0 data-ending-style:duration-150 data-starting-style:scale-90 data-starting-style:opacity-0"
        >
          <BaseUi.NavigationMenu.Viewport className="relative size-full overflow-hidden" />
        </BaseUi.NavigationMenu.Popup>
      </BaseUi.NavigationMenu.Positioner>
    </BaseUi.NavigationMenu.Portal>
  </BaseUi.NavigationMenu.Root>
}

module List = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.NavigationMenu.List
      {...props}
      dataSlot={props.dataSlot->Option.getOr("navigation-menu-list")}
      className={cn(
        "cn-navigation-menu-list group flex flex-1 list-none items-center justify-center",
        props.className,
      )}
    />
}

module Item = {
  @react.componentWithProps(BaseUi.NavigationMenu.Item.props)
  let make = (props: BaseUi.NavigationMenu.Item.props<'value>) =>
    <BaseUi.NavigationMenu.Item
      {...props}
      dataSlot={props.dataSlot->Option.getOr("navigation-menu-item")}
      className={cn("cn-navigation-menu-item relative", props.className)}
    />
}

module Trigger = {
  @react.componentWithProps(BaseUi.NavigationMenu.Trigger.props)
  let make = (props: BaseUi.NavigationMenu.Trigger.props) => {
    let type_ = switch (props.type_, props.nativeButton, props.render) {
    | (Some(type_), _, _) => Some(type_)
    | (None, Some(false), _)
    | (None, _, Some(_)) =>
      None
    | (None, _, _) => Some(Button)
    }
    <BaseUi.NavigationMenu.Trigger
      {...props}
      ?type_
      dataSlot={props.dataSlot->Option.getOr("navigation-menu-trigger")}
      className={cn(`${navigationMenuTriggerStyle()} group`, props.className)}
    >
      {props.children->Option.getOr(React.null)}
      <Icons.ChevronDown ariaHidden=true className="cn-navigation-menu-trigger-icon" />
    </BaseUi.NavigationMenu.Trigger>
  }
}

module Content = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.NavigationMenu.Content
      {...props}
      dataSlot={props.dataSlot->Option.getOr("navigation-menu-content")}
      className={cn(
        "cn-navigation-menu-content data-ending-style:data-activation-direction=left:translate-x-[50%] data-ending-style:data-activation-direction=right:translate-x-[-50%] data-starting-style:data-activation-direction=left:translate-x-[-50%] data-starting-style:data-activation-direction=right:translate-x-[50%] h-full w-auto transition-[opacity,transform,translate] duration-[0.35s] data-ending-style:opacity-0 data-starting-style:opacity-0 **:data-[slot=navigation-menu-link]:focus:ring-0 **:data-[slot=navigation-menu-link]:focus:outline-none",
        props.className,
      )}
    />
}

module Positioner = {
  type props = {
    ...BaseUi.Types.BaseUIComponentProps.t,
    ...BaseUi.AnchorPositioning.SharedParametersWithoutOffsets.t,
    sideOffset?: float,
    alignOffset?: float,
  }

  let toBaseUiProps: props => BaseUi.NavigationMenu.Positioner.props = %raw(`({sideOffset, alignOffset, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let children = props.children
    let side = props.side->Option.getOr(Side.Bottom)
    let sideOffset = props.sideOffset->Option.getOr(8.)
    let align = props.align->Option.getOr(Align.Start)
    let alignOffset = props.alignOffset->Option.getOr(0.)
    <BaseUi.NavigationMenu.Portal>
      <BaseUi.NavigationMenu.Positioner
        {...props->toBaseUiProps}
        side
        sideOffset={Const(sideOffset)}
        align
        alignOffset={Const(alignOffset)}
        className={cn(
          "cn-navigation-menu-positioner isolate z-50 h-(--positioner-height) w-(--positioner-width) max-w-(--available-width) transition-[top,left,right,bottom] duration-[0.35s] ease-[cubic-bezier(0.22,1,0.36,1)] data-instant:transition-none data-[side=bottom]:before:top-[-10px] data-[side=bottom]:before:right-0 data-[side=bottom]:before:left-0",
          props.className,
        )}
      >
        {switch children {
        | Some(value) => value
        | None =>
          <BaseUi.NavigationMenu.Popup
            className="cn-navigation-menu-popup bg-popover text-popover-foreground ring-foreground/10 data-[ending-style]:easing-[ease] xs:w-(--popup-width) relative h-(--popup-height) w-(--popup-width) origin-(--transform-origin) rounded-lg shadow ring-1 transition-[opacity,transform,width,height,scale,translate] duration-[0.35s] ease-[cubic-bezier(0.22,1,0.36,1)] outline-none data-ending-style:scale-90 data-ending-style:opacity-0 data-ending-style:duration-150 data-starting-style:scale-90 data-starting-style:opacity-0"
          >
            <BaseUi.NavigationMenu.Viewport className="relative size-full overflow-hidden" />
          </BaseUi.NavigationMenu.Popup>
        }}
      </BaseUi.NavigationMenu.Positioner>
    </BaseUi.NavigationMenu.Portal>
  }
}

module Link = {
  @react.componentWithProps(BaseUi.NavigationMenu.Link.props)
  let make = (props: BaseUi.NavigationMenu.Link.props) =>
    <BaseUi.NavigationMenu.Link
      {...props}
      dataSlot={props.dataSlot->Option.getOr("navigation-menu-link")}
      className={cn("cn-navigation-menu-link", props.className)}
    />
}

module Indicator = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.NavigationMenu.Icon
      {...props}
      dataSlot={props.dataSlot->Option.getOr("navigation-menu-indicator")}
      className={cn(
        "cn-navigation-menu-indicator top-full z-1 flex h-1.5 items-end justify-center overflow-hidden",
        props.className,
      )}
    >
      <div className="cn-navigation-menu-indicator-arrow relative top-[60%] h-2 w-2 rotate-45" />
    </BaseUi.NavigationMenu.Icon>
}
