@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

open BaseUi.Types

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@react.component
let make = (
  ~children=?,
  ~open_=?,
  ~defaultOpen=?,
  ~onOpenChange=?,
  ~onOpenChangeComplete=?,
  ~modal=?,
) =>
  <BaseUi.Popover.Root ?children ?open_ ?defaultOpen ?onOpenChange ?onOpenChangeComplete ?modal />

module Trigger = {
  @react.componentWithProps(BaseUi.Popover.Trigger.props)
  let make = (props: BaseUi.Popover.Trigger.props<'payload>) =>
    <BaseUi.Popover.Trigger {...props} dataSlot={props.dataSlot->Option.getOr("popover-trigger")} />
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
  ) =>
    <BaseUi.Popover.Portal>
      <BaseUi.Popover.Positioner
        align
        alignOffset={Const(alignOffset)}
        side
        sideOffset={Const(sideOffset)}
        className="isolate z-50"
      >
        <BaseUi.Popover.Popup
          ?id
          ?dir
          ?style
          ?onClick
          ?onKeyDown
          ?children
          dataSlot="popover-content"
          className={cn(
            "bg-popover text-popover-foreground data-open:animate-in data-closed:animate-out data-closed:fade-out-0 data-open:fade-in-0 data-closed:zoom-out-95 data-open:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 ring-foreground/10 data-[side=inline-start]:slide-in-from-right-2 data-[side=inline-end]:slide-in-from-left-2 z-50 flex w-72 origin-(--transform-origin) flex-col gap-2.5 rounded-lg p-2.5 text-sm shadow-md ring-1 outline-hidden duration-100",
            className,
          )}
        />
      </BaseUi.Popover.Positioner>
    </BaseUi.Popover.Portal>
}

module Header = {
  @react.componentWithProps(DomProps.t)
  let make = (props: DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("popover-header")}
      className={cn("flex flex-col gap-0.5 text-sm", props.className)}
    />
}

module Title = {
  @react.componentWithProps(BaseUIComponentProps.t)
  let make = (props: BaseUIComponentProps.t) =>
    <BaseUi.Popover.Title
      {...props}
      dataSlot={props.dataSlot->Option.getOr("popover-title")}
      className={cn("font-medium", props.className)}
    />
}

module Description = {
  @react.componentWithProps(BaseUIComponentProps.t)
  let make = (props: BaseUIComponentProps.t) =>
    <BaseUi.Popover.Description
      {...props}
      dataSlot={props.dataSlot->Option.getOr("popover-description")}
      className={cn("text-muted-foreground", props.className)}
    />
}
