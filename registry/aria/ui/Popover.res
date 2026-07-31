@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

open ReactAria.Types

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@react.component
let make = (
  ~children=?,
  ~open_=?,
  ~defaultOpen=?,
  ~onOpenChange=?,
) =>
  {
    let onOpenChange = onOpenChange->Option.map(callback => open_ => callback(open_, %raw(`undefined`)))
    <ReactAria.Dialog.Trigger
      ?children isOpen=?open_ ?defaultOpen ?onOpenChange
    />
  }

module Trigger = {
  @react.componentWithProps(Button.props)
  let make = (props: Button.props) =>
    <Button {...props} dataSlot={props.dataSlot->Option.getOr("popover-trigger")} />
}

module Content = {
  @react.component
  let make = (
    ~className=?,
    ~align=Align.Center,
    ~alignOffset=0.,
    ~side=Side.Bottom,
    ~sideOffset=4.,
    ~children=?,
    ~id=?,
    ~dir=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
  ) => {
    let placement: ReactAria.Common.placement = switch (side, align) {
    | (Top, Start) => ReactAria.Common.TopStart
    | (Top, End) => ReactAria.Common.TopEnd
    | (Top, _) => ReactAria.Common.Top
    | (Bottom, Start) => ReactAria.Common.BottomStart
    | (Bottom, End) => ReactAria.Common.BottomEnd
    | (Bottom, _) => ReactAria.Common.Bottom
    | (Left, Start) => ReactAria.Common.LeftTop
    | (Left, End) => ReactAria.Common.LeftBottom
    | (Left, _) => ReactAria.Common.Left
    | (Right, Start) => ReactAria.Common.RightTop
    | (Right, End) => ReactAria.Common.RightBottom
    | (Right, _) => ReactAria.Common.Right
    | _ => ReactAria.Common.Bottom
    }
    <ReactAria.Popover
          ?id
          ?dir
          ?style
          ?onClick
          ?onKeyDown
          ?children
          placement
          offset={sideOffset}
          crossOffset={alignOffset}
          dataSlot="popover-content"
          className={cn(
            "cn-popover-content-logical cn-popover-content cn-popover-content-aria z-50 w-72 origin-(--transform-origin) outline-hidden",
            className,
          )}
        />
  }
}

module Header = {
  @react.componentWithProps(DomProps.t)
  let make = (props: DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("popover-header")}
      className={cn("cn-popover-header", props.className)}
    />
}

module Title = {
  external toDomProps: BaseUIComponentProps.t => DomProps.t = "%identity"

  @react.componentWithProps(BaseUIComponentProps.t)
  let make = (props: BaseUIComponentProps.t) =>
    <h4 {...props->toDomProps} dataSlot={props.dataSlot->Option.getOr("popover-title")} className={cn("cn-popover-title", props.className)} />
}

module Description = {
  external toDomProps: BaseUIComponentProps.t => DomProps.t = "%identity"

  @react.componentWithProps(BaseUIComponentProps.t)
  let make = (props: BaseUIComponentProps.t) =>
    <p {...props->toDomProps} dataSlot={props.dataSlot->Option.getOr("popover-description")} className={cn("cn-popover-description", props.className)} />
}
