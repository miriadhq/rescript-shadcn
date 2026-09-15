@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@@directive("'use client'")

open BaseUi.Types

@module("cn")
external cn: (string, option<string>) => string = "cn"

@react.componentWithProps(BaseUi.Dialog.Root.props)
let make = (props: BaseUi.Dialog.Root.props<'payload>) => {
  <BaseUi.Dialog.Root {...props} dataSlot={props.dataSlot->Option.getOr("sheet")} />
}

module Trigger = {
  @react.componentWithProps(BaseUi.Dialog.Trigger.props)
  let make = (props: BaseUi.Dialog.Trigger.props<'payload>) =>
    <BaseUi.Dialog.Trigger {...props} dataSlot={props.dataSlot->Option.getOr("sheet-trigger")} />
}

module Close = {
  @react.componentWithProps(BaseUi.Dialog.Close.props)
  let make = (props: BaseUi.Dialog.Close.props) =>
    <BaseUi.Dialog.Close {...props} dataSlot={props.dataSlot->Option.getOr("sheet-close")} />
}

module Portal = {
  @react.componentWithProps(BaseUi.Dialog.Portal.props)
  let make = (props: BaseUi.Dialog.Portal.props) =>
    <BaseUi.Dialog.Portal {...props} dataSlot={props.dataSlot->Option.getOr("sheet-portal")} />
}

module Overlay = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Dialog.Backdrop
      {...props}
      dataSlot={props.dataSlot->Option.getOr("sheet-overlay")}
      className={cn(
        "cn-sheet-overlay data-open:animate-in data-closed:animate-out data-closed:fade-out-0 data-open:fade-in-0 fixed inset-0 z-50 duration-100 data-ending-style:opacity-0 data-starting-style:opacity-0",
        props.className,
      )}
    />
}

let sideToString = (side: Side.t) =>
  switch side {
  | Top => "top"
  | Bottom => "bottom"
  | Left => "left"
  | Right
  | InlineStart
  | InlineEnd => "right"
  }

module Content = {
  @react.component
  let make = (
    ~className=?,
    ~children=React.null,
    ~id=?,
    ~style=?,
    ~dir: option<string>=?,
    ~dataSidebar=?,
    ~dataSlot="sheet-content",
    ~dataMobile=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~side=Side.Right,
    ~showCloseButton=true,
  ) => {
    let style = switch (style, dir) {
    | (Some(style), Some(dir)) => Some(style->ReactDOM.Style.unsafeAddProp("direction", dir))
    | (None, Some(dir)) => Some(ReactDOM.Style._dictToStyle(dict{"direction": dir}))
    | (Some(style), None) => Some(style)
    | (None, None) => None
    }
    <Portal>
      <Overlay />
      <BaseUi.Dialog.Popup
        ?id
        style=?style
        ?onClick
        ?onKeyDown
        dataSlot
        ?dataSidebar
        ?dataMobile
        dataSide={sideToString(side)}
        className={cn(
          "cn-sheet-content bg-background data-open:animate-in data-closed:animate-out data-[side=right]:data-closed:slide-out-to-right-10 data-[side=right]:data-open:slide-in-from-right-10 data-[side=left]:data-closed:slide-out-to-left-10 data-[side=left]:data-open:slide-in-from-left-10 data-[side=top]:data-closed:slide-out-to-top-10 data-[side=top]:data-open:slide-in-from-top-10 data-closed:fade-out-0 data-open:fade-in-0 data-[side=bottom]:data-closed:slide-out-to-bottom-10 data-[side=bottom]:data-open:slide-in-from-bottom-10 fixed z-50 flex flex-col gap-4 bg-clip-padding text-sm shadow-lg transition duration-200 ease-in-out data-[side=bottom]:inset-x-0 data-[side=bottom]:bottom-0 data-[side=bottom]:h-auto data-[side=bottom]:border-t data-[side=left]:inset-y-0 data-[side=left]:left-0 data-[side=left]:h-full data-[side=left]:w-3/4 data-[side=left]:border-r data-[side=right]:inset-y-0 data-[side=right]:right-0 data-[side=right]:h-full data-[side=right]:w-3/4 data-[side=right]:border-l data-[side=top]:inset-x-0 data-[side=top]:top-0 data-[side=top]:h-auto data-[side=top]:border-b data-[side=left]:sm:max-w-sm data-[side=right]:sm:max-w-sm",
          className,
        )}
      >
        {children}
        {showCloseButton
          ? <BaseUi.Dialog.Close
              dataSlot="sheet-close"
              render={<Button
                variant=Ghost size=IconSm className="cn-sheet-close" dataSlot="sheet-close"
              />}
            >
              <Icons.X />
              <span className="sr-only"> {"Close"->React.string} </span>
            </BaseUi.Dialog.Close>
          : React.null}
      </BaseUi.Dialog.Popup>
    </Portal>
  }
}

module Header = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("sheet-header")}
      className={cn("cn-sheet-header flex flex-col", props.className)}
    />
}

module Footer = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("sheet-footer")}
      className={cn("cn-sheet-footer mt-auto flex flex-col", props.className)}
    />
}

module Title = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Dialog.Title
      {...props}
      dataSlot={props.dataSlot->Option.getOr("sheet-title")}
      className={cn("cn-sheet-title cn-font-heading", props.className)}
    />
}

module Description = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Dialog.Description
      {...props}
      dataSlot={props.dataSlot->Option.getOr("sheet-description")}
      className={cn("cn-sheet-description", props.className)}
    />
}
