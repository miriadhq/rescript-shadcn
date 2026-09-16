@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@@directive("'use client'")

@module("cn")
external cn: (string, option<string>) => string = "cn"

@react.componentWithProps(BaseUi.Dialog.Root.props)
let make = (props: BaseUi.Dialog.Root.props<'payload>) =>
  <BaseUi.Dialog.Root {...props} dataSlot={props.dataSlot->Option.getOr("sheet")} />

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
        "cn-sheet-overlay fixed inset-0 z-50 transition-opacity duration-150 data-ending-style:opacity-0 data-starting-style:opacity-0",
        props.className,
      )}
    />
}

module Side = {
  @unboxed
  type t =
    | @as("top") Top
    | @as("right") Right
    | @as("bottom") Bottom
    | @as("left") Left
}

module Content = {
  type props = {
    ...BaseUi.Types.BaseUIComponentProps.t,
    side?: Side.t,
    showCloseButton?: bool,
  }

  let toBaseUiProps: props => BaseUi.Types.BaseUIComponentProps.t = %raw(`({side, showCloseButton, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let children = props.children->Option.getOr(React.null)
    let dataSlot = props.dataSlot->Option.getOr("sheet-content")
    let side = props.side->Option.getOr(Side.Right)
    let showCloseButton = props.showCloseButton->Option.getOr(true)
    <Portal>
      <Overlay />
      <BaseUi.Dialog.Popup
        {...props->toBaseUiProps}
        dataSlot
        dataSide={(side :> string)}
        className={cn(
          "cn-sheet-content data-ending-style:opacity-0 data-starting-style:opacity-0 data-[side=bottom]:data-ending-style:translate-y-[2.5rem] data-[side=bottom]:data-starting-style:translate-y-[2.5rem] data-[side=left]:data-ending-style:translate-x-[-2.5rem] data-[side=left]:data-starting-style:translate-x-[-2.5rem] data-[side=right]:data-ending-style:translate-x-[2.5rem] data-[side=right]:data-starting-style:translate-x-[2.5rem] data-[side=top]:data-ending-style:translate-y-[-2.5rem] data-[side=top]:data-starting-style:translate-y-[-2.5rem]",
          props.className,
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
