@@directive("'use client'")

open ReactAria.Types

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

type providerConfig = {
  delay: option<float>,
  closeDelay: option<float>,
}

let providerContext = React.createContext({delay: None, closeDelay: None})

module ProviderContext = {
  let make = React.Context.provider(providerContext)
}

@react.component
let make = (
  ~children=?,
  ~open_=?,
  ~defaultOpen=?,
  ~onOpenChange=?,
  ~delay=?,
  ~closeDelay=?,
) => {
  let provider = React.useContext(providerContext)
  let delay = delay->Option.orElse(provider.delay)
  let closeDelay = closeDelay->Option.orElse(provider.closeDelay)
  let onOpenChange = onOpenChange->Option.map(callback => open_ => callback(open_, %raw(`undefined`)))
  <ReactAria.Tooltip.Trigger
    ?children isOpen=?open_ ?defaultOpen ?onOpenChange ?delay ?closeDelay
  />
}

module Provider = {
  @react.component
  let make = (~children=?, ~delay=0., ~closeDelay=?) =>
    <ProviderContext value={{delay: Some(delay), closeDelay}}>
      {children->Option.getOr(React.null)}
    </ProviderContext>
}

module Trigger = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~id=?,
    ~disabled=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~ariaLabel=?,
    ~render=?,
    ~style=?,
  ) =>
    <Button
      ?className
      ?children
      ?id
      ?disabled
      ?onClick
      ?onKeyDown
      ?ariaLabel
      ?render
      ?style
      dataSlot="tooltip-trigger"
    />
}

type contentProps = {
  className?: string,
  children: React.element,
  id?: string,
  dir?: ReactAria.Types.TextDirection.t,
  style?: ReactDOM.style,
  onClick?: ReactEvent.Mouse.t => unit,
  onKeyDown?: ReactEvent.Keyboard.t => unit,
  align?: Align.t,
  alignOffset?: float,
  side?: Side.t,
  sideOffset?: float,
  hidden?: bool,
}

module Content = {
  @react.component(: contentProps)
  let make = (
    ~className=?,
    ~children,
    ~id=?,
    ~dir=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~align=Align.Center,
    ~alignOffset=0.,
    ~side=Side.Top,
    ~sideOffset=4.,
    ~hidden=?,
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
    | _ => ReactAria.Common.Top
    }
    <ReactAria.Tooltip
          ?id
          dir=?{(dir :> option<string>)}
          ?style
          ?onClick
          ?onKeyDown
          dataSlot="tooltip-content"
          className={cn(
            "cn-tooltip-content cn-tooltip-content-aria cn-tooltip-content-logical data-open:animate-in data-open:fade-in-0 data-open:zoom-in-95 data-[state=delayed-open]:animate-in data-[state=delayed-open]:fade-in-0 data-[state=delayed-open]:zoom-in-95 data-closed:animate-out data-closed:fade-out-0 data-closed:zoom-out-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 bg-foreground text-background z-50 w-fit max-w-xs origin-(--transform-origin) rounded-md px-3 py-1.5 text-xs",
            className,
          )}
          ?hidden
          placement
          offset={sideOffset}
          crossOffset={alignOffset}
        >
          {children}
          <ReactAria.Tooltip.Arrow
            className="cn-tooltip-arrow cn-tooltip-arrow-logical bg-foreground fill-foreground z-50 data-[side=bottom]:top-1 data-[side=left]:top-1/2! data-[side=left]:-right-1 data-[side=left]:-translate-y-1/2 data-[side=right]:top-1/2! data-[side=right]:-left-1 data-[side=right]:-translate-y-1/2 data-[side=top]:-bottom-2.5"
          />
        </ReactAria.Tooltip>
  }
}
